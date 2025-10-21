# Function macro called by reds_vehicles:physics/utility/uniform_quadratic_drag_helper

# Abuse display entities to calculate b|𝘃|
$data modify entity @s transformation set value [\
$(vx)f,0.0f,0.0f,0.0f,\
$(vy)f,0.0f,0.0f,0.0f,\
$(vz)f,0.0f,0.0f,0.0f,\
0.0f,0.0f,0.0f,$(invb)f]

# Now add 1 to that to get 1+b|𝘃|
execute store result score vehicle.denominator vehicle.local run data get entity @s transformation.scale[0] 100000
scoreboard players add vehicle.denominator vehicle.local 100000

# $say $(vx), $(vy), $(vz), $(invb)
# tellraw @a [{text: "b|𝘃|: "},{nbt: "transformation.scale[0]", "entity": "@s"}]
# tellraw @a [{text: "denominator: "},{"score": {"name": "vehicle.denominator", "objective": "vehicle.local"}}]

# Multiply inverse with velocity vector
$data modify storage reds_vehicles:physics temp.arr set value [1.0f,0.0f,0.0f,$(vx)f,0.0f,1.0f,0.0f,$(vy)f,0.0f,0.0f,1.0f,$(vz)f,0.0f,0.0f,0.0f,1.0f]
execute store result storage reds_vehicles:physics temp.arr[-1] float 0.00001 run scoreboard players get vehicle.denominator vehicle.local
# tellraw @a [{text: "1+b|𝘃|: "},{nbt: "temp.arr[-1]", storage: "reds_vehicles:physics"}]
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr

# Return to scoreboard values.  This should never by NaN or inf, due to 1+b|𝘃| > 0
execute store result score vehicle.vel.x vehicle.local run data get entity @s transformation.translation[0] 100000
execute store result score vehicle.vel.y vehicle.local run data get entity @s transformation.translation[1] 100000
execute store result score vehicle.vel.z vehicle.local run data get entity @s transformation.translation[2] 100000

# tellraw @a [{text: "vx: "},{"score": {"name": "vehicle.vel.x", "objective": "vehicle.local"}},{text: ", vy: "},{"score": {"name": "vehicle.vel.y", "objective": "vehicle.local"}},{text: ", vz: "},{"score": {"name": "vehicle.vel.z", "objective": "vehicle.local"}}]
