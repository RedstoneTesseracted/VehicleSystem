# Action: apply a potion effect to a passenger

# Confirm existence
scoreboard players set vehicle.action_exists vehicle.local 1

# Name field is required
execute unless data storage reds_vehicles:definitions working_action.arguments.name run function reds_vehicles:define/action/report/effect_passenger_missing_name
execute unless data storage reds_vehicles:definitions working_action.arguments.name run return 0

# Set default values for duration, amplifier, and hide_particles fields
execute unless data storage reds_vehicles:definitions working_action.arguments.duration run data modify storage reds_vehicles:definitions working_action.arguments.duration set value 0
execute unless data storage reds_vehicles:definitions working_action.arguments.amplifier run data modify storage reds_vehicles:definitions working_action.arguments.amplifier set value 0
execute unless data storage reds_vehicles:definitions working_action.arguments.hide_particles run data modify storage reds_vehicles:definitions working_action.arguments.duration set value 1b

# Convert "hide_particles" field to true/false string
execute store result score vehicle.hide_particles_value vehicle.local run data get storage reds_vehicles:definitions working_action.arguments.hide_particles
execute if score vehicle.hide_particles_value vehicle.local matches 0 run data modify storage reds_vehicles:definitions working_action.arguments.hide_particles set value "false"
execute if score vehicle.hide_particles_value vehicle.local matches 1 run data modify storage reds_vehicles:definitions working_action.arguments.hide_particles set value "true"
scoreboard players reset vehicle.hide_particles_value vehicle.local

# Success!
return 1
