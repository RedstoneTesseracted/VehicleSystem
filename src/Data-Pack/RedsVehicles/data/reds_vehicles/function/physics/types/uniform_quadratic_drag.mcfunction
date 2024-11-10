# This functions handles a uniform quadratic drag force
#
# The resulting acceleration is calculated using:
#   a = bv²
#
# Where:
#   a = Acceleration
#   b = Drag constant
#   v = Velocity
#
# In vector form:
#   𝒂 = -b|𝘃|𝘃
#
# Computing this with Euler's method is unstable for 
# sufficiently high velocities.
#
# To circumvent this, we use a different method here.
# Assuming the absence of any other force (good enough
# for our purposes), quadratic drag can be solved exactly:
#           1
#   𝘃₂ = ———————— 𝘃₁
#        1+bΔt|𝘃|
#
# Where:
#   Δt = Some jump in time
#   𝘃₁ = Initial velocity vector
#   𝘃₂ = Velocity vector after jump in time, Δt
#   b = Drag coefficient
#
# Here, Δt = 1 tick, reducing the problem to:
#           1
#   𝘃₂ = —————— 𝘃₁
#        1+b|𝘃|
#

# Set up storage for calculations
# scoreboard players add vehicle.vel.y vehicle.local 7841
execute store result storage reds_vehicles:physics temp.vx double 0.00001 run scoreboard players get vehicle.vel.x vehicle.local
execute store result storage reds_vehicles:physics temp.vy double 0.00001 run scoreboard players get vehicle.vel.y vehicle.local
execute store result storage reds_vehicles:physics temp.vz double 0.00001 run scoreboard players get vehicle.vel.z vehicle.local
# scoreboard players remove vehicle.vel.y vehicle.local 7841

# Obtain the magnitude of the velocity
execute summon minecraft:block_display run function reds_vehicles:physics/utility/uniform_quadratic_drag_helper



