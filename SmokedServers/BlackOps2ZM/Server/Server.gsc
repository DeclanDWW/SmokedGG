///////////////////////////////////////////////////////
// Include Command Scripts                           //
///////////////////////////////////////////////////////
#include scripts/zm/Server/Commands/CommandDeposit;  //
#include scripts/zm/Server/Commands/CommandGodmode;  //
#include scripts/zm/Server/Commands/CommandHelp;     //
#include scripts/zm/Server/Commands/CommandWithdraw; //
///////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
// Include Listener Scripts                                 //
//////////////////////////////////////////////////////////////
#include scripts/zm/Server/Listeners/ListenPlayerConnected; //
//////////////////////////////////////////////////////////////

server() {
    // Register chat commands with t6 utils
    chat::register_command(".deposit", ::command_deposit, true);
    chat::register_command(".godmode", ::command_godmode, true);
    chat::register_command(".help", ::command_help, true);
    chat::register_command(".withdraw", ::command_withdraw, true);

    level thread listen_player_connected();
}