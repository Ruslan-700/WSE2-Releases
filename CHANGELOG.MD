# Changelog

## 1.1.4.8
- Fixed crashes in x64 build caused by stale persistent manifold pointers.
- Added `agent_set_can_piercing`, `agent_has_piercing` operations.
- Fixed and updated `agent_set_can_multihit` operation.

## 1.1.4.7
- Added steam achievements.
- Added `agent_set_can_multihit`, `agent_has_multihit`, `agent_set_crush_through`, `agent_get_crush_through`, `agent_set_trigger_disabled`, `agent_is_trigger_disabled` operations.
- Fixed severe FPS drop in interior and dungeon scenes for x64 build.
- Fixed crash on mission end for x64 build.    
- Fixed crash when loading a texture with a malformed DDS mip chain for x64 build.
- Fixed processing the result for `ti_on_agent_killed_or_wounded`.

## 1.1.4.6
- x64 build.
- Added `missile_remove` operation.
- Added `ti_on_agent_footstep_sound_played` trigger.
- Added `bDisableDivisionReset` config option.
- Added missing language files.
- Fixed `agent_body_meta_mesh_deform_in_range`, `agent_body_meta_mesh_deform_in_cycle_loop`, `agent_get_action_dir` operations.
- Fixed number of displayed graphic settings.
- Fixed skill max level being overwritten by savegame.

## 1.1.4.5
- Added `agent_ai_set_can_aim` operation.
- Fixed key combinations (Ctrl+Alt+Space, Ctrl+Alt+Enter) causing the game to freeze.
- Fixed possible crash during campaign map gameplay caused by corrupted party data.
- Fixed `prop_instance_deform` and `agent_body_meta_mesh_deform` operations.
- Fixed alpha-to-coverage not working on some AMD/Intel GPUs.
- Fixed invisible heraldic with alpha-to-coverage for AMD GPU.

## 1.1.4.4
- Fixed doors, trapdoors, and passages not being interactable.
- Fixed sounds system bugs. Sets `iMaxNumVirtualChannels` default value to 100.

## 1.1.4.3
- Added installer.
- Added scaling for launcher.
- Fixed `item_get_weight`, `store_zoom_amount`, `overlay_set_scroll_pos`, `store_return_value`, `fmin`, `fmax`, `str_is_integer`, `get_time`, `fsqrt`, `fabs`, `fceil`, `ffloor`, `fexp`, `fpow`, `fln`, `party_heal_members`, `store01_random_parties_in_range` operations.
- Fixed race condition with ondemand textures.
- Fixed hits on dynamic props.
- Fixed possible crash with `_fem` alternative mesh.
- Fixed inverted `ps_2_a`/`ps_2_b` selection logic.
- Fixed lua bugs.
- Refactored and fixed rcon and ogp.
- Removed `itp_replaces_helm` item flag for vanilla engine compatibility.
- Renamed `bFastDLUrl` to `sFastDLUrl` (typo).

## 1.1.4.2
- Fixed gamepad issues. Sets map window's context menu to gamepad on left trigger.

## 1.1.4.1
- Added XInput gamepad support.
- Added `iGamepadLeftThumbDeadzone`, `iGamepadRightThumbDeadzone`, `iGamepadTriggerThreshold`, `bEnableGamepadVibration` config options.

## 1.1.4.0
- Added `agent_set_rider_rotation_angles`, `agent_get_rider_rotation_angles`, `agent_set_default_rider_rotation_angles` operations.
- Added `ti_on_agent_routed` trigger.
- Added number box for fine battle size tuning.
- Fixed rotations of hit position for `cast_ray` operation.
- Fixed speed bonus for items with `itcf_overswing_spear` flag.
- Fixed default save/load values for `fDamageToFriends`.

## 1.1.3.9
- Added `agent_set_voice_sound`, `agent_set_enable_tilt` operations.
- Added `psf_ignore_degrade_distance` flag.
- `bOverswingSpearUsableOnHorseback` and `bOverswingAndThrustMusketUsableOnHorseback` config options works with ai agents.
- Added "help" console command for dedicated server.
- Fixed `itp_crush_through_any_direction` flag.
- Fixed rcon bugs.

## 1.1.3.8
- Added `bDisableHighHDR`, `bOverswingAndThrustMusketUsableOnHorseback`, `bOverswingSpearUsableOnHorseback`, `bHorsebackSlashPolearmUsableOnlyWithoutShield`, `bThrustMusketUsableOnlyWithoutShield` config options.
- Updated `start_encounter` operation.
- Fixed crash for client, if `iNumPlayersLimit` greater 250.

## 1.1.3.7
- Added `conversation_screen_auto_update_choice` operation.
- Removed factions limit.
- Fixed crash for dedicated server, if `iNumPlayersLimit` greater 250.
- Fixed command line arguments with multiple spaces.

