# This function FULLY reset the log

# Wipe the log
data modify storage reds_vehicles:logging errors set value []

# Delete "new error" fields
data remove storage reds_vehicles:logging error.vehicle
data remove storage reds_vehicles:logging error.description
data remove storage reds_vehicles:logging error.source
data remove storage reds_vehicles:logging error
