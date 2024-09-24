/*
Platform Fighter Engine - Server:
(Last Modified: 9/15/2024)

Copyright 2024 Springroll Games / Yosi
*/
//Requires
const fs = require('fs');
const dgram = require("dgram");

console.log("The server has been started!");

last_timestamp = Date.now();

//Server Variables
var server = {};
server.match_id_counter = 0;
server.supported_game_versions = [ //All versions of the game that the server can separately matchmake for.
	"1.4.4",
];
server.server_keys = { //Any packets that don't have the correct key will be completely ignored.
	random_matchmaking: "---",
	private_lobby: "---",
};
server.random_matchmaking_limit = 2; //How many players can be in the array at once
server.holepunching_pairs_limit = 1000; //How many players can be holepunching at the same time
server.private_lobby_limit = 500; //How many private lobbies can be open at the same time
server.random_matchmaking_inactive_timer = 7; //How long it takes before someone is removed from the matchmaking list, in seconds
server.holepunching_pairs_inactive_timer = 7; //How long it takes before someone is removed from the holepunching map, in seconds
server.private_lobby_inactive_timer = 600; //How long it takes before someone is removed from the private lobby map, in seconds
server.logging_interval = 14400;//3600; //The time between each log file is created, in seconds
server.log_connected_ips = false;
server.udp_port = 63567;
server.latest_version = "1.4.4";
server.news = "There is no news or announcements!";

//Data structures
var random_matchmaking_lists = new Map();
var holepunching_pairs_map = new Map();
var private_lobby_maps = new Map();
var matches_log = []; //Logs the IP addresses of match pairs. A new file is created for each time.
var debug_log = []; //Logs the debug messages of the server. A new file is created for each time.
var error_log = []; //Logs any error messages. A new file is created for each time.
var stats_log = { //Logs server lifetime stats. Only one file is used.
	total_matches: 0,
	total_holepunches_expired: 0,
	total_lobbies_expired: 0,
	sent_packets: 0,
	received_packets: 0,
	invalid_packets: 0,
	invalid_typed_packets: 0,
};

//Load stats from file
var old_stats = load_file("./logs/stats_log.json");
if (old_stats != null) {
	stats_log = old_stats;
}

//Configurations - load from the file
var config = load_file("config.json");
if (config != null) {
	//Only override the values that are in the config object
	for (const [key, value] of Object.entries(config)) {
		server[key] = value;
	}
}

//Create the random matchmaking / private lobby data structures for each version
for (let i = 0; i < server.supported_game_versions.length; i++) {
	let version = server.supported_game_versions[i];
	console.log("Creating data structures for version", version);
	random_matchmaking_lists.set(version, []);
	private_lobby_maps.set(version, new Map());
}

//Starting the server
const socket = dgram.createSocket("udp4");
socket.bind(server.udp_port);
socket.on("listening", () => {
	const address = socket.address();
	debug_log.push(`The socket is now listening to ${address.address}:${address.port}`);
});

