# Obtains the scale factor from a scoreboard value held by the vehicle and applies it
# Called from reds_vehicles:handling/apply_scale
#
# Scoreboard name is provided via function macros

# Get current scoreboard value and store in the value tag
$execute store result storage reds_vehicles:handling current_handler.scale.value float $(score_scale) run scoreboard players get @s $(name)

# Now that we've resolved the scale value, apply it
function reds_vehicles:handling/scale/constant_source with storage reds_vehicles:handling current_handler.scale
