# Action for consuming a single unit of fuel
execute if score @s vehicle.fuel matches 1.. run scoreboard players remove @s vehicle.fuel 1
