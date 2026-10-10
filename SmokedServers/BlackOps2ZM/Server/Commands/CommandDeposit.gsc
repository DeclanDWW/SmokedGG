///////////////////////////////////////////////////////////
// Include Utility Scripts                               //
///////////////////////////////////////////////////////////
#include scripts/zm/Server/Utilities/UtilityPostRequest; //
///////////////////////////////////////////////////////////

command_deposit(args) {
    // Assign the player data to the data array
    data = [];
    data["guid"] = self.guid;
    data["args"] = args[1];

    // Retrieve the endpoint data
    request = jsonParse(utility_post_request("v1/commandDeposit", data));
}