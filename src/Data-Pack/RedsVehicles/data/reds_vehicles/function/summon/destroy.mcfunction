# This function destroys a vehicle fully
# It is run BY the vehicle base entity

# Only vehicles allowed!
execute unless entity @s[tag=vehicle.base] run return fail

# Destroy mounted entities
execute on passengers if entity @s[tag=vehicle.part] run function reds_vehicles:summon/recursive_passenger_destroy

# Destroy base entity
kill @s[tag=vehicle.base]
