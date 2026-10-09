///////////////////////////////////////////////////////////
// Include Utility Scripts                               //
///////////////////////////////////////////////////////////
#include scripts/zm/Server/Utilities/UtilityPostRequest; //
///////////////////////////////////////////////////////////

listen_player_disconnected() {
    // Assign the player data to the data array
    data = [];
    data["guid"] = self.guid;
    data["kills"] = self.pers["kills"];
    data["downs"] = self.pers["downs"];
    data["deaths"] = self.pers["deaths"];
    data["revives"] = self.pers["revives"];
    data["headshots"] = self.pers["headshots"];
    utility_post_request("v1/listenPlayerDisconnected", data);

    for (entry = 0; entry < level.players.size; entry++) {
        if (level.players[entry] == self) {
            while (entry < level.players.size - 1) {
                self = level.players[entry + 1];
                entry++;
            }

            self = undefined;
            break;
        }
    }
}