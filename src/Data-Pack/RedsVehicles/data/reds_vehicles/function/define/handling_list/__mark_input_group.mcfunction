$execute unless data storage reds_vehicles:definitions {working_input_list:[{key:"$(input_group)"}]} run data modify storage reds_vehicles:definitions working_input_list append value {key:"$(input_group)"}
return 1
