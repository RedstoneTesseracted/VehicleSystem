# Inner function macro used by l

# Horizontal drag
$data modify storage reds_vehicles:physics temp.arr set value [0.0f,0.0f,0.0f,$(vx)f,0.0f,0.0f,0.0f,$(vy)f,0.0f,0.0f,0.0f,$(vz)f,0.0f,0.0f,0.0f,$(hdrag)f]
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr
data modify storage reds_vehicles:physics temp.mx set from entity @s transformation.translation[0]
data modify storage reds_vehicles:physics temp.mz set from entity @s transformation.translation[2]

# Vertical drag
$data modify storage reds_vehicles:physics temp.arr[-1] set value $(vdrag)f
data modify entity @s transformation set from storage reds_vehicles:physics temp.arr
data modify storage reds_vehicles:physics temp.my set from entity @s transformation.translation[1]