//Receiving packets
socket.on("message", (msg, rinfo) => {
	try {
		stats_log.received_packets++;
		//Get the different parts of the message
		msg = JSON.parse(msg);
		let version = msg.version;
		let keys = msg.keys;
		let type = msg.type;
		let data = msg.data;
		let ip = rinfo.address;
		let port = rinfo.port;

		//Check to make sure the packet is the correct format
		if (version === undefined || keys === undefined || type === undefined || data === undefined) {
			stats_log.invalid_packets++;
			throw "Invalid packet";
		}

		//IF the version is incorrect, send a message back to the player
		if (!server.supported_game_versions.includes(version)) {
			network_send(
				"incorrect_version",
				`Your game's version (${version}) is not supported by the matchmaking server.`,
				rinfo.address,
				rinfo.port,
			);
			return;
		}

		//Get the correct data structures for the version
		let random_matchmaking_list = random_matchmaking_lists.get(version);
		let private_lobby_map = private_lobby_maps.get(version);

		//Update the timestamp
		last_timestamp = Date.now();

		//Check the packet type, and send back a response
		switch (type) {
			case "random_matchmaking_begin":
				//If the key is incorrect, ignore the packet completely
				if (keys.random_matchmaking != server.server_keys.random_matchmaking) {
					return;
				}
				//Clean the matchmaking list
				random_matchmaking_list_clean(version);
				//Check if the player is already in the list or not
				let already_listed = false;
				let player_index = undefined;
				for (let i = 0; i < random_matchmaking_list.length; i++) {
					let player = random_matchmaking_list[i];
					if (ip == player.ip && port == player.port) {
						already_listed = true;
						player_index = i;
						break;
					}
				}
				if (already_listed && player_index != undefined) {
					//Update the timestamp
					random_matchmaking_list[player_index].timestamp = last_timestamp;
					//Send back confirmation
					network_send(
						"random_matchmaking_confirmation",
						"Already in the list",
						ip,
						port,
					);
				} else {
					//Add the player's match ID, ip, and port to the matchmaking list
					if (random_matchmaking_list.length < server.random_matchmaking_limit) {
						random_matchmaking_list.push({
							timestamp: last_timestamp,
							ip: ip,
							port: port,
						});
						//Send back confirmation
						network_send(
							"random_matchmaking_confirmation",
							"Added to the list",
							ip,
							port,
						);
					} else {
						//Matchmaking list is somehow full. This should never happen
						error_log.push("Matchmaking list is full:", random_matchmaking_list.length);
					}
				}
				//Match pairs of players and send them a match_id
				while (random_matchmaking_list.length >= 2) {
					let match_id = server.match_id_counter;
					server.match_id_counter++;
					//Send a packet back to the first two players in the list
					network_send(
						"random_matchmaking_found",
						match_id,
						random_matchmaking_list[0].ip,
						random_matchmaking_list[0].port,
					);
					network_send(
						"random_matchmaking_found",
						match_id,
						random_matchmaking_list[1].ip,
						random_matchmaking_list[1].port,
					);
					//Logging
					if (server.log_connected_ips) {
						matches_log.push({
							match_id: match_id,
							ip1: random_matchmaking_list[0].ip,
							ip2: random_matchmaking_list[1].ip
						});
					}
					stats_log.total_matches++;
					//Remove players from the list
					random_matchmaking_list.splice(0, 2);
				}
				break;
			case "random_matchmaking_cancel":
				//If the key is incorrect, ignore the packet completely
				if (keys.random_matchmaking != server.server_keys.random_matchmaking) {
					return;
				}
				//Remove all elements in the list with the same ip and port (in case the player was accidentally added multiple times)
				for (let i = 0; i < random_matchmaking_list.length; i++) {
					let player = random_matchmaking_list[i];
					if (ip == player.ip && port == player.port) {
						random_matchmaking_list.splice(i, 1);
						i--;
					}
				}
				//Send back cancel confirmation
				network_send(
					"random_matchmaking_cancel_confirmation",
					"Removed from the list",
					ip,
					port,
				);
				break;
			case "holepunching_begin":
				//If the key is incorrect, ignore the packet completely
				if (keys.random_matchmaking != server.server_keys.random_matchmaking) {
					return;
				}
				//Clean the holepunching pairs map
				holepunching_pairs_map_clean();
				//Check if someone already has the match id in the map
				if (holepunching_pairs_map.has(data)) {
					//Compare the ip and port to see if it is a different player or not
					let holepunch_data = holepunching_pairs_map.get(data);
					if (ip == holepunch_data.ip && port == holepunch_data.port) {
						//The player is already waiting in the holepunching map.
						//Update the timestamp
						holepunch_data.timestamp = last_timestamp;
						//Send back confirmation
						network_send(
							"holepunching_confirmation",
							"Already in the map.",
							ip,
							port,
						);
					} else {
						//There is a different player in the holepunching map
						//Send both players each other's ip address and port
						//One player is designated as the "host/leader" player
						network_send(
							"holepunching_found",
							JSON.stringify({ ip: holepunch_data.ip, port: holepunch_data.port, is_leader: true }),
							ip,
							port,
						);
						network_send(
							"holepunching_found",
							JSON.stringify({ ip: ip, port: port, is_leader: false }),
							holepunch_data.ip,
							holepunch_data.port,
						);
					}
				} else {
					//Add the player's match ID, ip, and port to the holepunching map
					if (holepunching_pairs_map.size < server.holepunching_pairs_limit) {
						holepunching_pairs_map.set(data, {
							timestamp: last_timestamp,
							ip: ip,
							port: port,
						});
						//Send back confirmation
						network_send(
							"holepunching_confirmation",
							"Added to the map.",
							ip,
							port,
						);
					} else {
						//Too many playeres are already holepunching
						error_log.push("Holepunching map is full: ", holepunching_pairs_map.size);
					}
				}
				break;
			case "holepunching_cancel":
				//If the key is incorrect, ignore the packet completely
				if (keys.random_matchmaking != server.server_keys.random_matchmaking) {
					return;
				}
				//Remove element with the given match_id from the map
				holepunching_pairs_map.delete(data);
				//Send back cancel confirmation
				network_send(
					"holepunching_cancel_confirmation",
					"Removed from the list",
					ip,
					port,
				);
				break;
			case "private_lobby_reserve":
				//If the key is incorrect, ignore the packet completely
				if (keys.private_lobby != server.server_keys.private_lobby) {
					return;
				}
				//Clean the private lobby map
				private_lobby_map_clean(version);
				//Check if someone already has the code in the map
				if (private_lobby_map.has(data)) {
					//Compare the ip and port to see if it is a different player or not
					let lobby_data = private_lobby_map.get(data);
					if (ip == lobby_data.ip && port == lobby_data.port) {
						//The player has already reserved the lobby code
						//Update the timestamp
						lobby_data.timestamp = last_timestamp;
						//Send back confirmation
						network_send(
							"private_lobby_reserve_confirmation",
							"Already in the map!",
							ip,
							port,
						);
					} else {
						//Someone already reserved the code
						network_send(
							"private_lobby_code_taken",
							"The code " + data + " has already been reserved.",
							ip,
							port,
						);
					}
				} else {
					//Free any other lobbies that the player has reserved
					let removed = [];
					for (let [key, val] of private_lobby_map) {
						if (ip == val.ip && port == val.port) {
							private_lobby_map.delete(key);
							removed.push(key);
						}
					}
					//Add the player's code, ip, and port to the private lobby map
					if (private_lobby_map.size < server.private_lobby_limit) {
						private_lobby_map.set(data, {
							timestamp: last_timestamp,
							ip: ip,
							port: port,
						});
						//Send back confirmation
						network_send(
							"private_lobby_reserve_confirmation",
							"Added " + data + " to the map; Removed " + removed,
							ip,
							port,
						);
					} else {
						//Too many playeres are already reserving lobbies
						error_log.push("Private lobby map is full: ", private_lobby_map.size);
					}
				}
				break;
			case "private_lobby_find":
				//If the key is incorrect, ignore the packet completely
				if (keys.private_lobby != server.server_keys.private_lobby) {
					return;
				}
				//Clean the private lobby map
				private_lobby_map_clean(version);
				//Check if someone already has the code in the map
				if (private_lobby_map.has(data)) {
					//Compare the ip and port to see if it is a different player or not
					let lobby_data = private_lobby_map.get(data);
					if (ip == lobby_data.ip && port == lobby_data.port) {
						//You can't join your own lobby
						network_send(
							"private_lobby_is_self",
							"You can't join your own lobby!",
							ip,
							port,
						);
					} else {
						//There is a different player in the private lobby map
						//Send both players each other's ip address and port
						network_send(
							"private_lobby_found",
							JSON.stringify({ ip: lobby_data.ip, port: lobby_data.port }),
							ip,
							port,
						);
						network_send(
							"private_lobby_request",
							JSON.stringify({ ip: ip, port: port }),
							lobby_data.ip,
							lobby_data.port,
						);
					}
				} else {
					//No lobby with the given code exists
					network_send(
						"private_lobby_not_found",
						"No lobby with the code " + data + " exists.",
						ip,
						port,
					);
				}
				break;
			case "private_lobby_free":
				//If the key is incorrect, ignore the packet completely
				if (keys.private_lobby != server.server_keys.private_lobby) {
					return;
				}
				//Free all lobbies reserved by the player.
				let removed = [];
				for (let [key, val] of private_lobby_map) {
					if (ip == val.ip && port == val.port) {
						private_lobby_map.delete(key);
						removed.push(key);
					}
				}
				//Send back confirmation
				network_send(
					"private_lobby_free_confirmation",
					"Removed " + removed + " from the list",
					ip,
					port,
				);
				break;
			case "fetch_news":
				//Send back the news string, unless the game is on an older version
				if (data != server.latest_version) {
					network_send(
						"news",
						"A new version of PFE is available! (" + server.latest_version + ")",
						ip,
						port,
					);
				} else {
					network_send(
						"news",
						server.news,
						ip,
						port,
					);
				}
				break;
			default:
				//Invalid message type; don't do anything.
				stats_log.invalid_typed_packets++;
				break;
		}
	} catch (error) {
		error_log.push(error);
	}
});

