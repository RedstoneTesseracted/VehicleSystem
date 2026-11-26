# This function runs whenever a player rejoins.
# This is mainly used to refresh recipes upon re-logging

# Reset score used to trigger this function
scoreboard players set @s vehicle.leave_game 0

# Refresh granted recipes
function #reds_vehicles:grant_recipes
