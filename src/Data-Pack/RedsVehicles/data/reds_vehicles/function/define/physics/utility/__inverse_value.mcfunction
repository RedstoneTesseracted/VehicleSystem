# Used by reds_vehicles:define/physics/utility/inverse_value to perform inversion

$data modify entity @s transformation set value [\
1.0f, 0.0f, 0.0f, 0.0f, \
0.0f, 1.0f, 0.0f, 0.0f, \
0.0f, 0.0f, 1.0f, 0.0f, \
0.0f, 0.0f, 0.0f, $(value)f]

data modify storage reds_vehicles:definitions working_physics.inverse_value set from entity @s transformation.scale[0]

# Success!
return 1
