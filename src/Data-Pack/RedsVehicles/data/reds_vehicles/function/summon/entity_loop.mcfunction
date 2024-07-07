# This function iterates through the unsummoned entities list
# and mounts them to the base vehicle entity
#
# It is called from reds_vehicles:summon/spawn

# Pop first element
data modify storage reds_vehicles:definitions working_entity set from storage reds_vehicles:definitions unsummoned_entities[0]
data remove storage reds_vehicles:definitions unsummoned_entities[0]


# Summon entity corresponding to this type
function reds_vehicles:summon/__entity_loop with storage reds_vehicles:definitions working_entity


# Run again if unsummoned entities remain
execute if data storage reds_vehicles:definitions unsummoned_entities[0] run function reds_vehicles:summon/entity_loop

