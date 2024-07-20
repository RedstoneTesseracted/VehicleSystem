# Obtains the scale factor from a constant value and applies it
# Called from reds_vehicles:handling/apply_scale
#
# Value is provided via function macros

$execute store result storage reds_vehicles:handling input float $(value) run data get storage reds_vehicles:handling input 1000000

# Undo the fixed-precision, since we can use floating point here
execute store result storage reds_vehicles:handling input float 0.000001 run data get storage reds_vehicles:handling input
