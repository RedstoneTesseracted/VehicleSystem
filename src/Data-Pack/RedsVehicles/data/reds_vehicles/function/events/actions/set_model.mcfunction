# Action for setting an item display model

# Execute on all passenger item displays with a matching name
$execute on passengers if entity @s[type=minecraft:item_display,name=$(name)] run data modify entity @s item.components."minecraft:item_model" set value "$(value)"

# Reset trigger (if it exists)
execute if data storage reds_vehicles:events unchecked_events[0].trigger run function reds_vehicles:events/reset_trigger_score with storage reds_vehicles:events unchecked_events[0]

