# This function is used to look up the default precision value for a given score
# If no such precision value exists, "1" is returned as the default

# Return default if not present
$execute unless data storage reds_vehicles:precision defaults[{key:"$(variable)"}].value run return 1

# Return value if present
$return run data get storage reds_vehicles:precision defaults[{key:"$(variable)"}].value
