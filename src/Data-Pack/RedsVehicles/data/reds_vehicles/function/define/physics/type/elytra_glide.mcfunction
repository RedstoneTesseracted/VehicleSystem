# Mark force as existing
scoreboard players set vehicle.physics_type_exists vehicle.local 1

# Discard "value" field if provided (unused)
data remove storage reds_vehicles:definitions working_physics.value

# Success!
return 1
