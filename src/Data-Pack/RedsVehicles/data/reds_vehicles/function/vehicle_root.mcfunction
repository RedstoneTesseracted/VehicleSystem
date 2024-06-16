# This is the base function executed by all vehicle base entities every tick
# It is run BY and AT the vehicle entities

# Handle behavior when the seat is occupied
execute if predicate reds_vehicles:has_passenger run function reds_vehicles:when_mounted

# Handle interaction with environment
execute unless score @s vehicle.environment_type matches 0 unless score @s vehicle.environment_penalty_type matches 0 if function reds_vehicles:environment/check_bad_environment run function reds_vehicles:environment/set_penalty_state
execute unless score @s vehicle.environment_type matches 0 unless score @s vehicle.environment_penalty_type matches 0 run function reds_vehicles:environment_penalty/handle_penalty

# Update movement
function reds_vehicles:physics/apply_physics

# Handle collision

