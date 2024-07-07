# This function runs every 20 ticks using the /schedule command

# Re-enable scoreboard triggers
scoreboard players enable @a vehicle.showlog

# Schedule this function to run again
schedule function reds_vehicles:20t 1s replace
