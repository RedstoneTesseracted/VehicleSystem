# Recursively destroy passengers that are part of the vehicle

# Destroy mounted entities
execute on passengers if entity @s[tag=vehicle.part] run function reds_vehicles:summon/recursive_passenger_destroy

# Destroy self
kill @s[tag=vehicle.part]
