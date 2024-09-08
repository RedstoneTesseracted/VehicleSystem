# This function validates arguments specific to certain source types
#
# The particular validation function is chosen using function macros
#
# Return 1 = Success
# Return -1 = Fail
# Return 0 = Macro fail

# Run validation function
$execute if function reds_vehicles:define/scale/sources/$(source) run return 1

# Non-macro fail
return -1
