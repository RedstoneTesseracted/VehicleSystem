# Sets the provided scoreboard to the provided value
# The variable name and its fixed-point precision are provided via function macros

$execute store result score @s $(variable) run data get storage reds_vehicles:handling input $(precision)
