///////////////////////////////////////////////////////////
// Include Utility Scripts                               //
///////////////////////////////////////////////////////////
#include scripts/zm/Server/Utilities/UtilityPostRequest; //
///////////////////////////////////////////////////////////

command_help(args) {
    // Assign the player data to the data array
    data = [];
    data["guid"] = self.guid;

    // Retrieve the endpoint data and assign player data to global variable
    request = jsonParse(utility_post_request("v1/commandHelp", data));

    // Check if the request was successful
    if (!request["success"]) {
        self tell("Your API key is incorrect");
        return;
    }

    // Loop through and tell player the messages from the request
    foreach(messages in request["messages"]) {
        self tell(messages);
    }
}