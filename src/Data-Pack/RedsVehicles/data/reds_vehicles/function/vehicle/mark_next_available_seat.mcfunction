# This function marks the next unoccupied seat with the tag "vehicle.next_available_seat"
# For this, the pilot seat always takes priority.  If that's unavailable, other seats are
# attempted in an arbitrary order.
#
# Returns 1 if an open seat was found, 0 otherwise.
#
# Currently, none of this actually matters, since we don't support multi-seat vehicles yet.
# However, should that ever change this function will be ready.
#
# This function is used by reds_vehicles:interact/ride_vehicle to determine which seat the
# player should mount.
#
# This is run BY the base vehicle entity

# Clear tags for safety
tag @e[tag=vehicle.next_available_seat] remove vehicle.next_available_seat

# Check if pilot seat is taken
execute on passengers if entity @s[tag=vehicle.pilot_seat] unless predicate reds_vehicles:has_passenger run tag @s add vehicle.next_available_seat
execute on passengers if entity @s[tag=vehicle.next_available_seat] run return 1

# Try other seats in an arbitrary order
execute on passengers if entity @s[tag=vehicle.seat,predicate=!reds_vehicles:has_passenger] run execute unless entity @e[tag=vehicle.next_available_seat] run tag @s add vehicle.next_available_seat
execute on passengers if entity @s[tag=vehicle.next_available_seat] run return 1

# No seat could be found
return 0
