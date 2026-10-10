/////////////////////////////////////////////////////////////////
// Include Event Scripts                                       //
/////////////////////////////////////////////////////////////////
#include scripts/zm/Server/Listeners/ListenPlayerDisconnected; //
#include scripts/zm/Server/Listeners/ListenScore;              //
/////////////////////////////////////////////////////////////////

main() {
    replaceFunc(maps\mp\gametypes_zm\_globallogic_player::removeplayerondisconnect, ::listen_player_disconnected);
    replaceFunc(maps\mp\zombies\_zm_score::player_add_points, ::listen_score);
}