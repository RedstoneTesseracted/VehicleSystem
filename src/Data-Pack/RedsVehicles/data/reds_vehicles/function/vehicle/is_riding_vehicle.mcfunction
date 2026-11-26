# This function returns whether the entity that called it is riding a vehicle

execute on vehicle if entity @s[tag=vehicle.part] run return 1
return 0
