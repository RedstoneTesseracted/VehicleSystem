# This function applies the penalty of being in he wrong environment
# It is run BY the base vehicle entity and is called from reds_vehicles:environment/apply_environment

#  0: No penalty for being in incorrect environment [this function will not be run in the first place if penalty type is zero]
#  1: Sinking, decreased movement speed
#  2: Sinking, zero movement speed
#  3: Disable vehicle functionality permanently
#  4: Explode vehicle

tag @s[tag=vehicle.was_in_bad_environment,tag=!vehicle.bad_environment] add vehicle.just_left_bad_environment

execute if score @s vehicle.environment_penalty_type matches 1 run function reds_vehicles:environment_penalty/slowed_sinking
execute if score @s vehicle.environment_penalty_type matches 2 run function reds_vehicles:environment_penalty/stopped_sinking
execute if score @s vehicle.environment_penalty_type matches 3 run function reds_vehicles:environment_penalty/disable_permanently
execute if score @s vehicle.environment_penalty_type matches 4 run function reds_vehicles:environment_penalty/explode


# Reset penalty tags for next go-around
tag @s remove vehicle.just_left_bad_environment
tag @s[tag=!vehicle.bad_environment] remove vehicle.was_in_bad_environment
tag @s[tag=vehicle.bad_environment] add vehicle.was_in_bad_environment
tag @s remove vehicle.bad_environment
tag @s remove vehicle.just_entered_bad_environment
