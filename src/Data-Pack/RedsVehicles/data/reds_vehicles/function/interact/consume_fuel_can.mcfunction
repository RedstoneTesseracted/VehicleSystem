# This function consumes a single fuel can from the player's hand

item modify entity @s weapon.mainhand reds_vehicles:consume_item
playsound minecraft:item.bucket.empty block @a ~ ~ ~ 1 0.625
