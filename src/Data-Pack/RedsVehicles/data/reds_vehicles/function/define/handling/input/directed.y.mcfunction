scoreboard players set vehicle.input_exists vehicle.local 1
data modify storage reds_vehicles:definitions working_handling.input_group set value "directed"
execute unless data storage reds_vehicles:definitions {working_input_list:["input"]} run data modify storage reds_vehicles:definitions working_input_list append value "input"
execute unless data storage reds_vehicles:definitions {working_input_list:["directed"]} run data modify storage reds_vehicles:definitions working_input_list append value "directed"
return 1
