# Function macro used to convert a "name" action argument into a target selector
#
# "name" is provided via function macros
#
# The result is stored at working_action.arguments.selector in the 
# reds_vehicles:definitions storage
#
# Returns:
#   1 = Function executed normally
#   0 = Macro failed
#

$data modify storage reds_vehicles:definitions working_action.arguments.selector set value "@s[name=$(name)]"

# Completed without problems
return 1
