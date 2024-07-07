# Wrapper for reds_vehicles:define/assert_fail that automatically fills in vehicle name

# Compile arguments
$data merge storage reds_vehicles:definitions {assert_working_fail_args: {description: '$(description)', source: '$(source)'}}
data modify storage reds_vehicles:definitions assert_working_fail_args.vehicle set from storage reds_vehicles:definitions working.name

# Call function with arguments
function reds_vehicles:define/assert_fail with storage reds_vehicles:definitions assert_working_fail_args

# Clean up arguments
data remove storage reds_vehicles:definitions assert_working_fail_args
