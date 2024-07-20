# This function handles setting the default scores of newly spawned vehicles
# It is called from reds_vehicles:summon/configure_base
# It is run BY and AT the vehicle base entity

# Copy over the list of default scores to a buffer
data modify storage reds_vehicles:definitions unapplied_scores set from storage reds_vehicles:definitions summon.default_scores

# Execute loop
execute if data storage reds_vehicles:definitions unapplied_scores[0] run function reds_vehicles:summon/set_score_loop

# Clear temporary storage
data remove storage reds_vehicles:definitions unapplied_scores
data remove storage reds_vehicles:definitions current_score
