# This function handles the force applied by the pilot

# Via vehicle.dvel.*
execute if predicate reds_vehicles:nonzero_dvel run function reds_vehicles:physics/dvel with storage reds_vehicles:physics unapplied_forces[0]
# Via vehicle.accel.forward
execute unless score @s vehicle.accel.forward matches 0 run function reds_vehicles:physics/accel_forward with storage reds_vehicles:physics unapplied_forces[0]

# Mark this force as active
#tag @s add vehicle.force_active.applied
