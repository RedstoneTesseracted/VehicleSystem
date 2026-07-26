# Function macro used to force the "value" field to a double
# Returns a 1 if the macro ran

$execute facing 0.0 0.0 $(value) run data modify storage reds_vehicles:definitions working_physics.value set value $(value)f

# Success!
return 1
