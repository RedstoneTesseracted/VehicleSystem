# This function is run whenever the pilot left-clicks on the hitbox interaction while riding it
# It is called using an advancement trigger

# Mark the pilot seat as having just been left-clicked on
execute on vehicle on vehicle on passengers if entity @s[tag=vehicle.hitbox] run tag @s add vehicle.left_clicked_by_pilot

# Reset the advancement trigger
advancement revoke @s only reds_vehicles:hidden/left_click_while_riding
