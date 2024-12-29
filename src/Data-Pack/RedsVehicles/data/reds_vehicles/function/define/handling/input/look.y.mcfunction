scoreboard players set vehicle.input_exists vehicle.local 1
data modify storage reds_vehicles:definitions working_handling.input_group set value "look"
execute unless data storage reds_vehicles:definitions {working_input_list:["look"]} run data modify storage reds_vehicles:definitions working_input_list append value "look"
return 1
