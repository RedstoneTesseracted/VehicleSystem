# Mark type as present
scoreboard players set vehicle.physics_type_exists vehicle.local 1

# "value" field is required
execute unless data storage reds_vehicles:definitions working_physics.value run function reds_vehicles:define/physics/report/value_missing
execute unless data storage reds_vehicles:definitions working_physics.value run return 0

# Convert value to float
execute store result score vehicle.float_convert_success vehicle.local run function reds_vehicles:define/physics/utility/value_to_float with storage reds_vehicles:definitions working_physics
execute if score vehicle.float_convert_success vehicle.local matches 0 run function reds_vehicles:define/physics/report/value_to_float_failed
execute if score vehicle.float_convert_success vehicle.local matches 0 run return 0

# Tell macro that everything is fine
return 1
