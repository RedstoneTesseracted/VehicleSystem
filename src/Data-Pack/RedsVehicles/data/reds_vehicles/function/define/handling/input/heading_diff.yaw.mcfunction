scoreboard players set vehicle.input_exists vehicle.local 1
data modify storage reds_vehicles:definitions working_handling.input_group set value "heading_diff"
execute unless data storage reds_vehicles:definitions {working_input_list:["heading_diff"]} run data modify storage reds_vehicles:definitions working_input_list append value "heading_diff"
return 1
