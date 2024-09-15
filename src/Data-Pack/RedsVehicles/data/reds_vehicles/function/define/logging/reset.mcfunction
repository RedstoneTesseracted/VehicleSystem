# This function FULLY reset the log

# Wipe the log
data modify storage reds_vehicles:logging errors set value []

# Delete "new error" fields
data modify storage reds_vehicles:logging error set value {}
data remove storage reds_vehicles:logging error
