# Applied force
scoreboard players set vehicle.physics_type_exists vehicle.local 1

# "value" field is required
execute unless data storage reds_vehicles:definitions working_physics.value run function reds_vehicles:define/physics/report/value_missing
execute unless data storage reds_vehicles:definitions working_physics.value run return 0

# Default value for "reset"
execute unless data storage reds_vehicles:definitions working_physics.reset run data modify storage reds_vehicles:definitions working_physics.reset set value 1b
# Force "byte" type
execute store result storage reds_vehicles:definitions working_physics.reset byte 1 run data get storage reds_vehicles:definitions working_physics.reset

return 1
