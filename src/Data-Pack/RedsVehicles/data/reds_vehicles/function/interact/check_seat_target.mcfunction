# This function checks if the player who last interacted with this 
# interaction entity is also the one with the vehicle.context tag
#
# It is run BY vehicle seat interactions as a conditional

# Check interaction time
execute store result score vehicle.current_time vehicle.last_interaction_time run time query gametime
execute store result score @s vehicle.last_interaction_time run data get entity @s interaction.timestamp
scoreboard players operation @e[tag=vehicle.seat] vehicle.last_interaction_time -= vehicle.current_time vehicle.last_interaction_time

execute unless score @s vehicle.last_interaction_time matches 0 run return 0

# Check target match
execute on target if entity @s[tag=vehicle.context] run return 1

# Check failed
return 0
