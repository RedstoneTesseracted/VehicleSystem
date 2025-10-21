# This function is used by reds_vehicles:physics/types/side_linear_drag to shift execution context 
# to a temporary display entity
#
# This allows us to use @s to improve performance

# > Compute 1/[norm(𝗩)•𝗪]
$data modify storage reds_vehicles:physics temp.arr set value [1.0f,0.0f,0.0f,1.0f,0.0f,1.0f,0.0f,0.0f,0.0f,0.0f,1.0f,0.0f,0.0f,0.0f,0.0f,$(dot)f]
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr
# > Compute 1/[𝗩•𝗪] = 1/[norm(𝗩)•𝗪]/|𝗩|
$data modify storage reds_vehicles:physics temp.arr[-1] set value $(vmag)f
data modify storage reds_vehicles:physics temp.arr[3] set from entity @s transformation.translation[0]
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr
# tellraw @a [{text:"1/[𝗩•𝗪]: "},{nbt: "transformation.translation[0]","entity": "@s"}]
# > Compute 1/[b(𝗩•𝗪)]
$data modify storage reds_vehicles:physics temp.arr[-1] set value $(b)f
data modify storage reds_vehicles:physics temp.arr[3] set from entity @s transformation.translation[0]
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr
# tellraw @a [{text:"1/[b(𝗩•𝗪)]: "},{nbt: "transformation.translation[0]","entity": "@s"}]


# The final acceleration vector is parallel to 𝗪 with a magnitude proportional by the above factor
# So, we just need to multiply the components of 𝗪 by the above scale factor
$data modify storage reds_vehicles:physics temp.arr set value [1.0f,0.0f,0.0f,$(dx)f,0.0f,1.0f,0.0f,$(dy)f,0.0f,0.0f,1.0f,$(dz)f,0.0f,0.0f,0.0f,1.0f]
data modify storage reds_vehicles:physics temp.arr[-1] set from entity @s transformation.translation[0]
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr


# title @a actionbar [{nbt: "temp.arr",storage: "reds_vehicles:physics"}]
# title @a actionbar [{nbt: "transformation.translation","entity": "@s"}]

# Since NaN is interpreted as zero, this check helps ensure NaNs aren't getting introduced into calculations
# The massive scale factor helps prevent small values from being rounded to zero
# Infinity, meanwhile, is interpreted as 2147483647.  If we get that number, then just set it to zero
execute store result score vehicle.as_int vehicle.local run data get entity @s transformation.translation[0] 4294967296
# title @a actionbar [{"score": {"name": "vehicle.as_int","objective": "vehicle.local"}}]
execute if score vehicle.as_int vehicle.local matches 2147483647 run scoreboard players set vehicle.as_int vehicle.local 0
# execute if score vehicle.as_int vehicle.local matches 0 run say check
execute if score vehicle.as_int vehicle.local matches 0 run data merge storage reds_vehicles:physics {temp: {dx: 0.0f, dy: 0.0f, dz: 0.0f}}
execute if score vehicle.as_int vehicle.local matches 0 run kill @s[type=minecraft:block_display]
execute if score vehicle.as_int vehicle.local matches 0 run return 0

# Send calculated values to final output
data modify storage reds_vehicles:physics temp.dx set from entity @s transformation.translation[0]
data modify storage reds_vehicles:physics temp.dy set from entity @s transformation.translation[1]
data modify storage reds_vehicles:physics temp.dz set from entity @s transformation.translation[2]



# Clean up temporary storage
data remove storage reds_vehicles:physics temp.arr