## 1.1.3.6
- Properly fixed shield pickup bug.
- Lua: Fix array bug, lsdir bug.

## 1.1.3.5
- Fixed default items probability.
- Fixed `lua_call` operation.
- Lua: Allow access to all modules in the storage dir, add lsdir, mkdir, rmdir.

## 1.1.3.4
- Restored `_fem` alternative mesh support.
- Restored ATOC (Transparency Antialiasing graphic option) on AMD cards.
- Disabled `clearBoundTextures` for proper ssao operation.
- Fixed formations bug.
- Fixed shield pickup bug.
- Fixed `battle_icon` position on global map.
- Fixed `overlay_animate_to_position` operation.
- Lua update.
- Lua:
  - Fixed `game.hookScript`.
  - `game.addPsys`: allow integer mesh parameter
  - make error message for table check more useful
  - Some luaGuide updates
  - `game.getMeshId`, `game.getNumMeshes`
  - Add lua-std-regex lib
  - `lua_call`: allow underscore, allow table calls
  - Add `lua_test` operation
  - Make printTable nicer, detect inf loop

## 1.1.3.3
- Major Lua update.
- Fixed Warband bug where the combat log disappears from the screen if too much information is being written out too quickly (`bFixNotificationMessages` config option).
- Added `bFixNotificationMessages`, `vNotificationMessagesPosition`, `fSpeedPenaltyForTwoHandedAndPolearmWithShield`, `fAdditionalSpeedPenaltyForTwoHandedPropertyWithShield`, `fDamagePenaltyMultiplierForTwoHandedAndPolearmWithShield`, `fAdditionalDamagePenaltyMultiplierForPolearmWithShield`, `fAdditionalDamagePenaltyMultiplierForTwoHandedPropertyWithShield`, `fDamagePenaltyMultiplierForTwoHandedAndPolearmWithMount`, `fAdditionalDamagePenaltyMultiplierForPolearmWithMount`, `fAdditionalDamagePenaltyMultiplierForTwoHandedPropertyWithMount` config options.
- Removed deprecated `bAdjustedTwoHandedAndPolearmPenalties` config option.
- Fixed `troop_remove_items` operation.
- More convenient id strings for display in the profiler.
- Lua:
  - Update to LuaJIT 2.1
  - Update luaLanes to 3.17.0
  - Added lua debugger
  - Added lua sqlite library
  - Allow access to storage dir (WSE) in lua
  - Added `game.OnGameLoad`, `game.removeItemTrigger`, `game.getNumItemTriggers`, `game.removeScenePropTrigger`, `game.getNumScenePropTriggers`, `game.OnWorldTriggers`, `game.OnSave`, `game.OnLoadSave`.
  - Some more lua util funcs
  - Updated luaGuide

## 1.1.3.2
- Lua update - Support for `try_for_agents` `use_grid` parameter. `addTrigger` accepts mst index. Added `game.addPsys`, `game.removePsys`, `_G.make()`, `game.getCurTemplateNo`, `game.lGetNumTemplates`, `game.getTemplateId`, `game.getNumTriggers`. Updated luaGuide.

## 1.1.3.1
- Added `agent_fade_out_advanced` and `agent_fade_in_advanced` operations.
- Fixed `str_store_quest_name` and `str_store_info_page_name` operations.
- Fixed "You hit a friendly troop!" message when you shoot the dead body of an ally with "Can hit ragdol corpses" is turned on.
- Correct determination of the OS version for Windows 11 and latest Windows Servers.

## 1.1.3.0
- Added `agent_ai_set_can_fight` operation.
- Added `ti_on_agent_block_crushed` trigger.
- Added `itp_crush_through_any_direction` item flag.
- Updated `ti_on_shield_penetrated` trigger.
- Disable `gk_crouch`/`gk_order_7` and `gk_order_8` control's menu buttons if `bCanCrouch`/`bUseAdvancedFormation` disabled.

## 1.1.2.9
- Added `agent_ai_set_can_weapon_switch` operation.
- Added `bShieldSkillAffectsProtectionArea` config option.
- `itp_attach_armature` flag works for weapons.
- Added "Enable Sound Variation" option to Options menu.
- Added French translation for WSE2.
- Further fixed possible crashes when loading save game with deleted party participating in the battle.
- Fixed mission custom camera rotation bug.

## 1.1.2.8
- Fixed possible crashes when loading save game with deleted party participating in the battle.

## 1.1.2.7
- Lua update - Script hooking.
- Added "By inverse mouse movement" block control option.
- Fixed "By relative enemy position" attack control option.
- Fixed font material update for parties map legend.
- Fixed `itp_remove_item_on_use` item flag.
- Fixed shield deform and horse cripple for items without modifier.
- Optimization - for operations zeroed only first 5 operands (same as vanilla Warband).

