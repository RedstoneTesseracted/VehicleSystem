# This function is run whenever a player left-clicks on the pilot seat interaction while riding it
# It is called using an advancement trigger

# Mark the pilot seat as having just been left-clicked on
execute on vehicle if entity @s[tag=vehicle.pilot_seat] run tag @s add vehicle.left_clicked_by_pilot

# Reset the advancement trigger
advancement revoke @s only reds_vehicles:hidden/left_click_seat_while_riding
