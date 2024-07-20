# Toggles the target score between 0 and 1 if the provided input is nonzero
# The target score is provided via function macros

execute store result score vehicle.input vehicle.local run data get storage reds_vehicles:handling input
$execute unless score vehicle.input vehicle.local matches 0 unless score @s $(variable) store result score @s $(variable) run return 0
$execute unless score vehicle.input vehicle.local matches 0 if score @s $(variable) store result score @s $(variable) run return 1
