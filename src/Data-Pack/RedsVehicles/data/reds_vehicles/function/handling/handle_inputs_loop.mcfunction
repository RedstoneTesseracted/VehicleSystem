# This function uses a recursion-based loop to convert the pilot input into actions that modify vehicle scores
# It is run BY and AT the base vehicle entity
# It is called from reds_vehicles:handling/handle_inputs

# Pop the first element of the list
data modify storage reds_vehicles:handling current_handler set from storage reds_vehicles:handling unprocessed_handlers[0]
data remove storage reds_vehicles:handling unprocessed_handlers[0]

# Copy the value at the input path
function reds_vehicles:handling/get_input with storage reds_vehicles:handling current_handler
#tellraw @a [{nbt: "current_handler", storage: "reds_vehicles:handling"}, {text: " | "}, {nbt: "input", storage: "reds_vehicles:handling"}]

# Apply the scaling operation
function reds_vehicles:handling/apply_scale with storage reds_vehicles:handling current_handler.scale


# Execute the operation defined by the current handler
function reds_vehicles:handling/apply_operation with storage reds_vehicles:handling current_handler

# Run again if groups remain
execute if data storage reds_vehicles:handling unprocessed_handlers[0] run function reds_vehicles:handling/handle_inputs_loop
