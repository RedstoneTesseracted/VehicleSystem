# This function is run whenever a player right-clicks on the pilot seat interaction while riding it
# It is called using an advancement trigger

# Mark the pilot seat as having just been right-clicked on
execute on vehicle if entity @s[tag=vehicle.pilot_seat] run tag @s add vehicle.right_clicked_by_pilot

# Reset the advancement trigger
advancement revoke @s only reds_vehicles:hidden/right_click_seat_while_riding
