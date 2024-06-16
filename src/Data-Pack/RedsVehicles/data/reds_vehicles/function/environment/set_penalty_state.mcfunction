# This function updates the vehicle tags for whether it's in the wrong kind of environment
# It is run BY and AT the vehicle base entity

# Update tags
tag @s[tag=vehicle.base,tag=!vehicle.was_in_bad_environment] add vehicle.just_entered_bad_environment
tag @s[tag=vehicle.base] add vehicle.bad_environment

