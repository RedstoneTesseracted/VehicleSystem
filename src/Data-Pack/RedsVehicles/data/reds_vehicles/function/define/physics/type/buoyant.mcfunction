# Mark force as existing
scoreboard players set vehicle.physics_type_exists vehicle.local 1

# "value" field is required
execute unless data storage reds_vehicles:definitions working_physics.value run function reds_vehicles:define/physics/report/value_missing
execute unless data storage reds_vehicles:definitions working_physics.value run return 0

# Multiply value by -1.0 to invert direction
execute store result storage reds_vehicles:definitions working_physics.value double -0.000001 run data get storage reds_vehicles:definitions working_physics.value 1000000.0

# Done!
return 1
