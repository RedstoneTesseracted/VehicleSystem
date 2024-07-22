# This function uses a recursion-based loop to apply various defined physics forces
# It is run BY and AT the base vehicle entity
# It is called from reds_vehicles:physics/apply_forces

# Execute the relevant force if the predicate is fulfilled
#$execute if entity @s[tag=vehicle.force_active.$(type)] run tag @s add vehicle.force.was_enabled
#$execute if entity @s[tag=vehicle.force.was_enabled] run say $(type) force was active last tick
#$tag @s remove vehicle.force_active.$(type)
$execute $(predicate)run function reds_vehicles:physics/types/$(type) with storage reds_vehicles:physics unapplied_forces[0]
#$execute $(predicate)run say confirmed $(type) passed predicate
#$execute if entity @s[tag=vehicle.force_active.$(type)] run say $(type) force DID just run
#$execute if entity @s[tag=!vehicle.force_active.$(type)] run say $(type) force did NOT just run
#$execute if entity @s[tag=vehicle.force.was_enabled] if entity @s[tag=!vehicle.force_active.$(type)] run say $(type) was previously enabled but is no longer
#$execute if entity @s[tag=vehicle.force.was_enabled,tag=!vehicle.force_active.$(type)] run function reds_vehicles:physics/on_disable/$(type)
#tag @s remove vehicle.force.was_enabled

# Remove first element in list and run again if any forces remain
data remove storage reds_vehicles:physics unapplied_forces[0]
execute if data storage reds_vehicles:physics unapplied_forces[0] run function reds_vehicles:physics/apply_forces_loop with storage reds_vehicles:physics unapplied_forces[0]
