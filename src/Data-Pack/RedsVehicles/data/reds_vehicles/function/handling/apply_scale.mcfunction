# This is the root function for applying a scale factor on the input value
# It is called from reds_vehicles:handling/handle_inputs_loop
#
# The scale source is provided via function macros

# Obtain the value provided by the source (either constant or score source)
$function reds_vehicles:handling/scale/$(source)_source with storage reds_vehicles:handling current_handler.scale
