# This function is run whenever the pilot right-clicks on the hitbox interaction while riding it
# It is called using an advancement trigger

# Mark the pilot seat as having just been right-clicked on
execute on vehicle on vehicle on passengers if entity @s[tag=vehicle.hitbox] run tag @s add vehicle.right_clicked_by_pilot

# Reset the advancement trigger
advancement revoke @s only reds_vehicles:hidden/right_click_while_riding
