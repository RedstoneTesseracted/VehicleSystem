# This function is used to invert the provided value using a block display

# Run function macro
execute store result score vehicle.inverse_success vehicle.local run function reds_vehicles:define/physics/utility/__inverse_value with storage reds_vehicles:definitions working_physics

# Destroy temporary entity
kill @s[type=minecraft:block_display]
