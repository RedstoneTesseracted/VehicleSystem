# This function tells all spawner entities to spawn a vehicle

# Shift context to spawner entities
execute as @e[tag=vehicle.spawner] at @s run function reds_vehicles:summon/__run_spawners

