# This function initializes various scoreboards for the vehicle system

# Create scoreboard objectives
scoreboard objectives add vehicle.local dummy
scoreboard objectives add vehicle.global dummy

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
scoreboard players set 1000 vehicle.constants 1000
execute store result score vehicle.datapack_format vehicle.constants run function reds_vehicles:datapack_format
execute unless score vehicle.reload_counter vehicle.constants matches -2147483648..2147483647 run scoreboard players set config vehicle.config.notify_errors_on_reload 0
scoreboard players add vehicle.reload_counter vehicle.constants 1
execute store result score vehicle.last_reload_version vehicle.constants run function reds_vehicles:version

# Vehicle control/movement scores
scoreboard objectives add vehicle.last_interaction_time dummy
scoreboard objectives add vehicle.last_interaction_uuid1 dummy
scoreboard objectives add vehicle.last_interaction_uuid2 dummy
scoreboard objectives add vehicle.last_interaction_uuid3 dummy
scoreboard objectives add vehicle.last_interaction_uuid4 dummy


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


# Schedule periodic functions
schedule function reds_vehicles:20t 1s replace

# Trigger variables
scoreboard objectives add vehicle.showlog trigger
scoreboard objectives add vehicle.listvehicles trigger
scoreboard objectives modify vehicle.showlog displayname {"text":"Show error log","color":"aqua"}
scoreboard objectives modify vehicle.listvehicles displayname {"text":"List loaded vehicles","color":"aqua"}

# Reload the vehicle definition table
schedule function reds_vehicles:delayed_reload_check 1t
function reds_vehicles:define/reload

# Reset triggers for all players
function reds_vehicles:fixes
