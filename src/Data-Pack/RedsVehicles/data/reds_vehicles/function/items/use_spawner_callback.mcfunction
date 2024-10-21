# This function runs whenever the players uses a vehicle spawning item
# It is run BY the player using an advancement trigger

# Tell all spawners to do something
function reds_vehicles:summon/run_spawners

# Revoke the advancement
advancement revoke @s only reds_vehicles:hidden/used_spawner_item
