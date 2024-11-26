# Action for toggling a vehicle score between 0 and 1

# Reset trigger (if it exists)
execute if data storage reds_vehicles:events unchecked_events[0].trigger run function reds_vehicles:events/reset_trigger_score with storage reds_vehicles:events unchecked_events[0]

# Toggle score.  We return immediately from the first command (if run)
# to avoid running the second command and clobbering the first
$execute if score @s $(name) matches 0 run return run scoreboard players set @s $(name) 1
$scoreboard players set @s $(name) 0
