# Action for spawning a projectile

tellraw @p {"text":"Not yet implemented","color":"red"}

# Reset trigger (if it exists)
execute if data storage reds_vehicles:events unchecked_events[0].trigger run function reds_vehicles:events/reset_trigger_score with storage reds_vehicles:events unchecked_events[0]
