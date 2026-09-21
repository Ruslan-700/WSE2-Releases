ti_on_agent_hit = -28.0 #can only be used in module_mission_templates triggers
# Trigger Param 1: receiver agent no
# Trigger Param 2: dealer agent no
# Trigger Param 3: inflicted damage
# Trigger Param 4: hit bone
# Trigger Param 5: missile item kind no
# Trigger Param 6: raw damage (before being soaked by armor)
# Trigger Param 7: item modifier
# Trigger Param 8: missile item modifier
# Trigger Param 9: damage type
# Register 0: item kind no
# Position Register 0: position of the blow
#                      rotation gives the direction of the blow
# Trigger Result: if set, damage dealt to agent

ti_on_init_item = -50.0 #can only be used in module_items triggers
# Trigger Param 1: agent id
# Trigger Param 2: troop id
# Trigger Param 3: item modifier
# Trigger Param 4: is extra mesh (used for gloves)

ti_on_item_wielded = -57.0 #can only be used in module_mission_templates triggers
# Trigger Param 1: agent id
# Trigger Param 2: item id
# Trigger Param 3: item slot

ti_on_item_unwielded = -58.0 #can only be used in module_mission_templates triggers
# Trigger Param 1: agent id
# Trigger Param 2: item id
# Trigger Param 3: item slot

ti_on_shield_hit = -80.0 #can only be used in module_items triggers
# Trigger Param 1: receiver agent no
# Trigger Param 2: dealer agent no
# Trigger Param 3: inflicted damage
# Trigger Param 4: item kind no
# Trigger Param 5: missile item kind no
# Trigger Param 6: item modifier
# Trigger Param 7: missile item modifier
# Trigger Result: if set, will override the damage dealt to the shield

ti_on_scene_prop_stepped_on = -100.0
ti_on_scene_prop_intersect_with_agent = ti_on_scene_prop_stepped_on #can only be used in module_scene_props triggers
# Trigger Param 1: agent no
# Trigger Param 2: prop instance no
# Trigger Param 3: on ground

ti_on_init_missile = -101.0 #can only be used in module_items triggers
# Trigger Param 1: shooter agent no
# Trigger Param 2: launcher item kind no
# Trigger Param 3: launcher item modifier
# Trigger Param 4: missile item kind no
# Trigger Param 5: missile item modifier
# Trigger Param 6: missile no

ti_on_agent_turn = -102.0 #can only be used in module_mission_templates triggers (for multiplayer player's agents; for WSE2 works always, if bTurnAgentAsMultiplayer=true)
# Trigger Param 1: agent no
# Trigger Param 2: max rotation speed (fixed point)
# Trigger Result: replace max rotation speed (fixed point)

ti_on_agent_blocked = -103.0 #can only be used in module_mission_templates triggers
# Trigger Param 1: receiver agent no
# Trigger Param 2: dealer agent no
# Trigger Param 3: item kind no
# Trigger Param 4: missile item kind no

ti_on_missile_dive = -104.0 #can only be used in module_items triggers
# Trigger Param 1: shooter agent no
# Trigger Param 2: launcher item kind no
# Trigger Param 3: launcher item modifier
# Trigger Param 4: missile item kind no
# Trigger Param 5: missile item modifier
# Trigger Param 6: missile no
# Position Register 0: water impact position and rotation

ti_on_agent_start_reloading = -105.0 #can only be used in module_mission_templates triggers
# Trigger Param 1: agent no

ti_on_agent_end_reloading = -106.0 #can only be used in module_mission_templates triggers
# Trigger Param 1: agent no

ti_on_shield_penetrated = -107.0 #can only be used in module_items triggers
# Trigger Param 1: receiver agent no
# Trigger Param 2: dealer agent no
# Trigger Param 3: inflicted damage
# Trigger Param 4: item kind no
# Trigger Param 5: item modifier
# Trigger Param 6: missile item kind no
# Trigger Param 7: missile item modifier
# Trigger Result: if set, rewrite penetrate shield result

ti_on_scene_prop_is_deforming = -108.0 #can only be used in module_scene_props triggers
# Trigger Param 1: prop instance no
# Trigger Param 2: remaining deform time (1/1000th of second)

