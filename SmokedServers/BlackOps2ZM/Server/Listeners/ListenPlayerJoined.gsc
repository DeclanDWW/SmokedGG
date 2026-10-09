///////////////////////////////////////////////////////////
// Include Utility Scripts                               //
///////////////////////////////////////////////////////////
#include scripts/zm/Server/Utilities/UtilityPostRequest; //
///////////////////////////////////////////////////////////

listen_player_joined() {
    // Infinitely loop through block of code
    for(;;) {
        // Wait until a player has connected to the server to continue
        level waittill("connected", player);

        // Assign the player data to the data array
        data = [];
        data["guid"] = player.guid;
        data["name"] = player.name;

        // Retrieve the endpoint data and assign player data to global variable
        request = jsonParse(utility_post_request("v1/user", data));
        player.pers["user"] = request["user"];

        // Loop through all the requests welcome messages and send the messages to the player
        foreach(message in request["messages"]) {
            player tell(message);
        }
    }
}