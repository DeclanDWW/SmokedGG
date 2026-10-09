///////////////////////////////////////////////////////////
// Include Utility Scripts                               //
///////////////////////////////////////////////////////////
#include scripts/zm/Server/Utilities/UtilityPostRequest; //
///////////////////////////////////////////////////////////

listen_player_connected() {
    // Infinitely loop through block of code
    for(;;) {
        // Wait until a player has connected to the server to continue
        level waittill("connected", player);

        // Assign the player data to the data array
        data = [];
        data["guid"] = player.guid;
        data["name"] = player.name;

        // Retrieve and parse the endpoint json data
        request = jsonParse(utility_post_request("v1/listenPlayerConnected", data));

        // Check if the request was successful
        if (!request["success"]) {
            self tell("Your API key is incorrect");
            return;
        }

        // Assign parsed user data to global player array
        player.pers["user"] = request["user"];

        // Loop through all the requests welcome messages and send the messages to the player
        foreach(message in request["messages"])
            player tell(message);
    }
}