# This function handles removing all gravity modifiers with the reds_vehicles: prefix\
# It sets up a temporary buffer that reds_vehicles:physics/reset_gravity_loop can loop over
#
# It is called from reds_vehicles:physics/apply
# It is run BY and AT the base vehicle entity

# Create temporary buffer
data modify storage reds_vehicles:physics modifiers set from entity @s attributes[{id:"minecraft:generic.gravity"}].modifiers

# Loop over modifiers list
function reds_vehicles:physics/reset_gravity_loop with storage reds_vehicles:physics modifiers[0]

# Delete temporary buffer
data remove storage reds_vehicles:physics modifiers
data remove storage reds_vehicles:physics compare