## 1.1.2.6
- Multiplayer campaign mode - player's party control.
- Lua update - `header_operations`: Fix crash when reading very long lists, allow operation references (used for alias names).
- Fixed item requirement config options.
- Fixed saving for `fMessagesScale` config options.
- Dislay item name without modifier for ammo when picking up items from the ground. Display messages about picking up and dropping items for multiplayer.

## 1.1.2.5
- Multiplayer campaign mode - added `player_get_party_id`, `player_set_party_id`, `party_get_player_id`, `party_is_non_player` operations.
- Extended `set_camera_follow_party` operation.
- Lua update - global var access, scene prop triggers, few new features, more improvements to luaGuide.
- Fixed possible crash with spawn operations without active mission scene.
- Fixed bug with props.

## 1.1.2.4
- Fixed `sokf_dont_move_agent_over` prop flag.
- Fixed speaker agent display for conversation window.

## 1.1.2.3
- Multiplayer campaign mode - network events for attached parties, battle map events; updated party replication.
- Added `ti_on_agent_fill_movement_capsule` trigger.
- Armor metamesh added to agent's metameshes before `ti_on_init_trigger`.

## 1.1.2.2
- Multiplayer campaign mode - network events for party stacks and datetime sync.
- Added `pf_dont_send_to_clients` party flag.
- Profiler update - before, you had to start/stop the entire game to make a recording. Now there are commands for this, and you can add markers with text. It uses a new binary format that allows viewing in timeline mode with many comfort features and also added a search bar for the list view.
- Added `profiler_start`, `profiler_stop`, `profiler_is_recording`, `profiler_mark`, `party_get_banner_icon`, `party_get_extra_icon` operations.
- Lua update - extend vector3, update missing documentation, more examples, better dark theme.

## 1.1.2.1
- Development of a multiplayer campaign mode has begun.
- Added messages font scale option.
- Added `ti_on_agent_fill_collision_capsule` trigger.
- Fixed string parsing with `"` symbol from module files.

## 1.1.2.0
- Fixed top right title for notes window.
- Fixed Warband's zoom bug at high zoom amount.
- Fixed crash for particle systems with zero num particles.

## 1.1.1.9
- Added `acf_apply_slope_for_human` animation flag.
- Added `item_set_horse_skeleton_model` operation.
- Fixed a bug with players spawn for multiplayer.
- Fixed function for removing tags for strings.
- Fixed outer terrains with water.
- Operation `agent_set_attached_scene_prop` works with any bones, not only with hard-coded.

## 1.1.1.8
- Increased the maximum number of bones to 64.
- Added `skeleton_model_set_bone_body_section` and `skeleton_model_clean_body_sections` operations.
- Extended `prop_instance_intersects_with_prop_instance` operation - additional `check_polygon_to_polygon` parameter.
- Fixed and extended `try_for_agents` operation - additional parameter for mission grid iterator.

## 1.1.1.7
- Added "Own kills and player deaths" value for Kill Messages config option (`iMultiplayerKills`).
- Fixed ai bug with target selection for melee behavior.

## 1.1.1.6
- Added `ti_on_init_item` trigger for gloves.
- Extended `ti_on_init_item` trigger.
- `__int64` support for `store_trigger_param`, `return_values`, `store_return_value` operations.
- Updated muparser - fixed `feval` operation.
- Displayed top string of script call stack ingame.
- Fixed body color for `itp_force_show_body` item flag.
- Fixed default body for scenes without body and `sf_generate` flag.
- Fixed string parsing for `multiplayer_send_chat_message_to_player`, `multiplayer_message_put_string` operations.
- Fixed problems when players try using some props.

## 1.1.1.5
- Fixed `troop_get_inventory_slot` and `troop_get_inventory_slot_modifier` operations.
- Fixed walking max speed for human agents.
- Fixed `itp_force_show_body`, `itp_force_show_left_hand`, `itp_force_show_right_hand` item flags.

## 1.1.1.4
- Added `shift_entry_point` operation.
- Extended `entry_point_get_position` operation.
- Fixed bug with starting modules with hyphen in name.

## 1.1.1.3
- Added `set_show_crosshair`, `server_set_ghost_mode_advanced` operations.
- Added `bShowCrosshair` config option.
- Properly fixed dead agents hands bug when scale of agents is not equal to 1.0. `bDoNotMakeHandsParallelToGround` has been removed as no longer needed.
- Fixed possible crash for `try_for_agents`, `prop_instance_receive_damage` operations.
- Fixed `lua_to_int`, `lua_get_type` operations.

## 1.1.1.2
- Added `fPowerDrawSkillDamageBonus`, `fPowerThrowSkillDamageBonus`, `fPowerStrikeSkillDamageBonus` config options.

## 1.1.1.1
- Increased maximum value for Battle Size in settings.
- Fixed some ai bugs.
- Fixed `warband_compatibility.ini` processing.
- Fixed left hand mesh for gloves.

