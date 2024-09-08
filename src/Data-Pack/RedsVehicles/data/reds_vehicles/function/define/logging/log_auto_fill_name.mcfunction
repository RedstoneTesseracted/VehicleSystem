# This function is used to log parsing errors as they occur
#
# Information on errors must be passed in by setting the
# "error.description" and "error.source" fields in the
# "reds_vehicle:logging" storage
#
# In this variant, the "error.vehicle" field is set using
# the string currently stored in "working_root.name

# Auto-fill vehicle name with current working one
data modify storage reds_vehicles:logging error.vehicle set from storage reds_vehicles:definitions working_root.name

function reds_vehicles:define/logging/log_error