//Save logging files
setInterval(() => {
	//console.log("Saving log files...");
	last_timestamp = Date.now();

	if (matches_log.length > 0) {
		save_file(matches_log, "./logs/matches_log (" + last_timestamp + ").json");
	}
	matches_log = [];

	if (debug_log.length > 0) {
		save_file(debug_log, "./logs/debug_log (" + last_timestamp + ").json");
	}
	debug_log = [];

	if (error_log.length > 0) {
		save_file(error_log, "./logs/error_log (" + last_timestamp + ").json");
	}
	error_log = [];

	save_file(stats_log, "./logs/stats_log.json");

}, (server.logging_interval * 1000));

/*
Removes all elements in the random matchmaking list for the given version that are too old
*/
function random_matchmaking_list_clean(version) {
	last_timestamp = Date.now();
	//let number_cleaned = 0;
	let random_matchmaking_list = random_matchmaking_lists.get(version);
	for (let i = 0; i < random_matchmaking_list.length; i++) {
		let player = random_matchmaking_list[i];
		if (timestamp_difference(last_timestamp, player.timestamp) > server.random_matchmaking_inactive_timer) {
			random_matchmaking_list.splice(i, 1);
			i--;
			//number_cleaned++;
		}
	}
	//debug_log.push("Cleaned out", number_cleaned, "players from the random matchmaking list!");
}
/*
Removes all elements in the holepunching map for the given version that are too old
*/
function holepunching_pairs_map_clean() {
	last_timestamp = Date.now();
	let number_cleaned = 0;
	for (let [key, val] of holepunching_pairs_map) {
		if (timestamp_difference(last_timestamp, val.timestamp) > server.holepunching_pairs_inactive_timer) {
			holepunching_pairs_map.delete(key);
			number_cleaned++;
		}
	}
	stats_log.total_holepunches_expired += number_cleaned;
}
/*
Removes all elements in the private lobby map that are too old
*/
function private_lobby_map_clean(version) {
	last_timestamp = Date.now();
	let number_cleaned = 0;
	let private_lobby_map = private_lobby_maps.get(version)
	for (let [key, val] of private_lobby_map) {
		if (timestamp_difference(last_timestamp, val.timestamp) > server.private_lobby_inactive_timer) {
			private_lobby_map.delete(key);
			number_cleaned++;
		}
	}
	stats_log.total_lobbies_expired += number_cleaned;
}

