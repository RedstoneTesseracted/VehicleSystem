# Function macro called by apply_camera_multiplier to add an attribute multiplier with an arbitrary value

attribute @s minecraft:camera_distance modifier remove reds_vehicles:camera_multiplier
$attribute @s minecraft:camera_distance modifier add reds_vehicles:camera_multiplier $(amount) add_multiplied_base
