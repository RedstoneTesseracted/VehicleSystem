# Root function for granting the player hazard protection when riding a vehicle
# It is run BY the vehicle base entity WHEN a player is riding the vehicle

execute if entity @s[tag=vehicle.bonus.water_breathing] on passengers if entity @s[type=minecraft:interaction] on passengers run effect give @s[type=minecraft:player] minecraft:water_breathing 1 0 true
execute if entity @s[tag=vehicle.bonus.night_vision] on passengers if entity @s[type=minecraft:interaction] on passengers run effect give @s[type=minecraft:player] minecraft:night_vision 1 0 true
execute if entity @s[tag=vehicle.bonus.fire_resistance] on passengers if entity @s[type=minecraft:interaction] on passengers run effect give @s[type=minecraft:player] minecraft:fire_resistance 1 0 true
