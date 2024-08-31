# This function validates the provided list of actions using a recursion-based loop
#
# The list of actions to process is expected to be in "unprocessed_actions" under the 
# reds_vehicles:definitions storage.
#
# Processed entries are appended to the "processed_actions" list under the
# reds_vehicles:definitions storage.

# For safety
scoreboard players set vehicle.action_id vehicle.local 0

# We expect an arguments field, regardless of action type
execute unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_actions_loop', description: '[{"text":"Missing arguments field from action tag"}]'}
execute unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments run return fail

# Try to lookup action type to make sure it exists
data merge storage reds_vehicles:enums {args: {table: "actions"}}
data modify storage reds_vehicles:enums args.key set from storage reds_vehicles:definitions unprocessed_actions[0].action
execute store result score vehicle.action_id vehicle.local run function reds_vehicles:define/enums/lookup_id with storage reds_vehicles:enums args
data remove storage reds_vehicles:enums args

# The lookup function should NEVER return a zero unless it failed to compile
execute if score vehicle.action_id vehicle.local matches 0 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_actions_loop', description: '[{"text":"An unknown error occurred while looking up the action type that caused the macro in reds_vehicles:define/enums/lookup_id to fail.  Either there’s a bug in the macro or an invalid string was provided"}]'}
execute if score vehicle.action_id vehicle.local matches 0 run return fail

# Invalid type
execute if score vehicle.action_id vehicle.local matches -1 run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_actions_loop', description: '[{"text":"Encountered an unrecognized action type.  Valid actions are: playsound, particle, set_model, set_score, and projectile"}]'}
execute if score vehicle.action_id vehicle.local matches -1 run return fail

# Type: playsound
execute if score vehicle.action_id vehicle.local matches 1 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.sound run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_actions_loop', description: '[{"text":"An action of type “playsound” requires a sound field"}]'}
execute if score vehicle.action_id vehicle.local matches 1 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.pitch run data modify storage reds_vehicles:definitions unprocessed_actions[0].arguments.pitch set value 1.0
execute if score vehicle.action_id vehicle.local matches 1 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.volume run data modify storage reds_vehicles:definitions unprocessed_actions[0].arguments.volume set value 1.0

# Type: particle
execute if score vehicle.action_id vehicle.local matches 2 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.name run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_actions_loop', description: '[{"text":"An action of type “particle” requires a name field"}]'}
execute if score vehicle.action_id vehicle.local matches 2 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.offset run data modify storage reds_vehicles:definitions unprocessed_actions[0].arguments.offset set value [0.0, 0.0, 0.0]
execute if score vehicle.action_id vehicle.local matches 2 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.delta run data modify storage reds_vehicles:definitions unprocessed_actions[0].arguments.delta set value [0.0, 0.0, 0.0]
execute if score vehicle.action_id vehicle.local matches 2 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.count run data modify storage reds_vehicles:definitions unprocessed_actions[0].arguments.count set value 1
execute if score vehicle.action_id vehicle.local matches 2 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.speed run data modify storage reds_vehicles:definitions unprocessed_actions[0].arguments.speed set value 0.0

# Type: set_model
execute if score vehicle.action_id vehicle.local matches 3 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.name run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_actions_loop', description: '[{"text":"An action of type “set_model” requires a name field"}]'}
execute if score vehicle.action_id vehicle.local matches 3 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.value run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_actions_loop', description: '[{"text":"An action of type “set_model” requires a value field"}]'}

# Type: set_score
execute if score vehicle.action_id vehicle.local matches 4 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.name run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_actions_loop', description: '[{"text":"An action of type “set_value” requires a name field"}]'}
execute if score vehicle.action_id vehicle.local matches 4 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.value run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_actions_loop', description: '[{"text":"An action of type “set_value” requires a value field"}]'}

# Type: projectile
execute if score vehicle.action_id vehicle.local matches 5 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.name run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_actions_loop', description: '[{"text":"An action of type “projectile” requires a type field"}]'}
execute if score vehicle.action_id vehicle.local matches 5 unless data storage reds_vehicles:definitions unprocessed_actions[0].arguments.value run function reds_vehicles:define/assert_working_fail {source:'reds_vehicles:define/process_actions_loop', description: '[{"text":"An action of type “projectile” requires a direction field"}]'}

# Fail if an error occurred
execute unless score vehicle.asserted_local vehicle.local matches 0 run return fail

# Clean up scores
scoreboard players reset vehicle.action_id vehicle.local

# Pop this first element and run again if further elements remain
data modify storage reds_vehicles:definitions processed_actions append from storage reds_vehicles:definitions unprocessed_actions[0]
data remove storage reds_vehicles:definitions unprocessed_actions[0]
execute if data storage reds_vehicles:definitions unprocessed_actions[0] run return run function reds_vehicles:define/process_actions_loop

# Successfull end of looping: propagate success signal up the call stack
return 1
