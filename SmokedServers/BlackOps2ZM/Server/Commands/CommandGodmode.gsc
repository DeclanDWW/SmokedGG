///////////////////////////////////////////////////////////
// Include Utility Scripts                               //
///////////////////////////////////////////////////////////
#include scripts/zm/Server/Utilities/UtilityPostRequest; //
///////////////////////////////////////////////////////////

command_godmode(args) {
    // Assign the player data to the data array
    data = [];
    data["guid"] = self.guid;
    data["enabled"] = self.ignore;

    // Retrieve the endpoint data and assign player data to global variable
    request = jsonParse(utility_post_request("v1/commandGodmode", data));

    // Check if the request was successful
    if (!request["success"]) {
        self tell("Your API key is incorrect");
        return;
    }

    // Check if player is already in godmode
    if (self.ignore == 0) {
        // Enable godmode and zombie ignore
        self.ignore = 1;
        self enableInvulnerability();

        // Loop through and tell player the messages from the request
        foreach(messages in request["messages"]) {
            self tell(messages);
        }

        return;
    }

    // Disable godmode and zombie ignore
    self.ignore = 0;
    self disableInvulnerability();

    // Loop through and tell player the messages from the request
    foreach(messages in request["messages"]) {
        self tell(messages);
    }
}