# This function validates the fields specific to the physics type
#
# Returns 1 on success, -1 on failure, and 0 on macro fail

# Run corresponding function
$execute if function reds_vehicles:define/physics/type/$(type) run return 1

# General failure (non-macro)
return -1
