# Function macro used to convert the single-precision float result from __counter_drag
# to the double-precision expected by the Motion tag.  This function also places
# the result into the calling entity's (the vehicle's) Motion tag

$data modify entity @s Motion[0] set value $(mx)
$data modify entity @s Motion[1] set value $(my)
$data modify entity @s Motion[2] set value $(mz)
