# This function handling the actual looping using recursion
#
# Before running this function, the contents of "vehicles" are copied to "unprocessed_vehicles"
# This function then pops and processes the first element of "unprocessed" before running again
#
# An error in reds_vehicles:define/root/parse (or any of the parsers it calls) will NOT 
# interrupt this loop.
#
# This function is called from reds_vehicles:define/root_list/parse

# Pop first element
data modify storage reds_vehicles:definitions working_root set from storage reds_vehicles:definitions unprocessed_vehicles[0]
data remove storage reds_vehicles:definitions unprocessed_vehicles[0]

# Run the root vehicle tag parser
scoreboard players set vehicle.root_parse_result vehicle.local 0
execute store result score vehicle.root_parse_result vehicle.local run function reds_vehicles:define/root/parse

# Add to list of processed vehicles if parsing/validation succeeded
execute if score vehicle.root_parse_result vehicle.local matches 1 run data modify storage reds_vehicles:definitions processed append from storage reds_vehicles:definitions working_root

# Run again if vehicles remain
execute if data storage reds_vehicles:definitions unprocessed_vehicles[0] run function reds_vehicles:define/root_list/parse_loop
