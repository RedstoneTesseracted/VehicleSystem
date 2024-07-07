# This function contains several fixes for player states that *shouldn't* occur
# We do this out of an abundance of caution
# It is run BY the player

# Reset score-based triggers
scoreboard players reset @s vehicle.showlog
scoreboard players enable @s vehicle.showlog

# Reset advancement-based triggers
advancement revoke @s only reds_vehicles:hidden/seat_interact
advancement revoke @s only reds_vehicles:hidden/showlog_trigger
