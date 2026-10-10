///////////////////////////////////////////////////////////
// Include Utility Scripts                               //
///////////////////////////////////////////////////////////
#include scripts/zm/Server/Utilities/UtilityPostRequest; //
///////////////////////////////////////////////////////////

command_godmode(args) {
    // Assign the player data to the data array
    data = [];
    data["guid"] = self.guid;

    // Check if godmode is enabled or not before sending request
    if (self.ignore == 0)
        data["enabled"] = 0;
    else
        data["enabled"] = 1;

    // Retrieve the endpoint data
    request = jsonParse(utility_post_request("v1/commandGodmode", data));

    // Loop through and tell player the messages from the request
    foreach(messages in request["messages"]) {
        self tell(request["messages"]);
    }

    // Check if the request was unsuccessful
    if (!request["success"]) {
        // Stop the script from going any further
        return;
    }

    // Check if player is already in godmode
    if (self.ignore == 0) {
        // Enable godmode and zombie ignore
        self.ignore = 1;
        self enableInvulnerability();

        // Stop the script from going any further
        return;
    }

    // Disable godmode and zombie ignore
    self.ignore = 0;
    self disableInvulnerability();
}