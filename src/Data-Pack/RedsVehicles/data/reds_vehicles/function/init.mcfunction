# This function initializes various scoreboards for the vehicle system

# Create scoreboard objectives
scoreboard objectives add vehicle.local dummy

# Global configuration
# Show number of vehicles upon reload [0=no,1=yes; default=0 (no)]
scoreboard objectives add vehicle.config.show_vehicle_count_on_reload dummy
scoreboard objectives add vehicle.config.notify_errors_on_reload dummy
execute unless score config vehicle.config.show_vehicle_count_on_reload matches -2147483648..2147483647 run scoreboard players set config vehicle.config.show_vehicle_count_on_reload 0
execute unless score config vehicle.config.notify_errors_on_reload matches -2147483648..2147483647 run scoreboard players set config vehicle.config.notify_errors_on_reload 1

# Constants
scoreboard objectives add vehicle.constants dummy
scoreboard players set 2 vehicle.constants 2
scoreboard players set 4 vehicle.constants 4
scoreboard players set 10 vehicle.constants 10
scoreboard players set 20 vehicle.constants 20
scoreboard players set 100 vehicle.constants 100

# Vehicle control/movement scores
scoreboard objectives add vehicle.last_interaction_time dummy
scoreboard objectives add vehicle.last_interaction_uuid1 dummy
scoreboard objectives add vehicle.last_interaction_uuid2 dummy
scoreboard objectives add vehicle.last_interaction_uuid3 dummy
scoreboard objectives add vehicle.last_interaction_uuid4 dummy

# scoreboard objectives add vehicle.vel.x dummy
# scoreboard objectives add vehicle.vel.y dummy
# scoreboard objectives add vehicle.vel.z dummy

# scoreboard objectives add vehicle.acc.x dummy
# scoreboard objectives add vehicle.acc.y dummy
# scoreboard objectives add vehicle.acc.z dummy

# scoreboard objectives add vehicle.input.x dummy
# scoreboard objectives add vehicle.input.y dummy
# scoreboard objectives add vehicle.input.z dummy



# Standard vehicle scoreboards
# Rotation
scoreboard objectives add vehicle.rot.yaw dummy
scoreboard objectives add vehicle.rot.pitch dummy
scoreboard objectives add vehicle.rot.roll dummy

# Motion control
scoreboard objectives add vehicle.dvel.x dummy
scoreboard objectives add vehicle.dvel.y dummy
scoreboard objectives add vehicle.dvel.z dummy

# Motion control
scoreboard objectives add vehicle.accel.forward dummy

# State
scoreboard objectives add vehicle.engine dummy
scoreboard objectives add vehicle.event.firework dummy
scoreboard objectives add vehicle.event.honk dummy
scoreboard objectives add vehicle.event.shoot dummy
scoreboard objectives add vehicle.event.cooldown dummy

# Attributes
scoreboard objectives add vehicle.thrust dummy
scoreboard objectives add vehicle.version dummy



# Vehicle attributes
# Thrust multiplier (x100 FP)
#scoreboard objectives add vehicle.max_thrust dummy
#scoreboard objectives add vehicle.applied_thrust dummy

# Control types:
#  1: Full 3D motion in space
#  2: 2D motion confined to XZ plane
#  3: Full 3D motion in space, input vector based on player's direction instead of Motion tag
#  4: 2D motion confined to XZ plane, input vector based on player's direction instead of Motion tag
#scoreboard objectives add vehicle.control_type dummy

# Physics types:
#  1: Vehicle accelerates in direction of input vector, scaled by thrust
#  2: Vehicle instantly moves in direction of input vector with a speed determined by thrust
#  3: Vehicle accelerates in direction of input vector and experiences lift (i.e. plane)
#scoreboard objectives add vehicle.physics_type dummy

# Environment types:
#  0: Any non-solid environment is allowed
#  1: Only air is allowed
#  2: Only water is allowed
#  3: Only lava is allowed
#scoreboard objectives add vehicle.environment_type dummy

# Environment penalty types:
#  0: No penalty for being in incorrect environment
#  1: Sinking, decreased movement speed
#  2: Sinking, zero movement speed
#  3: Disable vehicle functionality permanently
#  4: Explode vehicle
#scoreboard objectives add vehicle.environment_penalty_type dummy


# Schedule periodic functions
schedule function reds_vehicles:20t 1s replace

# Trigger variables
scoreboard objectives add vehicle.showlog trigger
scoreboard objectives add vehicle.listvehicles trigger

# Reload the vehicle definition table
function reds_vehicles:define/reload

# Reset triggers for all players
function reds_vehicles:fixes
