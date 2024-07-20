# This function is called by reds_vehicles:input/group/click to help gather click data
# It is run BY the pilot seat interaction entity

execute if entity @s[tag=vehicle.right_clicked_by_pilot] run data modify storage reds_vehicles:inputs input.click.right set value 1b
execute if entity @s[tag=vehicle.left_clicked_by_pilot] run data modify storage reds_vehicles:inputs input.click.left set value 1b
tag @s remove vehicle.right_clicked_by_pilot
tag @s remove vehicle.left_clicked_by_pilot
