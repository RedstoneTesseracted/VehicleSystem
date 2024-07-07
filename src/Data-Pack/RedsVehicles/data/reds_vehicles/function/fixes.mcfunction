# This function fixes potentially invalid states, such as broken triggers
# We do this out of an abundance of caution

# Hard-reset some scores
scoreboard players reset * vehicle.showlog

# Reschedule periodic functions
schedule function reds_vehicles:20t 1s replace

# Run player fixes for all players
execute as @a run function reds_vehicles:fix_player
