# This function handles applying the penalty corresponding to type 3: disable
# It is run BY and AT the vehicle base entity even when NOT in the incorrect environment

# Apply changes for just entering a bad environment
execute if entity @s[tag=vehicle.just_entered_bad_environment] run scoreboard players set @s vehicle.applied_thrust 0
execute if entity @s[tag=vehicle.just_entered_bad_environment] run tag @s add vehicle.destroyed