## 1.1.1.0
- Added `agent_set_missile_items_prune_time`, `agent_set_action_speed_modifier`, `agent_get_action_speed_modifier`, `agent_set_left_hand_weapon_collision` operations.
- Fixed crash, when start game with sound off and turn on sound ingame.
- Fixed `mission_cam_set_animation` operation.
- Removed item modifier's check for Warband's operations for better compatibility.

## 1.1.0.9
- Added `agent_set_dropped_items_prune_time`, `reload_item_kinds`, `reload_troops`, `reload_parties` operations.
- Fixed `troop_set_skill_points`, `troop_set_attribute_points`, `troop_set_proficiency_points` operations.

## 1.1.0.8
- Added `fToggleItemModeCooldown` config option.
- Fixed `position_align_to_ground` operation.
- Fixed `itp_covers_head` and `itp_covers_beard` item flags for body items.
- Fixed scrollbar for Control settings window.

## 1.1.0.7
- Added FastDL - quick download of server's custom maps from external storage.
- Fixed `start` dedicated server console command.
- Fixed agent's camera when crouching.

## 1.1.0.6
- Fixed bugs after previous update.

## 1.1.0.5
- Fixed parsing of integers for module files with incorrect values.
- Fixed bugs with thrown weapons.
- Fixed `set_fog_distance` operation.

## 1.1.0.4
- Added `ai_mesh_face_group_translate` operation.
- Fixed `ai_mesh_face_group_show_hide`, `agent_get_current_ai_mesh_face_group` operations.

## 1.1.0.3
- Added `set_shuffle_factions_with_maps` and `get_shuffle_factions_with_maps` dedicated server commands.
- Added `wse_mission_debug_window` mapped presentation.

## 1.1.0.2
- Fixed `player_get_value_of_original_items` operation.
- Fixed `gk_character_window` key for menu and tactical windows.

## 1.1.0.1
- Fixed module selection from the command line for dedicated server.
- Fixed perma bans for dedicated server.
- Fixed Vsync issues.
- Fixed crash with empty meta meshes for `prop_instance_deform_to_time`, `prop_instance_deform_in_range`, `prop_instance_deform_in_cycle_loop`, `prop_instance_get_current_deform_progress`, `prop_instance_get_current_deform_frame`, `prop_instance_set_material` operations.

## 1.1.0.0
- Renamed `fmodex.dll` and `steam_api.dll` to prevent compatibility issues with vanilla game in same folder.
- Fixed `agent_get_bone_position` operation.

## 1.0.9.9
- Added unicode support to dedicated server console.
- Added `tf_scrollable_horizontal` and `tf_scrollable_horizontal_style_2` flags which enable a horizontal scrollbar for container overlay.
- Updated `overlay_get_scroll_pos` and `overlay_set_scroll_pos` operations.

## 1.0.9.8
- Added Steam Api - supports Overlay and Workshop.
- Automatically adds `postFX_WSE2` to `postFx.fx` file.
- Fixed `itp_replaces_shoes` item flag.
- Added launcher for WFaS.
- Updated launcher - supports mods from Steam Workshop.

## 1.0.9.7
- Added CTRL+M hotkey for "Restore module data" option.
- Fixed display of symbol `<`.
- Fixed text color for checkbox.
- Fixed display extra text for parties.
- Fixed texture offset for oceans and rivers animation.
- Fixed combo button bugs.
- Fixed arguments order for `game_missile_dives_into_water` mapped script.
- Added `overlay_enable`, `overlay_item_set_text` operations.
- Extended `start_map_conversation` operation.

## 1.0.9.6
- Added `bLocalVariablesZeroInitialization` config option (default true).
- Fixed `overlay_button_set_type`, `send_post_message_to_url_advanced` operations.

## 1.0.9.5
- Added `agent_kick` and `party_stack_set_num_upgradeable` operations.
- Fixed `troop_ensure_inventory_space`, `item_get_shield_height`, `item_get_horse_scale` operations.
- Added `bUseBorderedShadowSampler` config option.
- `fMissileDamageSpeedPower` and `fMeleeDamageSpeedPower` config options limited to range 1.0-2.0.

## 1.0.9.4
- Added "Create Language Template" to Edit Mode options.
- Fixed incorrect default value for `iMaxNumTreeInstances` and `iMaxNumFloraInstances`.

## 1.0.9.3
- Added "Edit Mode" tab to Options window.
- Added "Set lod quality" option.
- Fixed character window crash, if it is called from menu window.
- Fixed quests title.
- Fixed incorrect default value for `bDontLoadRegularTroopInventories`.

## 1.0.9.2
- Fixed lua bugs.
- Fixed possible "Too many vertices" crashes for particles and combining meshes.

