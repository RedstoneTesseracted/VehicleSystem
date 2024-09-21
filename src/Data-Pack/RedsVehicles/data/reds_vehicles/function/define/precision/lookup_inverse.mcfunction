# This function is used to look up the default inverse precision value for a given score
# If no such precision value exists, "1.0" is returned as the default
#
# Result is stored in the "out" tag under the "reds_vehicles:precision" storage
#

# Set default value
data modify storage reds_vehicles:precision out set value 1.0

# Set value if present in table
$execute if data storage reds_vehicles:precision defaults[{key:"$(variable)"}].inverse run data modify storage reds_vehicles:precision out set from storage reds_vehicles:precision defaults[{key:"$(variable)"}].inverse
