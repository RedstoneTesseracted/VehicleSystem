# This function wraps the macro used by reds_vehicles:physics/utility/precision_vector_normalize
#
# This is to ensure the /kill command in precision_vector_normalize runs even when the macro fails

# Funky transformation shenanigans to normalize vector
$data modify entity @s transformation.left_rotation set value [$(vx)f,$(vy)f,$(vz)f,0.0f]
data modify storage reds_vehicles:physics temp.nvx set from entity @s transformation.left_rotation[0]
data modify storage reds_vehicles:physics temp.nvy set from entity @s transformation.left_rotation[1]
data modify storage reds_vehicles:physics temp.nvz set from entity @s transformation.left_rotation[2]

# Funky transformation shenanigans to compute magnitude
$data modify entity @s transformation set value [\
$(vx)f,0.0f,0.0f,0.0f,\
$(vy)f,0.0f,0.0f,0.0f,\
$(vz)f,0.0f,0.0f,0.0f,\
0.0f,0.0f,0.0f,1.0f]
data modify storage reds_vehicles:physics temp.vmag set from entity @s transformation.scale[0]
