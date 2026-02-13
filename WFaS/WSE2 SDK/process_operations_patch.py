Change the following (line 432):
=============================================
    if (opcode in [try_begin,
                   try_for_range,
                   try_for_range_backwards,
                   try_for_parties,
                   try_for_agents]):
=============================================
to
=============================================
    if (opcode in [try_begin,
                   try_for_range,
                   try_for_range_backwards,
                   try_for_parties,
                   try_for_agents,
                   try_for_prop_instances,
                   try_for_players,
                   try_for_dict_keys,
                   ]):
=============================================
