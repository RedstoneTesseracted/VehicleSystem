$execute unless data storage reds_vehicles:definitions {working_input_list:["$(input_group)"]} run data modify storage reds_vehicles:definitions working_input_list append value "$(input_group)"
return 1
