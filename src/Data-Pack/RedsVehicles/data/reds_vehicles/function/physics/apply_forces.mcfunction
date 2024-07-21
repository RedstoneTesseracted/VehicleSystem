# This function handles the application of all non-gravity forces upon the vehicle
#
# It is called from reds_vehicles:vehicle/apply
# It is run BY and AT the base vehicle entity

# Create temporary buffer for physics forces
data modify storage reds_vehicles:physics unapplied_forces set from storage reds_vehicles:definitions current.physics

# Perform loop
execute if data storage reds_vehicles:physics unapplied_forces[0] run function reds_vehicles:physics/apply_forces_loop with storage reds_vehicles:physics unapplied_forces[0]

# Clean up storage
data remove storage reds_vehicles:physics unapplied_forces
