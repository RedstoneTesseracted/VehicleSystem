# Function used to add a tag to an entity that's part of a vehicle
# such that the tag contains the vehicle's name
data modify storage reds_vehicles:definitions args.name set from storage reds_vehicles:definitions summon.name
function reds_vehicles:summon/__entity_assign_vehicle_tag with storage reds_vehicles:definitions args
data remove storage reds_vehicles:definitions args
