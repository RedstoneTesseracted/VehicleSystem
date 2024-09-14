# Function macro used to check if a vehicle with the given name has already been registered
#
# Returns:
#   1 if name is already taken
#  -1 if name ISN'T taken
#   0 if function macro failed to compile

$execute if data storage reds_vehicles:definitions processed[{name:'$(name)'}] run return 1
return -1
