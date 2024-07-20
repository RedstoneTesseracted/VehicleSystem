# This function uses a recursion-based loop to iterate over
# the reds_vehicles:definitions.unapplied_scores list

# Apply score using first element
function reds_vehicles:summon/__set_score_loop with storage reds_vehicles:definitions unapplied_scores[0]

# Remove first element
data remove storage reds_vehicles:definitions unapplied_scores[0]

# Run again if unapplied scores remain
execute if data storage reds_vehicles:definitions unapplied_scores[0] run function reds_vehicles:summon/set_score_loop
