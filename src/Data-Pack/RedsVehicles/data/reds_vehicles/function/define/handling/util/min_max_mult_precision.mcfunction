# This function macro is used to multiply the values in working_handling.min and working_handling.max by the
# precision multiplier, converting them from decimal form to fixed-point form.
#
# The precision multiplier must be provided using a function macro

$execute store result storage reds_vehicles:definitions working_handling.min int 1.0 run data get storage reds_vehicles:definitions working_handling.min $(precision)
$execute store result storage reds_vehicles:definitions working_handling.max int 1.0 run data get storage reds_vehicles:definitions working_handling.max $(precision)

# Return success
return 1
