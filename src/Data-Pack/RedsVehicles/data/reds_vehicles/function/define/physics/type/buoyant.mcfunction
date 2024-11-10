# Mark force as existing
scoreboard players set vehicle.physics_type_exists vehicle.local 1

# "value" field is required
execute unless data storage reds_vehicles:definitions working_physics.value run function reds_vehicles:define/physics/report/value_missing
execute unless data storage reds_vehicles:definitions working_physics.value run return 0

# Convert value to float
execute store result score vehicle.float_convert_success vehicle.local run function reds_vehicles:define/physics/utility/value_to_float with storage reds_vehicles:definitions working_physics
execute if score vehicle.float_convert_success vehicle.local matches 0 run function reds_vehicles:define/physics/report/value_to_float_failed
execute if score vehicle.float_convert_success vehicle.local matches 0 run return 0

# Multiply value by -1.0 to invert direction
execute store result storage reds_vehicles:definitions working_physics.value float -0.000001 run data get storage reds_vehicles:definitions working_physics.value 1000000.0

# Done!
return 1
