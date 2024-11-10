# Increases the target score by the given amount, clamping it within the given range

# Increase variable
$execute store result score vehicle.input vehicle.local run data get storage reds_vehicles:handling input $(precision)
$scoreboard players operation @s $(variable) += vehicle.input vehicle.local

# Clamp variable to range
$execute if score @s $(variable) matches ..$(min) run scoreboard players set @s $(variable) $(min)
$execute if score @s $(variable) matches $(max).. run scoreboard players set @s $(variable) $(max)
