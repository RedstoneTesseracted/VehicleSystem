scoreboard players set vehicle.input_exists vehicle.local 1
data modify storage reds_vehicles:definitions working_handling.input_group set value "motion"
execute unless data storage reds_vehicles:definitions {working_input_list:["input"]} run data modify storage reds_vehicles:definitions working_input_list append value "input"
execute unless data storage reds_vehicles:definitions {working_input_list:["motion"]} run data modify storage reds_vehicles:definitions working_input_list append value "motion"
return 1