## 1.0.9.1
- Fixed an agents spawning bug which caused the operation `mission_tpl_are_all_agents_spawned` to work incorrectly.
- Fixed transparency for displayed messages.
- Fixed the display of scripting errors for operations performed from lua.
- Fixed lua constants loading.
- Fixed crashes for modules with incorrect item carry flags.

## 1.0.9.0
- Fixed `prop_instance_intersects_with_prop_instance`, `set_party_creation_random_limits` operations.
- Fixed memory leak for arrays operations.

## 1.0.8.9
- Added `get_mouse_map_coordinates` operation.
- Fixed `array_copy` operation.
- Fixed `overlay_set_size` operation for game button.
- Operations `set_physics_delta_time`, `set_ally_collision_threshold`, `set_prop_collision_threshold`, `set_horse_friendly_fire` no longer change the global settings in `rgl_config.ini`.
- Fixed first person view for armors with `itp_covers_hair` flag.
- `MB_MAX_NUM_STATEMENT_OPERANDS` and `MB_MAX_NUM_STATEMENT_BLOCK_PARAMS` increased from 16 to 32. Useful for `call_script` with more parameters.

## 1.0.8.8
- Added `get_campaign_time` and `set_campaign_time` operations.
- Added savegame slot to `wse_game_saved` and `wse_savegame_loaded` scripts.

## 1.0.8.7
- Removed 32 num samples cap for sounds.
- Added `player_get_wse2_version` operation.
- Refixed `sf_always_send_via_network` sound flag.
- Fixed cursor visibility for `mbYesNoWindow`.
- Added WSE version to xml server info.
- Added joined player's WSE2 version to dedicated server logs.

## 1.0.8.6
- Fixed map crash.
- Fixed `iMultiplayerKills` config option.

## 1.0.8.5
- Added `fMouseScrollTime` config option.
- Added "Player deaths" value for Kill Messages config option (`iMultiplayerKills`).
- Refixed shadowmap rendering bug.
- Fixed ai weapon selection.
- Fixed party pathfinging.
- Fixed click sound.

## 1.0.8.4
- Fixed agent's pathfinding bug.
- Fixed `try_for_dict_keys`, `play_sound` operations.
- Added mission debug window.

## 1.0.8.3
- Removes the engine limit of 16 skins.
- Fixed `troop_set_age` operation.
- Fixed `wse_savegame_loaded` trigger - triggered only with savegame loaded.

## 1.0.8.2
- Fixed `ti_on_scene_prop_hit`, `ti_on_agent_blocked`, `ti_on_shield_hit`, `ti_on_shield_penetrated` triggers.
- Extended `ti_on_item_wielded`, `ti_on_item_unwielded` triggers (param 3: item slot), `ti_on_shield_hit` trigger (param 6: item modifier, param 7: missile item modifier).
- Fixed proficiency improvement when dealing damage in singleplayer.
- Fixed `failure_callback_script_no` for `send_message_to_url_advanced` and `send_post_message_to_url_advanced` operations.
- Fixed knockdown chance.

## 1.0.8.1
- Fixed crash with remove invalid parties when saving the game.
- Fixed `ai_mesh_face_group_show_hide`, `party_quick_attach_to_current_battle` operations.
- Fixed `sokf_type_barrier3d` and `sokf_type_ai_limiter3d`.
- Fixed headshot ui message.
- Fixed `+` sign in party window with companion level up.

## 1.0.8.0
- Added `cast_ray_agents` operation.

## 1.0.7.9
- Added `bServerLockFov`, `iMultiplayerEventForAnnounce` config options.
- `bRagdollSoakApplyForce` works for multiplayer without enabled `bBreakWarbandCompatibility` (with latest WSE2 on server and client both).
- Added `bRagdollSoak` and `bRagdollSoakApplyForce` to client options menu.
- Added "announce" console command for dedicated server.

## 1.0.7.8
- Fixed `distribute_party_among_party_group`, `hero_can_join`, `hero_can_join_as_prisoner`, `rest_for_hours`, `rest_for_hours_interactive` operations.

## 1.0.7.7
- Fixed crash with sounds `channelCallback`.
- Fixed Warband bug - rare crash with autogenerated degradable flora.
- Fixed crash with enabled profiling when the recursion limit is reached.
- Max num nested loops reduced to default 128, which should reduce freezes in badly written scripts with lots of nested loops and recursion.

## 1.0.7.6
- Fixed stack overflow for local variables.
- Fixed wound treatment - works for the main party, even if main party is disabled.
- Fixed music switch bug.
- Fixed `store_free_inventory_capacity` operation.

## 1.0.7.5
- Fixed crash with invalid string in `rglFormat`.
- Fixed `change_screen_equip_other` and `change_screen_loot` operations.
- Fixed `ti_on_presentation_run` trigger.
- Fixed clear mission after exiting.
- Fixed `stopAllSounds` bug.