/*
Sends a message with the type and data through the socket to the given ip and port.
*/
function network_send(type, data, ip, port) {
	try {
		socket.send(JSON.stringify({ type: type, data: data }), port, ip);
		stats_log.sent_packets++;
		return true;
	} catch (error) {
		error_log.push(error);
		return false;
	}
}

//Timestamp functions
/*
Returns the difference between two timestamps in seconds rounded down.
*/
function timestamp_difference(time1, time2) {
	return Math.floor((Math.abs(time1 - time2) / 1000));
}

//File handling functions
/*
Attempts to save the given data as JSON in the specified file.
*/
function save_file(data, filename) {
	try {
		fs.writeFileSync(filename, JSON.stringify(data));
		return true;
	} catch (error) {
		error_log.push(error);
		return false;
	}
}

/*
Attempts to load data from the specified file. If the data cannot be loaded for any reason, null is returned.
*/
function load_file(filename) {
	try {
		return JSON.parse(fs.readFileSync(filename));
	} catch (error) {
		error_log.push(error);
		return null;
	}
}

//For debug use
/*
https://stackoverflow.com/questions/29085197/how-do-you-json-stringify-an-es6-map
*/
/*
function replacer(key, value) {
	if (value instanceof Map) {
		return {
			dataType: 'Map',
			value: Array.from(value.entries()), // or with spread: value: [...value]
		};
	} else {
		return value;
	}
}
*/