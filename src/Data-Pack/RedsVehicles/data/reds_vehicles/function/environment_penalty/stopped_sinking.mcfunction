# This function handles applying the penalty corresponding to type 2: stopped and sinking
# It is run BY and AT the vehicle base entity even when NOT in the incorrect environment

# Apply changes for just entering a bad environment
execute if entity @s[tag=vehicle.just_entered_bad_environment] run scoreboard players set @s vehicle.applied_thrust 0
execute if entity @s[tag=vehicle.just_entered_bad_environment] run attribute @s minecraft:generic.gravity modifier add 96244cfb-53bd-46b5-b33f-4483beff904e 0.08 add_value

# Apply effects of being in bad environment
#execute if entity @s[tag=vehicle.bad_environment] run scoreboard players set @s vehicle.input.y -100000

# Apply changes for just leaving a bad environment
execute if entity @s[tag=vehicle.just_left_bad_environment] run scoreboard players operation @s vehicle.applied_thrust = @s vehicle.max_thrust
execute if entity @s[tag=vehicle.just_left_bad_environment] run attribute @s minecraft:generic.gravity modifier remove 96244cfb-53bd-46b5-b33f-4483beff904e