## 1.0.7.4
- Fixed module resource loading if this file already loaded as core resource.
- Fixed prisoners count for `party_count_members_of_type`, `party_count_prisoners_of_type`, `store_troop_count_prisoners`, `party_add_prisoners` operations.

## 1.0.7.3
- Fixed a bug with non-attacking melee bots.
- Fixed `store_num_parties_destroyed`, `store_num_parties_destroyed_by_player` operations.
- Restored Warband compatibility for `options_get_damage_to_player`, `options_set_damage_to_player`, `options_get_damage_to_friends`, `options_set_damage_to_friends` operations.
- Fixed `fDamageToFriends` config option for game difficulty formula.

## 1.0.7.2
- Fixed `bAiDecideDirectionAccordingToDamage` config option.
- Fixed `itp_covers_hair_partially` item flag.
- Fixed `agent_set_attack_action`, `agent_set_defend_action` operations.

## 1.0.7.1
- Fixed instancing.
- Fixed shadowmap rendering bug.
- Fixed `game_missile_launch` mapped script.
- Fixed `prop_instance_remove_light` operation.
- Fixed combo button text size.

## 1.0.7.0
- Added wse2 launcher.
- Restored shader compatibility.
- Restored hair materials.
- Added `bLoadModuleIniOptions`, `bLimitHairColors` config options.
- Warning messages requires enabled edit mode.

## 1.0.6.9
- Head deformation applied to all helmet's meshes, not just for the first.
- Updated Music manager.
- Fixed `overlay_set_size` operation for combo button and slider.

## 1.0.6.8
- Added `bSyncBlockDirections` config option.
- Fixed `fWeaponPointsPerLevel`, `fSkillPointsPerLevel`, `fAttributePointsPerLevel` config options.
- Fixed icons for items on inventory screen.
- Fixed `ti_on_agent_spawn` trigger - missing `trigger_param_2` (`entry_no`).

## 1.0.6.7
- Updated FMOD Ex library.
- Fixed VSync.
- Fixed crash with agent fade out.
- Added missing game variables.
- Refixed `set_shader_param_...` operations with threaded renderer.
- Fixed `itp_cant_use_on_horseback` item flag.
- Fixed `ti_on_init_map_icon` trigger.
- Fixed vertex animation speed for map icon.

## 1.0.6.6
- Improving loading time for client. Especially on an SSD.

## 1.0.6.5
- Fixed crash in Viking Conquest.
- `arf_stick_item_to_left_hand` animation flag works better with cycled animations.
- Fixed `iMinNumAgentsForNavMeshReuse` config option.
- Fixed default value for `bTakeAttackersSpeedForRangedSpeedBonus` and `iIndexBufferSizeStatic` config options.
- Small bugfixes.

## 1.0.6.4
- Added `agent_set_time_speed_multiplier`, `agent_get_time_speed_multiplier` operations.

## 1.0.6.3
- Added missile hit sounds for dynamic props.
- Fixed deform head for `itp_covers_head` flag.
- Fixed invalid values processing for hair color gradiant in module skins.

## 1.0.6.2
- Added `iNumPlayersLimit` config option.
- Added `multiplayer_connect_to_server` operation.
- Fixed `server_set_max_num_players` operation.

## 1.0.6.1
- Fixed beards and accessories.
- Fixed `overlay_set_tooltip` operation.
- Increased max number local variables to 1024.

## 1.0.6.0
- Added `bAllowDuplicateMeshes` config option.
- Fixed particle system degrade distance.
- Fixed singleplayer bug with the player spawning after allies.

## 1.0.5.9
- Added `iAttributeLimit`, `iMinBattleAdvantage`, `iMaxBattleAdvantage` config options.
- Fixed bug with battle advantage.

## 1.0.5.8
- Added `bHorseFriendlyFire` config option.
- Added `set_horse_friendly_fire` operation.
- Implemented facecode viewer for edit mod. (Ctrl + E)

## 1.0.5.7
- Added `bMainMenuScene` config option.
- Added `wse_initial_window_start` mapped script.

## 1.0.5.6
- Fixed spectator camera bug with lock to team members view.
- "Enable edit mode" added to ingame configs menu.
- Debug menu on initial screen shows only with enabled edit mode.
- Added "Restore module data" to debug menu.

## 1.0.5.5
- Added `bDoNotMakeHandsParallelToGround` config option.

## 1.0.5.4
- Fixed reloading bug - only one projectile was loaded, regardless of weapons max ammo.
- Fixed `make_screenshot` operation.
- Implemented troop viewer for edit mode.

## 1.0.5.3
- Added `warband_compatibility.ini` support.
- Fixed brace rotation.
- Minor bugfixes.

