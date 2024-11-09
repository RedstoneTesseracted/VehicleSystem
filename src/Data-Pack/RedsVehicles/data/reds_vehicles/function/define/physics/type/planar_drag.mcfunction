# Mark type as present
scoreboard players set vehicle.physics_type_exists vehicle.local 1

# "value" field is required
execute unless data storage reds_vehicles:definitions working_physics.value run function reds_vehicles:define/physics/report/value_missing
execute unless data storage reds_vehicles:definitions working_physics.value run return 0

# Tell macro that everything is fine
return 1
