# This function is used to determine the vertical and horizontal drag coefficients
# that an entity is subject to

# Case: in water (slipperiness does not apply)
execute if predicate reds_vehicles:drag/water run return run function reds_vehicles:physics/utility/drag/water

# Case: in lava (slipperiness does not apply)
execute if predicate reds_vehicles:drag/lava run return run function reds_vehicles:physics/utility/drag/lava

# We can safely assume default vertical drag
data modify storage reds_vehicles:physics temp.vdrag set value 0.9800000190734863

# Case: in air, not landed
execute unless predicate reds_vehicles:drag/landed run return run function reds_vehicles:physics/utility/drag/mid_air

# Case: in air, landed (slipperiness depends on block)
data modify storage reds_vehicles:physics temp.vdrag set value 0.546
execute if predicate reds_vehicles:drag/on_slippery run function reds_vehicles:physics/utility/drag/slippery_block
