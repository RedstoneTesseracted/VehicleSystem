# This function is used by reds_vehicles:physics/types/simple_lift to shift execution context 
# to a temporary display entity
#
# This allows us to use @s to improve performance


# Multiply |𝗩| and norm(𝗩)•𝗨 to obtain 𝗩•𝗨
$data modify storage reds_vehicles:physics temp.arr set value [1.0f,0.0f,0.0f,0.0f,0.0f,1.0f,0.0f,0.0f,0.0f,0.0f,1.0f,0.0f,0.0f,0.0f,0.0f,$(dot)f]
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr
data modify storage reds_vehicles:physics temp.arr[-1] set from entity @s transformation.scale[0]
$data modify storage reds_vehicles:physics temp.arr[0] set value $(vmag)f
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr

# title @a actionbar [{"nbt":"transformation.scale[0]","entity": "@s"}]

# > Compute 1/(𝗩•𝗨)
data modify storage reds_vehicles:physics temp.arr[-1] set from entity @s transformation.scale[0]
data modify storage reds_vehicles:physics temp.arr[0] set value 1.0
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr
# > Compute b(𝗩•𝗨)=b/[1/(𝗩•𝗨)]
data modify storage reds_vehicles:physics temp.arr[-1] set from entity @s transformation.scale[0]
$data modify storage reds_vehicles:physics temp.arr[0] set value $(b)f
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr
# > Compute b(𝗩•𝗨)²=b/[1/(𝗩•𝗨)]²
data modify storage reds_vehicles:physics temp.arr[0] set from entity @s transformation.scale[0]
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr


# title @a actionbar [{"nbt": "temp.arr","storage": "reds_vehicles:physics"}]
# title @a actionbar [{"nbt": "transformation.scale","entity": "@s"}]

# Since NaN is interpreted as zero, this check helps ensure NaNs aren't getting introduced into calculations
# The massive scale factor helps prevent small values from being rounded to zero
execute store result score vehicle.as_int vehicle.local run data get entity @s transformation.scale[0] 4294967296
# execute if score vehicle.as_int vehicle.local matches 0 run say check
execute if score vehicle.as_int vehicle.local matches 0 run data modify storage reds_vehicles:physics temp.a set value 0.0f
execute if score vehicle.as_int vehicle.local matches 0 run kill @s[type=minecraft:block_display]
execute if score vehicle.as_int vehicle.local matches 0 run return 0


# # Set to zero if NaN
# data modify storage reds_vehicles:physics temp.a set from storage reds_vehicles:constants nan
# # title @a actionbar [{"nbt": "nan","storage": "reds_vehicles:constants"},{"text":", "},{"nbt": "transformation.scale[0]","entity": "@s"}]
# execute store result score vehicle.is_zero vehicle.local run data modify storage reds_vehicles:physics temp.a set from entity @s transformation.scale[0]
# execute store result score vehicle.is_zero vehicle.local run data get entity @s transformation.scale[0]
# tellraw @a [{"nbt": "nan","storage": "reds_vehicles:constants"},{"text":", "},{"nbt": "transformation.scale[0]","entity": "@s"},{"text":", "},{"score": {"name": "vehicle.is_zero", "objective": "vehicle.local"}}]
# execute if score vehicle.is_zero vehicle.local matches 0 run say check
# execute if score vehicle.is_zero vehicle.local matches 0 run data modify storage reds_vehicles:physics temp.a set value 0.0f
# execute if score vehicle.is_zero vehicle.local matches 0 run return 0

# Send result to storage
data modify storage reds_vehicles:physics temp.a set from entity @s transformation.scale[0]
# title @a actionbar [{"nbt": "temp.a","storage": "reds_vehicles:physics"},{"text":", "},{"nbt": "transformation.scale[0]","entity": "@s"}]


# Clean up temporary storage
data remove storage reds_vehicles:physics temp.arr

