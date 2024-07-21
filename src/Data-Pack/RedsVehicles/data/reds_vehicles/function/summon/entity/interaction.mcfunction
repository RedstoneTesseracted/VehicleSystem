# This function summons and configures an interaction entity
# It is called from reds_vehicles:summon/entity_loop

# Summon the entity while having it run applicable configuration functions
execute summon minecraft:interaction run function reds_vehicles:summon/entity/__interaction with storage reds_vehicles:definitions working_entity
