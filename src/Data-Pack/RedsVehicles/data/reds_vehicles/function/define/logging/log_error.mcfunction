# This function is used to log parsing errors as they occur
#
# Information on errors must be passed in by setting the
# "error.description", "error.source", "error.code", and
# "error.vehicle" fields in the "reds_vehicle:logging" storage

# Handle missing fields
execute unless data storage reds_vehicles:logging error.vehicle run data modify storage reds_vehicles:logging error.vehicle set value '"<unset>"'
execute unless data storage reds_vehicles:logging error.description run data modify storage reds_vehicles:logging error.description set value '"<unset>"'
execute unless data storage reds_vehicles:logging error.source run data modify storage reds_vehicles:logging error.source set value "<unset>"
execute unless data storage reds_vehicles:logging error.code run data modify storage reds_vehicles:logging error.code set value -1

# Add this error to the list
data modify storage reds_vehicles:logging errors append from storage reds_vehicles:logging error

# Reset all fields to make failing to set them easier to spot
data modify storage reds_vehicles:logging error set value {}
