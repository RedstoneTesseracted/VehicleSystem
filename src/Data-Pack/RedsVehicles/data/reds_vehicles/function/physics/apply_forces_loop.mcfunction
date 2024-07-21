# This function uses a recursion-based loop to apply various defined physics forces
# It is run BY and AT the base vehicle entity
# It is called from reds_vehicles:physics/apply_forces

# Execute the relevant force if the predicate is fulfilled
$execute $(predicate)run function reds_vehicles:physics/types/$(type)

# Remove first element in list and run again if any forces remain
data remove storage reds_vehicles:physics unapplied_forces[0]
execute if data storage reds_vehicles:physics unapplied_forces[0] run function reds_vehicles:physics/apply_forces_loop with storage reds_vehicles:physics unapplied_forces[0]
