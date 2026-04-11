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
