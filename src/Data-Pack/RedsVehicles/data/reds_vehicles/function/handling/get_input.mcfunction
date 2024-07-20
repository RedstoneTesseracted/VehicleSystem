# This function grabs the input at the provided path and stores it in reds_vehicles:handling.input
# Inputs are collected prior by reds_vehicles:input/gather_input_groups
# and stored in reds_vehicles:inputs.input
#
# The actual path-to-input is provided by function macros

$data modify storage reds_vehicles:handling input set from storage reds_vehicles:inputs input.$(input)
