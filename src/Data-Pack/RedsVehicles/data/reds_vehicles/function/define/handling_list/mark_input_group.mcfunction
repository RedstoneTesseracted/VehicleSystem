# This function is used to mark an input group as being required
# This is called from reds_vehicles:define/handling_list/parse_loop
# IF AND ONLY IF the handling element was successfully parsed
#
# By this point, input group string is stored in reds_vehicles:working_handling.input_group
# We need to add it to reds_vehicles:incomplete_inputs_list IF AND ONLY IF it isn't already
# present in said list
#
# Returns 0 if the macro broke, 1 otherwise

execute store result score vehicle.mark_input_group_status vehicle.local run function reds_vehicles:define/handling_list/__mark_input_group with storage reds_vehicles:definitions working_handling
return run scoreboard players get vehicle.mark_input_group_status vehicle.local
