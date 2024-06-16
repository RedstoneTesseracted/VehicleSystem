# This function handles the per-tick functionality of vehicles when they are mounted by the player
# It is run BY and AT the vehicle base entity WHEN its seat is occupied

# Get direction the player is trying to move in
function reds_vehicles:input/gather

# Update the model rotation to match the player's facing direction
