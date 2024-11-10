# This function transforms a vector from camera (u,v,w) coordinates to world 
# (x, y, z) coordinates.  However, this function takes yaw, pitch, AND roll
# into account.
#
# The result is stored in the temp.[dx,dy,dz] tags in the reds_vehicles:physics storage.
#
# The following must be set up externally for this function to work as intended:
# | Name  |                Description               |                   Providing                    |
# | ----- | ---------------------------------------- | ---------------------------------------------- |
# |  u    | Vector u-component in camera coordinates | temp.u tag in reds_vehicles:physics storage    |
# |  v    | Vector v-component in camera coordinates | temp.v tag in reds_vehicles:physics storage    |
# |  w    | Vector w-component in camera coordinates | temp.w tag in reds_vehicles:physics storage    |
# | yaw   | Camera yaw                               | yaw from this function's execution context     |
# | pitch | Camera pitch                             | pitch from this function's execution context   |
# | roll  | Camera roll                              | temp.roll tag in reds_vehicles:physics storage |
#
# This function will then pass said information to a macro that does the heavy-lifting.

# First, take yaw and pitch into account
execute positioned 0.0 0.0 0.0 run function reds_vehicles:physics/utility/precision_roll_helper_part1 with storage reds_vehicles:physics temp

# title @a actionbar [{"text":"dx: "},{"nbt": "temp.dx","storage": "reds_vehicles:physics"},{"text":", dy: "},{"nbt": "temp.dy","storage": "reds_vehicles:physics"},{"text":", dz: "},{"nbt": "temp.dz","storage": "reds_vehicles:physics"}]

# Next, take roll into account
execute positioned 0.0 0.0 0.0 run function reds_vehicles:physics/utility/precision_roll_helper_part2 with storage reds_vehicles:physics temp
