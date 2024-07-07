# This function shows the error log for the player who called it
# Serves as a wrapper for reds_vehicles:define/show_errors that sets the context to this players
#
# It is run BY the player using an advancement trigger

# Reset the advancement trigger
advancement revoke @s only reds_vehicles:hidden/showlog_trigger

# Reset the scoreboard trigger
scoreboard players reset @s vehicle.showlog
scoreboard players enable @s vehicle.showlog

# Show error log
function reds_vehicles:define/notify/show_errors
