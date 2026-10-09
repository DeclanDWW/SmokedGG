////////////////////////////////////////
// Include base game scripts          //
////////////////////////////////////////
#include maps/mp/_utility;            //
#include common_scripts/utility;      //
#include maps/mp/zombies/_zm_score;   //
#include maps/mp/zombies/_zm_utility; //
////////////////////////////////////////

listen_score(event, mod, hit_location, is_dog, zombie_team, damage_weapon) {
    if (level.intermission)
        return;

    if (!is_player_valid(self))
        return;

    player_points = 0;
    team_points = 0;
    multiplier = get_points_multiplier(self);

    switch (event) {
        case "death":
            player_points = get_zombie_death_player_points();
            team_points = get_zombie_death_team_points();
            points = self player_add_points_kill_bonus(mod, hit_location);

            if (level.zombie_vars[self.team]["zombie_powerup_insta_kill_on"] == 1 && mod == "MOD_UNKNOWN")
                points = points * 2;

            player_points = player_points + points;

            if (team_points > 0)
                team_points = team_points + points;

            if (mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH") {
                self maps\mp\zombies\_zm_stats::increment_client_stat("grenade_kills");
                self maps\mp\zombies\_zm_stats::increment_player_stat("grenade_kills");
            }
            break;
        case "ballistic_knife_death":
            player_points = get_zombie_death_player_points() + level.zombie_vars["zombie_score_bonus_melee"];
            self score_cf_increment_info("death_melee");
            break;
        case "damage_light":
            player_points = level.zombie_vars["zombie_score_damage_light"];
            self score_cf_increment_info("damage");
            break;
        case "damage":
            player_points = level.zombie_vars["zombie_score_damage_normal"];
            self score_cf_increment_info("damage");
            break;
        case "damage_ads":
            player_points = int( level.zombie_vars["zombie_score_damage_normal"] * 1.25 );
            self score_cf_increment_info("damage");
            break;
        case "carpenter_powerup":
        case "rebuild_board":
            player_points = mod;
            break;
        case "bonus_points_powerup":
            player_points = mod;
            break;
        case "nuke_powerup":
            player_points = mod;
            team_points = mod;
            break;
        case "jetgun_fling":
        case "riotshield_fling":
        case "thundergun_fling":
            player_points = mod;
            break;
        case "hacker_transfer":
            player_points = mod;
            break;
        case "reviver":
            player_points = mod;
            break;
        case "vulture":
            player_points = mod;
            break;
        case "build_wallbuy":
            player_points = mod;
            break;
        default:
            assert(0, "Unknown point event");
            break;
    }

    player_points = multiplier * round_up_score(player_points, 5);
    team_points = multiplier * round_up_score(team_points, 5);

    if (isDefined( self.point_split_receiver) && event == "death" || event == "ballistic_knife_death") {
        split_player_points = player_points - round_up_score(player_points * self.point_split_keep_percent, 10);
        self.point_split_receiver add_to_player_score(split_player_points);
        player_points = player_points - split_player_points;
    }

    if (is_true( level.pers_upgrade_pistol_points))
        player_points = self maps\mp\zombies\_zm_pers_upgrades_functions::pers_upgrade_pistol_points_set_score(player_points, event, mod, damage_weapon);

    self add_to_player_score(player_points);
    self.pers["score"] = self.score;

    if (isDefined( level._game_module_point_adjustment))
        level [[level._game_module_point_adjustment]](self, zombie_team, player_points);
}