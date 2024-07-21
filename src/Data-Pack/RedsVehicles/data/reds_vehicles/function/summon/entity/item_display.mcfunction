# This function summons and configures an item display entity
# It is called from reds_vehicles:summon/entity_loop

# Summon the entity while having it run applicable configuration functions
execute summon minecraft:item_display run function reds_vehicles:summon/entity/__item_display