## 1.0.5.2
- Added WFaS build.
- Added `bMoreProficiencyEffectForMovingSpeedWhileReloading` config option.
- Added `sf_use_next_for_far` sound flag.
- Fixed `sf_always_send_via_network` sound flag.
- Fixed sound bugs.
- Fixed backpedal speed.

## 1.0.5.1
- Fixed shot difficulty message.

## 1.0.5.0
- Fixed damage type for `itcf_overswing_spear`.

## 1.0.4.9
- Fixed bug with troops upgrade to `trp_player`.

## 1.0.4.8
- Fixed `store_random_party_of_template` operation.

## 1.0.4.7
- Fixed `try_for_players` operation.

## 1.0.4.6
- Implemented Stats window and character import/export.
- Fixed `troop_set_proficiency` operation.

## 1.0.4.5
- Fixed bug with crossbow reloading.
- Implemented WSE Profiler (Profiling config options).
- Added `bEditMode` config option (currently only displays messages in `rgl_log.txt`).
- Fixed `sModuleDownloadUrl` config option.

## 1.0.4.4
- Added `bAllowKickDuringMeleeAttacks` config option.
- Fixed `itp_cant_reload_while_moving` and `itp_cant_reload_while_moving_mounted` item flags.

## 1.0.4.3
- Added some Carribean operations - `set_random_seed`, `store_application_time`, `is_party_skill`, `agent_get_horse_rotation_velocity`, `agent_get_current_vertical_speed`, `agent_set_current_vertical_speed`, `agent_get_position_in_group`, `agent_get_current_ai_mesh_face_group`, `prop_instance_remove_particle_system`, `prop_instance_remove_light`, `prop_instance_get_sound_progress`, `cur_item_mesh_set_color`, `cur_item_add_mesh_with_material`, `party_switch_stacks`, `party_stack_upgrade`, `position_get_length`, `get_dot_product_of_positions`, `get_cross_product_of_positions`, `str_store_skill_desc`, `overlay_button_set_type`, `overlay_get_scroll_pos`, `overlay_set_scroll_pos`.
- Extended `add_point_light` and `add_point_light_to_entity` operations - range parameter.
- Operations that are performed in lua now get context (trigger).
- Fixed `particle_system_remove` and `cur_item_add_mesh` operations.

## 1.0.4.2
- Fixed reloading bug.
- Fixed `agent_equip_item`, `face_keys` operations.
- Added undocumented `store_main_party_wounded`, `str_store_agent_face_keys` Warband's operations.

## 1.0.4.1
- Fixed ai weapon usage orders.

## 1.0.4.0
- Fixed `agent_ai_set_simple_behavior` operation.

## 1.0.3.9
- Fixed cooldown for horse charging and weapon alternative usage.
- Fixed `bUseAdvancedFormation` config option.
- Fixed bug with division's leader assignment.

## 1.0.3.8
- Added `fLancePikeEffectMinLength`, `fLancePikeEffectMinDamage`, `bAdjustedAttackHoldFactor`, `bAdjustedCrushthrough`, `bAdjustedTwoHandedAndPolearmPenalties`, `bAdjustedShieldSkillDamage`, `bAdjustedStagger`, `bAdjustedKnockdown`, `bNerfHorseManeuver`, `bItemSpeedAffectSpeedBonusForDamage`, `bTakeAttackersSpeedForRangedSpeedBonus`, `bTweakCrushthroughDamageReduction`, `bRandomTroopEquipping`, `bReduceDamageRandomness`, `bParry`, `bCouchedLanceChambered`, `fKickRange`, `fHorseBumpMinSpeed`, `fMaxSlowMotionDeltaTimeStep` config options.
- Fixed `bRagdollHeadshots` config option.

## 1.0.3.7
- Added `bAdvancedLogFormat` config option.

## 1.0.3.6
- Fixed chamber and sweetspot for `itp_has_upper_stab` item flag.
- Added `bAdjustedSweetSpot`, `bPolearmStagger` config options.

## 1.0.3.5
- Unicode support for strings operations.

## 1.0.3.4
- Fixed `troops_can_join`, `troops_can_join_as_prisoner`, `remove_troops_from_companions`, `remove_troops_from_prisoners` operations.

## 1.0.3.3
- Fixed `party_can_join`, `party_can_join_as_prisoner`, `party_can_join_party` operations.

## 1.0.3.2
- Fixed `party_force_add_members` and `party_force_add_prisoners` operations.

## 1.0.3.1
- Fixed bug with rain sound when it snows.
- Fixed `set_shader_param_...` operations with threaded renderer.

## 1.0.3.0
- Fixed `position_rotate_x_floating`, `position_rotate_y_floating`, `team_get_order_position` operations.
- Fixed singleplayer's saving/loading for `fDamageToSelf` and `fDamageToFriends` config options (for warband's compatibility only 25%, 50% and 100%).
- Bugfixes.

## 1.0.2.9
- Bugfixes.