ti_on_agent_fill_collision_capsule = -109.0 #can only be used in module_mission_templates triggers
# Trigger Param 1: agent no
# Trigger Param 2: capsule radius (fixed point)
# Position Register 0: point A position (global)
# Position Register 1: point B position (global)
# Trigger Result: If result >= 0, replace capsule radius with this value (fixed point), point A with pos0 and point B with pos1.

ti_on_agent_fill_movement_capsule = -110.0 #can only be used in module_mission_templates triggers
# Trigger Param 1: agent no
# Trigger Param 2: capsule radius (fixed point)
# Position Register 0: point A position (global)
# Position Register 1: point B position (global)
# Trigger Result: If result >= 0, replace capsule radius with this value (fixed point), point A with pos0 and point B with pos1.

ti_on_agent_block_crushed  = -111.0 #can only be used in module_mission_templates triggers
# Trigger Param 1: receiver agent no
# Trigger Param 2: dealer agent no
# Trigger Param 3: inflicted damage
# Trigger Param 4: item kind no
# Trigger Param 5: item modifier
# Trigger Result: if set, rewrite crush block result

ti_on_agent_routed  = -112.0 #can only be used in module_mission_templates triggers
# Trigger Param 1: agent no
# Trigger Result: if set, rewrite agent status. 1 - dead, 2 - wounded

ti_on_agent_footstep_sound_played  = -113.0 #can only be used in module_mission_templates triggers
# Trigger Param 1: agent no
# Trigger Param 2: sound no
# Trigger Param 3: is custom sound
# Trigger Result: if set, rewrite sound no

ti_on_cheat_detected               = -114.0 #can only be used in module_mission_templates triggers (module_simple_triggers on a WSE2 campaign server)
# Trigger Param 1: player no
# Trigger Param 2: detection type (acd_*)
# Trigger Param 3: measured value (fixed point where the statistic is a float)
# Trigger Param 4: the threshold that was exceeded, in the same unit
# Trigger Result: if set to a nonzero value the engine takes no action at all - no kick, no ban -
#                 and the module is expected to handle the detection itself

# anti-cheat detection types (ti_on_cheat_detected param 2)
acd_aim_snap         = 10  # a look-direction spike correlated with an attack or a shot
acd_time_skew        = 11  # the client clock runs at a different rate than the server's
acd_spread_luck      = 12  # server-rolled shot spread far below the honest expectation
acd_attack_cadence   = 13  # more attack releases per window than the engine should allow
acd_auto_block       = 14  # block direction and reaction that no human produces
acd_auto_attack      = 15  # attacks that always find the open side, or follow the defender
acd_seed_mismatch    = 16  # the shot seed sent by the client is not the one the server holds
acd_aim_lead         = 17  # lead error that does not grow with the difficulty of the shot
acd_module_report    = 100 # reported by the module through player_anticheat_report

# anti-cheat statistics (player_get_anticheat_stat)
acs_detections               = 0
acs_seed_mismatches          = 1
acs_time_skew_ratio          = 2  # (fp)
acs_time_skew_windows        = 3
acs_max_aim_speed            = 4  # (fp) degrees per second
acs_aim_snaps                = 5
acs_spread_mean              = 6  # (fp) 0.25 is the honest expectation
acs_spread_shots             = 7
acs_melee_attacks_in_window  = 8
acs_ranged_attacks_in_window = 9
acs_autoblock_samples        = 10
acs_autoblock_match          = 11 # (fp) 0..1
acs_autoblock_reaction_ms    = 12 # median, ping compensated
acs_autoblock_feint_follows  = 13
acs_autoblock_offscreen      = 14
acs_autoattack_samples       = 15
acs_autoattack_open_rate     = 16 # (fp) 0..1
acs_autoattack_reaction_ms   = 17 # median, ping compensated
acs_autoattack_feint_follows = 18
acs_autoattack_chambers      = 19
acs_autoattack_chamber_rate  = 20 # (fp) 0..1
acs_aimlead_hard_shots       = 21
acs_aimlead_err_deg          = 22 # (fp) median error over hard shots
acs_aimlead_flat_ratio       = 23 # (fp) hard error / easy error
acs_time_skew_max            = 24 # (fp) largest positive clock skew of the session
acs_time_skew_stall          = 25 # (fp) largest negative skew of the session (client lag, not a cheat)

