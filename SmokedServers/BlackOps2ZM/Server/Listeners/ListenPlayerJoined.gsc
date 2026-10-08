///////////////////////////////////////////////////////////
// Include Utility Scripts                               //
///////////////////////////////////////////////////////////
#include scripts/zm/Server/Utilities/UtilityPostRequest; //
///////////////////////////////////////////////////////////

listen_player_joined() {
    for(;;) {
        level waittill("connected", player);

        data = [];
        data["guid"] = player.guid;
        data["name"] = player.name;
        request = utility_post_request("user", data);
        player.pers["user"] = request["account"];

        foreach(message in request["messages"]) {
            player tell(message);
        }
    }
}