## 1.0.2.8
- Fixed `mission_cam_animate_to_position` and `mission_cam_animate_to_position_and_aperture` operations.
- Fixed Warband's savegame compatibility.

## 1.0.2.7
- Added `skin_set_blood_color`, `item_set_horse_blood_color` operations.
- Fixed `mission_tpl_entry_clear_override_items`, `mission_tpl_entry_add_override_item` operations.
- Bugfixes.

## 1.0.2.6
- Added cheat mode.
- Added `bCheatMode`, `iMaxNumNotificationMessages`, `bHasOneHanded`, `bHasTwoHanded`, `bHasPolearms`, `bHasArchery`, `bHasCrossbows`, `bHasThrowing` config options.
- Fixed ingame console.
- Fixed `agent_set_max_hit_points` operation.

## 1.0.2.5
- Added Lua support.
- Bugfixes.

## 1.0.2.4
- Added `agent_set_footstep_sound` operation.

## 1.0.2.3
- Added `ti_on_scene_prop_is_deforming` trigger.
- Added `itp_covers_hands` item flag.
- Added all scene prop triggers support for `add_point_light`, `particle_system_add_new`, `particle_system_remove`, `set_forced_lod`, `play_sound`, `add_point_light_to_entity`, `particle_system_emit` operations.

## 1.0.2.2
- Fixed `prop_instance_add_particle_system` operation.
- Module music loading without obsolete `mtf_module_track` music flag.

## 1.0.2.1
- Fixed crash with `game_missile_launch` mapped script.
- Fixed `ui_cant_reload_this_weapon_on_horseback` message spam.

## 1.0.2.0
- Added TexturesHD folder support.
- Added `bAdvancedTurnRateFormulaForMelee` config option.
- Fixed `bRestrictAttacksMoreInMultiplayer` config option.
- Fixed Windows version detect.
- Bugfixes.

## 1.0.1.9
- Added `acf_lock_rotation` animation flag.
- Added `bRagdollSoak` and `bRagdollSoakApplyForce` config options.
- Fixed `fKickCooldown` config option for multiplayer client.

## 1.0.1.8
- Continued work on sound system, fixed crash.
- Fixed reloading sound for muskets.

## 1.0.1.7
- Added `agent_body_meta_mesh_deform_in_range`, `agent_body_meta_mesh_deform_in_cycle_loop`, `agent_body_meta_mesh_get_current_deform_progress`, `agent_body_meta_mesh_get_current_deform_frame` operations.

## 1.0.1.6
- Rewrited sound system for full `sf_stream_from_hd` support.
- Disabled frequency variation for `sf_stream_from_hd` sound flag.
- Fixed `store_last_sound_channel` operation.
- Removed cap for number of music tracks.
- Fixed weapon hud for `bUseCrossbowAsFirearm` config option.
- Fixed camera height while crouching.

## 1.0.1.5
- Updated custom game keys. Increased to 20. Custom keys saved separately for each module. You can map default keys to custom game keys with `module_controls_template.ini` (check WSE2 SDK).
- Added `bLogIPs` config option.
- Updated `game_key_get_key` operation.
- Added dummy for `options_get_cheat_mode` operation.
- Bugfixes.

## 1.0.1.4
- Added `bApplySkillForCouchingDamage` config option.
- Fixed `display_message` operation.

## 1.0.1.3
- Fixed `set_show_messages` operation.

## 1.0.1.2
- Fixed crash with joining on server.

## 1.0.1.1
- Fixed `server_map_rotation_get_map`, `position_get_vector_to_position`, `set_spawn_effector_scene_prop_id`, `agent_set_attached_scene_prop` operations.
- Fixed `sf_always_send_via_network` sound flag.
- Fixed `bSyncRagdollEffects`, `ItemRequirement` config options.
- Fixed http response handling.
- Fixed dedicated server's schedule commands.
- Minor bugfixes.

## 1.0.1.0
- Fixed blocking while kick.

## 1.0.0.9
- Fixed couching bug on servers with `iLanceControl=0`.

## 1.0.0.8
- Fixed `str_store_join` operation.
- Fixed http server queries.

## 1.0.0.7
- Added `bTurnAgentAsMultiplayer` config option.

## 1.0.0.6
- Fixed bugs with sticked missiles to agents and shields.

## 1.0.0.5
- Fixed `agent_set_item_slot_modifier` operation.
- Extended `agent_set_animation_progress` operation.

## 1.0.0.4
- Fixed `change_screen_give_members` operation.

## 1.0.0.3
- Fixed `change_screen_exchange_members` operation.

## 1.0.0.2
- Fixed `party_add_xp` operation.
- Fixed experience bug.

## 1.0.0.1
- Added `iBattleSizeMin`, `iBattleSizeMax` config options.
- Increased battle size limit.
- Fixed bugs with character screen, date change and display message.

## 1.0.0.0
- Release.
