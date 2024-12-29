scoreboard players set vehicle.input_exists vehicle.local 1
data modify storage reds_vehicles:definitions working_handling.input_group set value "rotation_diff"
execute unless data storage reds_vehicles:definitions {working_input_list:["rotation_diff"]} run data modify storage reds_vehicles:definitions working_input_list append value "rotation_diff"
return 1