# anti-cheat options (server_set_anticheat_option / server_get_anticheat_option)
aco_mode                        = 0  # 0 = off, 1 = silent (log only), 2 = enforce
aco_kick_on_detection           = 1
aco_exempt_admins               = 2
aco_auto_temp_ban_seconds       = 3
aco_report_cooldown             = 4  # (fp) seconds
aco_validate_seed               = 10
aco_server_authoritative_seed   = 11
aco_seed_mismatch_max           = 12
aco_detect_aim_snap             = 20
aco_aim_snap_deg_per_sec        = 21 # (fp)
aco_aim_snap_correlation_ms     = 22
aco_aim_snap_max_count          = 23
aco_aim_snap_window             = 24 # (fp) seconds
aco_detect_time_skew            = 30
aco_max_time_skew_ratio         = 31 # (fp)
aco_time_skew_windows           = 32
aco_time_skew_window_span       = 33
aco_detect_spread_luck          = 40
aco_spread_window_shots         = 41
aco_spread_luck_mean            = 42 # (fp)
aco_detect_attack_cadence       = 50
aco_max_melee_attacks           = 51
aco_max_ranged_attacks          = 52
aco_attack_cadence_window       = 53 # (fp) seconds
aco_detect_auto_block           = 60
aco_auto_block_samples          = 61
aco_auto_block_match_rate       = 62 # (fp)
aco_auto_block_reaction_ms      = 63
aco_auto_block_feint_window_ms  = 64
aco_auto_block_feint_follows    = 65
aco_auto_block_view_cone        = 66 # (fp) degrees
aco_auto_block_offscreen_min    = 67
aco_detect_auto_attack          = 70
aco_auto_attack_samples         = 71
aco_auto_attack_open_rate       = 72 # (fp)
aco_auto_attack_reaction_ms     = 73
aco_auto_attack_feint_window_ms = 74
aco_auto_attack_feint_follows   = 75
aco_auto_attack_chamber_rate    = 76 # (fp)
aco_auto_attack_chamber_min     = 77
aco_detect_aim_lead             = 80
aco_aim_lead_cone               = 81 # (fp) degrees
aco_aim_lead_max_range          = 82 # (fp)
aco_aim_lead_hard_shots         = 83
aco_aim_lead_hard_difficulty    = 84 # (fp)
aco_aim_lead_max_err            = 85 # (fp) degrees
aco_aim_lead_flat_ratio         = 86 # (fp)

# anti-cheat modes (aco_mode)
acm_off     = 0
acm_silent  = 1
acm_enforce = 2

gk_walk = 52
gk_walk_toggle = 53
gk_rear_horse = 54
gk_hide_ui = 55
gk_hide_tooltips = 56
gk_sheath_secondary_weapon = 57
gk_drop_secondary_weapon = 58
gk_dismount = 59
gk_command_line = 60
gk_camera_closer = 61
gk_camera_farther = 62
gk_spectator_camera_move_forward = 63
gk_spectator_camera_move_backward = 64
gk_spectator_camera_move_left = 65
gk_spectator_camera_move_right = 66
gk_spectator_camera_faster = 67
gk_spectator_camera_slower = 68
gk_map_move_forward = 69
gk_map_move_backward = 70
gk_map_move_left = 71
gk_map_move_right = 72
gk_map_wait = 73
gk_take_screenshot = 74
gk_custom_1 = 75
gk_custom_2 = 76
gk_custom_3 = 77
gk_custom_4 = 78
gk_custom_5 = 79
gk_custom_6 = 80
gk_custom_7 = 81
gk_custom_8 = 82
gk_custom_9 = 83
gk_custom_10 = 84
gk_custom_11 = 85
gk_custom_12 = 86
gk_custom_13 = 87
gk_custom_14 = 88
gk_custom_15 = 89
gk_custom_16 = 90
gk_custom_17 = 91
gk_custom_18 = 92
gk_custom_19 = 93
gk_custom_20 = 94
