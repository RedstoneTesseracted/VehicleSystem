# This function handles the looping aspect of reds_vehicles:define/handling_list/parse
#
# Does NOT return a success/failure code

# Pop the first element in the list
data modify storage reds_vehicles:definitions working_handling set from storage reds_vehicles:definitions unprocessed_handling[0]
data remove storage reds_vehicles:definitions unprocessed_handling[0]

# Process handling element
scoreboard players set vehicle.working_handling_status vehicle.local 1
execute unless function reds_vehicles:define/handling/parse run scoreboard players set vehicle.working_handling_status vehicle.local 0
execute if score vehicle.working_handling_status vehicle.local matches 0 run scoreboard players set vehicle.handling_list_error vehicle.local 1

execute if score vehicle.working_handling_status vehicle.local matches 1 unless data storage reds_vehicles:definitions working_handling.input_group run function reds_vehicles:define/handling_list/report/input_group_unassigned
execute if score vehicle.working_handling_status vehicle.local matches 1 unless data storage reds_vehicles:definitions working_handling.input_group run scoreboard players set vehicle.handling_list_error vehicle.local 1

scoreboard players set vehicle.mark_input_group_status vehicle.local 1
execute if score vehicle.working_handling_status vehicle.local matches 1 store result score vehicle.mark_input_group_status vehicle.local run function reds_vehicles:define/handling_list/mark_input_group
execute if score vehicle.working_handling_status vehicle.local matches 1 if score vehicle.mark_input_group_status vehicle.local matches 0 run scoreboard players set vehicle.handling_list_error vehicle.local 1
execute if score vehicle.working_handling_status vehicle.local matches 1 if score vehicle.mark_input_group_status vehicle.local matches 0 run function reds_vehicles:define/handling_list/report/mark_group_macro_fail
data remove storage reds_vehicles:definitions working_handling.input_group

# Add to processed array
execute if score vehicle.working_handling_status vehicle.local matches 1 if score vehicle.mark_input_group_status vehicle.local matches 1 run data modify storage reds_vehicles:definitions processed_handling append from storage reds_vehicles:definitions working_handling

# Run again if unprocessed handling entries remain
execute if data storage reds_vehicles:definitions unprocessed_handling[0] run function reds_vehicles:define/handling_list/parse_loop
