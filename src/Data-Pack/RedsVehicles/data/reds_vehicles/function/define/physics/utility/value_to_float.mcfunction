# Function macro used to force the "value" field to a double
# Returns a 1 if the macro ran

$data modify storage reds_vehicles:definitions temp.arr set value [0.0f,$(value)f]
data modify storage reds_vehicles:definitions working_physics.value set from storage reds_vehicles:definitions temp.arr[1]
data remove storage reds_vehicles:definitions temp.arr

# Success!
return 1
