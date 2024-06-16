# This function handles the per-tick functionality of "orb" vehicles
# It is run BY and AT the root armor stand entities
#
# How orbs work:
#   The orb is composed of three entities:
#   	1) The base entity—an armor stand—that handles all motion.
#          It's hitbox is made tiny using the scale attribute, since 
#          the marker tag disables motion.
#          It's gravity is disbled using the gravity attribute, since 
#          the NoGravity tag disables motion.
#          It is rendered invisible using the Invisible tag.
#       2) The item display used for the main model.  It is mounted on 
#          the base entity, and has its rotation match the orb's 
#          current direction of rotation.
#       3) The interaction entity that the player mounts.  It itself is 
#          mounted on the base entity.
#
#   The orb is controlled similarly to a horse, albeit in 3D.
#   When the player is mounted on an entity, attempting to move will
#   update their Motion tag.  We use this to determine when the player 
#   is trying to move forward/backward/left/right by comparing against 
#   their facing vector.
#


