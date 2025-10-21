# Action for displaying a message to the passengers

# execute on passengers if entity @s[tag=vehicle.seat] on passengers run say hi
execute on passengers if entity @s[tag=vehicle.seat] on passengers run tag @s add vehicle.message.context
title @a[tag=vehicle.message.context] actionbar {nbt: "unapplied_actions[0].arguments.text", storage: "reds_vehicles:events",interpret: true}
tag @a[tag=vehicle.message.context] remove vehicle.message.context

# Reset trigger (if it exists)
execute if data storage reds_vehicles:events unchecked_events[0].trigger run function reds_vehicles:events/reset_trigger_score with storage reds_vehicles:events unchecked_events[0]
