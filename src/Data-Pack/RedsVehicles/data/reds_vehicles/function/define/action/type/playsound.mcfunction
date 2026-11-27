# Action: play sound

# Confirm existence
scoreboard players set vehicle.action_exists vehicle.local 1

# Sound field is required
execute unless data storage reds_vehicles:definitions working_action.arguments.sound run function reds_vehicles:define/action/report/playsound/missing_sound
execute unless data storage reds_vehicles:definitions working_action.arguments.sound run return 0

# Pitch, volume, and period fields are optional
execute unless data storage reds_vehicles:definitions working_action.arguments.pitch run data modify storage reds_vehicles:definitions working_action.arguments.pitch set value 1.0
execute unless data storage reds_vehicles:definitions working_action.arguments.volume run data modify storage reds_vehicles:definitions working_action.arguments.volume set value 1.0
execute unless data storage reds_vehicles:definitions working_action.arguments.period run data modify storage reds_vehicles:definitions working_action.arguments.period set value 1

# Success!
return 1
