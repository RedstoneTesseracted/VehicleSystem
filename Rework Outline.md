# Environment system rework

* Currently allows land vehicles to go way too fast in the air

## Option 1: X_environment_reaction

Implement concept of "environments."  Possible environments are:

* Under water
* Under lava
* Mid-air
* On dry land
* Water surface
* Lava surface

The current environment is determined automatically.  Using scores, we can set the reaction to each environment type:

0) Full control
1) Float
2) Sink
3) Limited control
4) Disable permanently
5) Explode

    

## Option 2: Use a bunch of flags

Add several tags that can be added to a vehicle to control how it reacts to various conditions:

* water_float
* air_float
* lava_float
* water_sink
* air_sink
* lava_sink
* limited_water_control
* limited_air_control
* limited_lava_control
* destroyed_by_water
* destroyed_by_air
* destroyed_by_lava

---

# Control system rework

There may be issues with extensibility in the future given the current control system.  Some examples:

* Having left/right keys control a plane's roll in order to turn it
* Having left/right keys control a boat or car's rotation

Things we'd like to handle:

* WASD directly controls direction of movement relative to camera
  * Both 2D and 3D motion

* WASD changes some aspect about direction of movement
  * Rotation for cars
  * Roll for planes

What if we added control types where the xyz input vector *didn't* represent a direction of motion.  For example

* To handle planes, let x=forward/reverse thrust, y=roll left, z=roll right

---

# Visuals

It'd be nice to have a proper system for handling visual stuff, like particles, animations, multipart models, and vehicle rotation.

Possible ways a vehicle might rotate:

* Points in direction player is looking (2D)
* Points in direction player is looking (3D)
* Points in direction of acceleration (2D & 3D)
* Points in direction of velocity (2D & 3D)
* Additionally leans in direction of movement (i.e. helicopter)
* Rolls left/right (i.e. planes)

In the most abstract way possible, the model's transformation(s) can be inferred from the vehicle's state:

* Velocity
* Acceleration
* Control vector
* Passenger rotation

As well as additional information that remains state-independent (constant):

* Full 3D motion or confined to 2D?

---

# Vehicles in their most abstract form

To address the problem of converting state into motion and visuals, let's step back and think about things abstractly.

Vehicles vary wildly in their method of producing motion, as well as the physics regime they're designed for.  This gives rise to a wide range of control surfaces and handling depending on the application.  In the real world:

* A VEHICLE is subject to FORCES in physics
* A VEHICLE is designed with CONTROL SURFACES based on the physics regime and FORCES it is subject to
* The USER provides input that modify CONTROL SURFACES
* CONTROL SURFACES change a VEHICLE'S response to FORCES
* FORCES change the VEHICLE's MOTION

However, in a digital world lacking such a detailed physics engine, there is no need for control surfaces—the only force the vehicle is subject to is its programming.  Without the time or resources to replicate reality, we must instead resort to simulation and mimicry.

All that said, we can still take lessons from the real-world operation to inform digital implementation—such as using physics to approximate various, well-defined scenarios.  In the realm of algorithms and idealized states, the problem can be broken down into:

* Gathering user INPUT into the INPUT STATE
* Translating INPUT STATE to changes in MOTION STATE
  * Informed using a PHYSICS approximation
* Translating INPUT STATE and MOTION STATE into VISUAL STATE
  * Changes chosen to mirror the conditions for the PHYSICS approximation

The crux lies in the relationship between the PHYSICS approximation and the INPUT, MOTION, and VISUALS.  How do you handle as many approximations as possible?  For example:

* A car is confined to movement within a plane (cannot go up or down).  It can turn, go forward, and reverse.  In the real world, the control surfaces are the wheels, which determine speed and direction.
* A helicopter is capable of full 3D motion.  It's control surfaces are the two rotors (primary and tail), which determine rotation and velocity.  They must lean in the direction of travel due to the forces they're designed around.
* A jet can go only go forward.  Changes direction of motion are handled via pitching up/down and rolling left/right.  Changes in speed are handled via adjusting forward thrust.

One possible method is to design a system that's as modular as possible, so a vehicle's parameters can be ADJUSTED to emulate it's real-world counterpart—at least enough for suspension of disbelief.

What are the set of parameters that describe a vehicle's motion?

* Position (x, y, z)
* Rotation (yaw, pitch, roll)
* Velocity (change in x, y, z, yaw, pitch, roll)
* Acceleration (change in velocity)

To start, let's try to think of all useful methods of input:

* Player look vector (3D)
* Player look vector (2D, just yaw)
* Player Motion tag
* WASD key states
  * Strafe left/right
  * Move forward/backward

Next, all useful things that said input could modify:

* Acceleration vector
* Acceleration forward
* Change in yaw
* Change in roll
* Change in pitch

Several useful physics regimes that could be applied:

* Plane w/ lift 
* Accelerate in direction (XZ-confined 2D and full 3D)

# Towards a General Premise for the Rewrite

Imagine two rows of boxes: 
* On the left, all possible inputs
* On the right, all possible things those inputs could be used for

|             Input            |   |               Action              |
| ---------------------------- | - | --------------------------------- |
| Player look vector (x, y, z) |   | Set acceleration vector (x, y, z) |
| Player yaw                   |   | Accelerate forward                |
| Player pitch                 |   | Delta yaw                         |
| Player motion (x, z)         |   | Delta pitch                       |
| Move forward                 |   | Delta roll                        |
| Move backward                |   | Set yaw                           |
| Move left                    |   | Set pitch                         |
| Move right                   |   | Set roll                          |

We might be able to generalize the actions slightly:

| Operations | Variables  |
| ---------- | ---------- |
| Add        | x-velocity |
| Remove     | y-velocity |
| Set        | z-velocity |
|            | yaw        |
|            | pitch      |
|            | roll       |

So, for each vehicle we can define a set of "controls" that are defined by FOUR parameters:

|       Input         |    Scale    |  Operation  |  Affected Variable |
| ------------------- | ----------- | ----------- | ------------------ |
| Player look (x)     | Some number | Increase    | x-velocity         |
| Player look (y)     |             | Decrease    | y-velocity         |
| Player look (z)     |             | Set         | z-velocity         |
| Player motion (x)   |             |             | yaw ↔️              |
| Player motion (z)   |             |             | pitch ↕️            |
| Directed motion (x) |             |             | roll ↺             |
| Directed motion (y) |             |             |                    |
| Directed motion (z) |             |             |                    |

* Note: "directed motion" refers to the vector generated when assuming the motion tag is relative to the player's camera.  This would be used for vehicles like submarines and helicopters.

Possible limitations:
* Handling left/right-click interactions (this might have to be handled in a special way anyways)
* Implementation using a global lookup table requires constant work per entity (might not be *too* terrible so long as there aren't a ton of vehicle entities)
* Using selected hotbar slot as an input is incompatible with this regime as-is (if that's something we want compatibility for)

Way may be able to cover the above using more inputs, operations, and affected variables:

|       Input         |    Scale    |  Operation  |  Affected Variable |
| ------------------- | ----------- | ----------- | ------------------ |
| Left-clicked        |             | Toggle      | Engine status      |
| Right-clicked       |             | 

Additionally, we can implement a "scale source" to have a dynamic scaling factor:
* Hotbar slot
* Constant
* Vehicle scoreboard
* Another input


# Physics Forces


As mentioned previously, vehicles are subject to varying types of forces based on their design.  Since Minecraft doesn't have a concept of mass—instead performing calculations directly on velocity—we'll use Netwon's second law to separate out the mass and acceleration:
$$
F_{net} = ma \rightarrow a = \frac{F_{net}}{m}
$$

Since Minecraft has no concept of mass, we distribute the mass amongst the individual forces as a constant:
$$
\underbrace{\vec{F}_{net} = \sum_i \vec{F}_i \ \ \ \ \ \ \ \ \ \ \ \vec{a} = \frac{\vec{F}_{net}}{m}}
\\
\vec{a} = \sum_i \frac{1}{m}\vec{F}_i
$$

Below are various forces we may wish to include.  All related force equations will be presented as solved for acceleration.


## Aerodynamics

It should be noted that the lift and drag equations shown above are not entirely practical for our purposes.  This is due to the effect of angle-of-attack being swept into $C_l$.  As a result, we cannot currently describe what happens when you point a plane in a direction other than the velocity.  For that, we'll need a better model.

The effect of drag is easier to handle, since it merely relies on cross-sectional area orthogonal to velocity:
$$
a_D = \frac{1}{m}C_D\left(\frac{1}{2}\rho v^2\right)A
$$

Therefore, if we come up with a simplistic aircraft profile, we'll be able to describe cross-sectional area.

Lift, however, requires something more complicated.  Therefore, it's time to bust out the surface integrals:
$$
D_p = \oint p \hat{\bold{n}} \cdot \hat{\bold{i}}\ dS_i
\\
Y = \oint p \hat{\bold{n}} \cdot \hat{\bold{j}}\ dS_j
\\
L = \oint p \hat{\bold{n}} \cdot \hat{\bold{k}}\ dS_k
$$
See: [Lift (force) - Wikipedia](https://en.wikipedia.org/wiki/Lift_(force))

Where:
* $D_p$ = Pressure drag
* $Y$ = Side force
* $L$ = Lift force
* $p$ = Pressure at point on wing
* $\hat{\bold{n}}$ = Normal unit vector pointing into the wing
* $\hat{\bold{i}}$ = Unit vector parallel to the air stream
* $\hat{\bold{j}}$ = Spanwise unit vector normal to the air stream
* $\hat{\bold{k}}$ = Normal vector to the air stream
* $S_i$, $S_j$, $S_k$ = Projected area of the craft normal to $\hat{\bold{i}}$, $\hat{\bold{j}}$, and $\hat{\bold{k}}$ respectively.

Note that we can use the third integral to reproduce the equation for $F_D$.  Since $A$ is the area wing area orthogonal to $\hat{\bold{k}}$:
$$
A = \oint \hat{\bold{n}} \cdot \hat{\bold{k}}\ dS_k
$$



Therefore, the total aerodynamic force is:
$$
\vec{F}_{net} = D_p\hat{\bold{i}} + Y\hat{\bold{j}} + L\hat{\bold{k}}
\\
\vec{F}_{net} = \oint p [(\hat{\bold{n}} \cdot \hat{\bold{i}})\hat{\bold{i}}+(\hat{\bold{n}} \cdot \hat{\bold{j}})\hat{\bold{j}}+(\hat{\bold{n}} \cdot \hat{\bold{k}})\hat{\bold{k}}]\ dS
\\
\vec{F}_{net} = \oint p \hat{\bold{n}}\ dS
$$
Where:
* $\vec{F}_{net}$ = Total pressure force
* $p$ = Pressure at a point on the wing
* $\hat{\bold{n}}$ = Normal unit vector pointing into the wing
* $dS$ = Infinitesimal surface area at a point on the wing

This actually makes a lot of sense, since $Force = Pressure \times Area$.  However... now we need a pressure profile...

For this, we can use Bernoulli's principle:
$$
p + \frac{1}{2} \rho {v}^2 + \rho g h = \underbrace{constant}_{Along\ a\ streamline}
$$
Where:
* $p$ = Pressure at elevation
* $v$ = Velocity at elevation
* $h$ = Height at elevation
* $g$ = Acceleration due to gravity
* $\rho$ = Density of medium (air, for our purposes)

Solving for $p$:
$$
p = c - \frac{1}{2} \rho {v}^2 - \rho g h
$$

Now, let's assume the affect of $\rho g h$ is much smaller than $\frac{1}{2} \rho {v}^2$ or $p$:
$$
p \approx c - \frac{1}{2} \rho {v}^2
$$

Substituting:
$$
\vec{F}_{net} = \oint [c - \frac{1}{2} \rho {v}^2] \hat{\bold{n}}\ dS
$$


$$
F_D = C_D\left(\frac{1}{2}\rho v^2\right)A
$$


Perhaps we can make the assumption that... uh...



You know, it might've been simpler to assume a force from the thrust, and just orient the aircraft in a believable direction relative to the velocity.  So:
* Adjust yaw/pitch to point plane in direction of velocity
* Adjust roll such that...


You know, maybe I'll come back to this one...


## Lift Force

Lift occurs due to a pressure difference between the top and bottom of a wing.  It is described by:
$$
a_L = \frac{1}{m}C_l\left(\frac{1}{2}\rho v^2\right)A
$$

Where:
* $a_L$ = Acceleration due to lift force
* $C_l$ = Coefficient of lift
* $A$ = Wing area
* $\rho$ = Air density
* $v$ = Forward velocity relative to air
* $m$ = Mass constant

For the sake of simplicity, we collect various constants together:
$$
\boxed{a_L = b_l v^2}
$$

Where:
$$
b_l = \frac{1}{m}C_l A\left(\frac{1}{2}\rho\right) 
$$


Of potential use: the minimum for takeoff is given by:
$$
g = b_l v_{liftoff}^2 \rightarrow \boxed{v_{liftoff} = \sqrt{\frac{g}{b_l}}}
$$

Where:
* $g$ = Acceleration due to gravity


## Quadratic Drag Force

Drag occurs due to collisions between the surrounding air and a vehicle.  For the velocity regime planes are subject to, it is described by:
$$
a_D = -\frac{1}{m}C_D\left(\frac{1}{2}\rho v^2\right)A
$$

Where:
* $a_D$ = Acceleration due to drag
* $C_D$ = Coefficient of drag
* $A$ = Cross sectional area perpendicular to direction of travel
* $\rho$ = Air density
* $v$ = Velocity relative to air
* $m$ = Mass constant

For the sake of simplicity, we collect various constants together.  Additionally, the sign of the acceleration is added in to oppose the velocity:
$$
\boxed{a_D = -b_Dv^2\text{sign}(v)}
$$

Where:
$$
b_D = \frac{1}{m}C_D A\left(\frac{1}{2}\rho\right)
$$


Be warned, however, as second-order air resistance will obliterate your simulation if handled poorly.  To demonstrate why, let's use Euler's method to simulate the above:
$$
a \approx \frac{\Delta v}{\Delta t} \rightarrow \Delta v \approx -bv^2 \text{sign}(v) \Delta t \\
v_{n+1} = v_n + \Delta v
$$

For simplicity, we'll collect $b$ and $\Delta t$ into a single constant, $c$:
$$
v_{n+1} = v_n - cv_n^2\text{sign}(v_n)
$$

Imagine we have a velocity large enough that the above equation overshoots the drag, causing velocity to reverse direction (i.e. flip its sign).  Note that $v_n$ and $-\text{sign}(v_n)$ ALWAYS have opposite signs, so the two right-side terms in the above equations always have opposite signs.  Therefore, in order to force $v$ to flip sign, we only need:
$$
|v_n| < |-cv_n^2\text{sign}(v_n)| = |cv_n^2| = cv_n^2 \\
\cancel{|v_n|} < c|v_n|^{\cancel{2}} \\
|v_n| > \frac{1}{c}
$$

So, in order to break quadratic drag when using Euler's method, we only need a sufficiently large speed:
$$
|v_n| > \frac{1}{c}
$$

Additionally, though it's not worth prolonging this derivation here, something *very special* happens when:
$$
|v_n| \geq \frac{2}{c}
$$

Hint: it starts oscillating, then blowing up.  Derivation is left as an exercise for the reader.

An alternative to using Euler's method like above comes from integrating the governing equation:
$$
\frac{dv}{dt} = -b_Dv^2 \\
\int_{v_i}^{v_f} \frac{1}{v^2} dv = \int_{t_i}^{t_f} -b_D dt \\
-\left[\frac{1}{v_f} - \frac{1}{v_i}\right] = -b_D (t_f - t_i) = -b_D \Delta t \\
\frac{1}{v_f} - \frac{1}{v_i} = b_D \Delta t \\
\frac{1}{v_f} = b_D \Delta t+\frac{1}{v_i} \\
v_f = \frac{1}{b_D \Delta t+\frac{1}{v_i}} \\
v_f = \frac{v_i}{1 + b_D v_i \Delta t}
$$

Here, we set $\Delta t=1$ (1 unitless timestep):
$$
v_f = \frac{v_i}{1 + b_D v_i}
$$

Switching to index notation for comparison with the previous derivation for Euler's method:
$$
v_{n+1} = \frac{v_n}{1 + c v_n}
$$

Unfortunately, this method falls apart completely when $v_n < 0$:
* Undefined when $v_n=-\frac{1}{c}$, since $\frac{v_n}{1 + c v_n}=\frac{-\frac{1}{c}}{1 -\frac{c}{c}} = \frac{-\frac{1}{c}}{0}$
* Denominator causes a sign flip when negative, or equivalently: $1+cv_n < 0 \rightarrow v_n < -\frac{1}{c}$
* $|v_{n+1}| > |v_{n}|$ when $-1 < 1 + c v_n < 1 \rightarrow -\frac{2}{c} < v_n < 0$

To compensate for this, consider taking the absolute value to separate the sign from the magnitude
$$
\begin{matrix}
|v_{n+1}| = \frac{|v_n|}{1 + c |v_n|} \\
|v_{n+1}| \text{sign}(v_n) = \frac{|v_n|}{1 + c |v_n|} \text{sign}(v_n) \\
|v_{n+1}| \text{sign}(v_{n+1}) = \frac{|v_n|\text{sign}(v_n)}{1 + c |v_n|}  & \text{sign}(v_{n+1})=\text{sign}(v_n) \\
v_{n+1} = \frac{v_n}{1 + c |v_n|}
\end{matrix}
$$

Using $|v_n|$ in the denominator resolves all three points from above and gives us a numerically stable method for simulating quadratic drag.  Converting back into the $v_f$/$v_i$ notation seen above:
$$
\boxed{v_f = \frac{v_i}{1 + b_D |v_i|}}
$$

Interestingly enough, if there are no other forces involved, the above is an *exact solution*.


## Linear Drag Force

Minecraft already applies its own first-order drag force.  This is applied by multiplying the horizontal and vertical velocity components by a constant factor each tick:
$$
\vec{v}_{h, \ after} = (1-k_h)\vec{v}_{h, \ before} \\
\vec{v}_{v, \ after} = (1-k_v)\vec{v}_{v, \ before}
$$

Where:
* $\vec{v}_h$ = Horizontal component of velocity vector
* $\vec{v}_v$ = Vertical component of velocity vector
* $\vec{v}_{before}$ = Velocity before drag
* $\vec{v}_{after}$ = Velocity after drag
* $k_h$ = Horizontal drag coefficient.  For players and other living entities this is 0.09 in air and 0.454 on the ground (for most blocks)
* $k_v$ = Vertical drag coefficient.  0.019999980926513672 for players and other living entities

For players and living entities, drag is applied AFTER acceleration due to gravity while in air.  When in water and lava, it is applied BEFORE.

For players and other living entities, the base value of $(1-k_h)$ is 0.91.  However, when on the ground, this factor is multiplied by ground's slipperiness:
$$
1-k_h = 0.91 \times slipperiness
$$

The slipperiness value for various blocks:
|   Block    | Slipperiness  | Overall $1-k_h$ |
| ---------- | ------------- | --------------- |
| Default    | 0.6           | 0.546           |
| Slime      | 0.8           | 0.728           |
| Ice        | 0.98          | 0.8918          |
| Packed Ice | 0.98          | 0.8918          |
| Blue Ice   | 0.989         | 0.89999         |

In fluids like water and lava, slipperiness does not apply.  Additionally, the values of $k_h$ and $k_v$ are different:
|       |      In water     | In Lava  |
| ----- | ----------------- | -------- |
| $k_h$ | 0.8               | 0.5      |
| $k_v$ | 0.800000011920929 | 0.5      |


## Gravity

Gravity, in this case, is modelled by a constant downwards acceleration.  Unlike other forces here, it's effect is automatically calculated and applied by the game.  Nevertheless, it is described by:
$$
\boxed{a_g = g}
$$

Where:
* $a_g$ = Downwards acceleration
* $g$ = Acceleration due to gravity

For players and living entities, the default acceleration due to gravity is $0.08\ blocks/tick^2$.  However, we can modify this value using an entity's gravity attribute.

When combined with Minecraft's existing drag force, the overall built-in equation of motion (vertical and horizontal) is:
$$
v_{y,f} = (v_{y,i} - g)(1-k_y) \\
\vec{v}_{h,f} = \vec{v}_{h,i}(1-k_h)
$$

Where:
* $v_f$ = Velocity (x, y, or z) at the end of the tick
* $v_i$ = Velocity (x, y, or z) at the start of the tick
* $g$ = Acceleration due to gravity ($0.08\ blocks/tick^2$ by default)
* $k_y$ = Vertical drag ($0.02$ by default)
* $k_h$ = Horizontal drag ($0.02$ in air, $0.454$ on land)

Should we wish to counteract the affects of drag:
$$
v_{y}' = \frac{v_y-g}{1-k_y}+g = \frac{v_{y} - k_y g}{1-k_y} \\
\vec{v}_{h}' = \frac{\vec{v}_{h}}{1-k_h}
$$

Additionally, the vertical terminal velocity is given by:
$$
\begin{matrix}
\text{Drag before gravity:} & \ \ \ \ \ \ \ & \text{Drag after gravity:} \\
v_{term} = -\frac{g}{k_v} & & v_{term} = -\frac{g(1-k_v)}{k_v}
\end{matrix}
$$

In water and lava, an entity's effective gravity is reduced to $1/4$ of its ordinary value.



## Buoyant Force

Buoyancy occurs due to a pressure difference between the top and bottom.  It is described by:
$$
a_b = \frac{1}{m}\rho_{med} g V
$$

Where:
* $a_b$ = Acceleration due to buoyancy
* $\rho_{med}$ = Density of the surrounding medium (in this case, water)
* $V$ = Volume of water displaces by the object
* $g$ = Acceleration due to gravity

However, we can rewrite this into easier variables to work with.  First, let's write $V$ as some fraction of the object's total volume:
$$
V = fV_{obj}
$$
Where:
* $V_{obj}$ = Total volume of object
* $f$ = Some fraction between 0 and 1

Substituting and rearranging:
$$
a_b = \frac{V_{obj}}{m_{obj}}f\rho_{med} g
$$

Additionally, since density is mass divided by volume:
$$
\rho_{obj} = \frac{m_{obj}}{V_{obj}}
$$

Using this, we can rewrite $a_b$ in terms of a density ratio:
$$
a_b = \frac{\rho_{med}}{\rho_{obj}} f g
$$

Where:
* $a_b$ = Acceleration due to buoyancy
* $\rho_{med}$ = Density of the surrounding medium (in this case, water)
* $\rho_{obj}$ = Density of the submerged object
* $f$ = Fraction of the object's volume that's submerged
* $g$ = Acceleration due to gravity

For the sake of simplicity, we'll collect a few constants together:
$$
\boxed{a_b = b_b f g}
$$

Where:
$$
b_b = \frac{\rho_{med}}{\rho_{obj}}
$$


Now, $f$ is not exactly trivial to calculate within Minecraft.  However, we can approximate it under certain known conditions:
* If the vehicle is fully outside something it can float in (like water), then $f=0$
* If the vehicle is fully submerged in something it can float in, then $f=1$
* If the vehicle is floating on top of a medium, then we can simply set $a_b$ to counteract gravity, and not care about the value of $f$


It should be noted that, if we choose $b_b = 1$:
$$
a_b = f g
$$

Then we get an acceleration that perfectly counteracts gravity when the vehicle is fully submerged.  This can be used to create submarines that can move freely underwater, but experience gravity when above water.



## Applied Force

Applied force is simply a force exerted by the vehicle in some direction.  Some real-world examples of vehicles generating a force include:
* Ejecting spent propellent from a rocket
* Propellers on a submarine pushing against water
* Propellers on a plane pushing against air
* Wheels on a car pushing it forward

In game, however, we generalize this under a single "applied force" term.  There are two major schemes for how player input translates into a force:
1) Force in direction player is looking
2) Force in direction vehicle is pointing

The first scheme is easily handled by input-handling system we've developed thus far.  The second... not so much.  For that, we add a scoreboard, `vehicle.accel.forward`, that is automatically handled by the physics system as an acceleration in the direction the vehicle is pointing.



# Data Structure Implementation

Here we define several data structures required for our implementation.  These data structures include:
* The user input NBT tag - used as a central place to put all information needed for the vehicle
* The vehicle definition NBT tag - used to fully define a vehicle and its behavior

## User Input Data Structure

These fields serve as inputs for vehicle actions/responses.  These are rebuilt from scratch every tick a player is riding a vehicle, and cannot be relied upon outside a single vehicle's functions.  Additionally, all fields in this structure are ONLY gathered if requested by the vehicle.
```yaml
{
  look: {
    x: float,   # x-component of player look vector
    y: float,   # y-component of player look vector
    z: float    # z-component of player look vector
  },
  look_xz: {
    x: float,   # x-component of normalized 2D look vector
    z: float    # z-component of normalized 2D look vector
  },
  motion: {
    x: float,   # x-component of player motion tag.  Responds to WASD while player is mounted
    z: float    # z-component of player motion tag
  },
  directed: {
    x: float,   # x-component of player directed motion vector.  Like motion, but accounts for camera direction
    y: float,   # y-component of player directed motion vector
    z: float    # z-component of player directed motion vector
  },
  rotation: {
    pitch: float, # Player's pitch
    yaw: float    # Player's yaw
  },
  rotation_diff: {
    pitch: float, # Difference between player and vehicle pitch
    yaw: float    # Difference between player and vehicle yaw
  },
  heading_diff: {
    pitch: float, # Difference in player's pitch and the pitch of the vehicle's velocity vector
    yaw: float    # Difference in player's yaw and the yaw of the vehicle's velocity vector
  },
  click: {
    right: bool,  # Whether the passenger just right-clicked
    left: bool,   # Whether the passenger just left-clicked
  },
  input: {
    forward: int, # Whether the player is moving forward/backward in the camera direction; 1=forward, -1=backward.
    side: int,    # Whether the player is moving left/right in the camera direction; 1=left, -1=right.
    up: int       # Whether the player is moving up in the camera direction; 1=up
  }
}
```

Inputs are gathered as a group, that is: requesting `look.x` will also gather `look.y` and `look.z`.  Additionally, certain groups will automatically cause other groups to be gathered as well to prevent regathering the same information:

|     Group     |   Dependencies  |
| ------------- | --------------- |
| look          |        -        |
| look_xz       |        -        |
| motion        | input           |
| directed      | input           |
| rotation      |        -        |
| rotation_diff |        -        |
| click         |        -        |
| input         |        -        |
| heading_diff  |        -        |


## Vehicle Scoreboards

All vehicles will have common set of scoreboard values (stored by the root vehicle entity) that contain pertinent information about their state/motion.  These include:

|             Name             |         Format         |                    Description                           |
| ---------------------------- | ---------------------- | -------------------------------------------------------- |
| vehicle.rot.yaw              | x10000 fixed-precision | Yaw (↔️)                                                  |
| vehicle.rot.pitch            | x10000 fixed-precision | Pitch (↕️)                                                |
| vehicle.rot.roll             | x10000 fixed-precision | Roll (↺)                                                 |
| vehicle.dvel.x               | x1000 fixed-precision  | Amount to change x-velocity by                           |
| vehicle.dvel.y               | x1000 fixed-precision  | Amount to change y-velocity by                           |
| vehicle.dvel.z               | x1000 fixed-precision  | Amount to change z-velocity by                           |
| vehicle.engine               | boolean 0 or 1         | Engine state                                             |
| vehicle.version              | integer                | Datapack version number vehicle was summoned with        |
| vehicle.accel.forward        | x1000 fixed-precision  | Amount to change velocity in the vehicle's direction     |
| vehicle.thrust               | x1000 fixed-precision  | Used in physics calculations to determine vehicle thrust |
| vehicle.event.firework       | boolean 0 or 1         | Summon a firework once                                   |
| vehicle.event.honk           | boolean 0 or 1         | Honk the horn                                            |
| vehicle.event.shoot          | boolean 0 or 1         | Fire a projectile                                        |
| vehicle.button.kill_throttle | boolean 0 or 1         | Dummy variables for user's discretion                    |


## Vehicle Definition Data Structure

This data structure fully defines a vehicle.  Each vehicle definition is added to the master vehicle table upon reload.
```yaml
{
  name: str,        # Name of vehicle (required)
  author: str,      # Vehicle creator (required)
  collection: str,  # Vehicle collection (required)
  handling: [       # A list of tags that define how the vehicle's variables react to user input (optional)
    {
      input: "look.x",        # Path to the input value in the user input NBT tag
      operation: "increase",  # Operation to apply to vehicle variable.  May be "increase", "decrease", "set", "toggle", "clamped_increase", or "clamped_decrease"
      scale: {                # Information regarding how the input value is scaled.  Defaults to a scale of source "none" if absent
        source: str,          # Where to obtain the scale factor from.  May be "constant", "score", or "none"
        value: float,         # Amount to scale the input value by when source is "constant"
        name: str,            # Name of the score to obtain when source is "score"
        score_scale: float    # Multiplied against scoreboard value when source is "score"
      },
      predicates: [],         # A list of string predicates that determine when this handling tag is applied
      variable: "vehicle.dvel.x", # Name of the affected score
      precision: 100          # Multiplier used to treat variable as a fixed-point decimal (default based on variable)
    }
  ],
  physics: [  # A collection of tags that define what physics forces the vehicle is subject to (optional)
    {                   # Gravity component is handled specially, and does not accept predicates
      type: "gravity",  # Base acceleration due to gravity.  This is handled specially using attributes
      value: float      # Defaults to 0.08 if this tag is not present
    },
    {
      type: "buoyant",                        # Vehicle is subject to buoyancy
      predicates: [                           # List of predicates required for this force to apply (optional)
        "reds_vehicles:environment/in_water"
      ],
      value: float                            # Ratio between medium and vehicle densities
    },
    {
      type: "simple_lift",                    # Vehicle experiences lift proportional to velocity squared
      predicates: [                           # List of predicates required for this force to apply (optional)
        "reds_vehicles:environment/in_air"
      ],
      value: float                            # Lift constant
    },
    {
      type: "planar_drag",                    # Vehicle experiences |v|² drag in its relative horizontal plane
      predicates: [                           # List of predicates required for this force to apply (optional)
        "reds_vehicles:environment/in_air"
      ],
      value: float                            # Drag constant
    },
    {
      type: "applied",                        # Vehicle responds applied force scores
      predicates: [                           # List of predicates required for this force to apply (optional)
        "reds_vehicles:state/engine_on"
      ],
      value: float,                           # Amount to scale applied force by.  Defaults to 1.0
      reset: bool                             # Whether to reset the driving scores
    },
    {
      type: "side_linear_drag",               # Applies a linear drag force transverse to vehicle direction
      predicates: [                           # List of predicates required for this force to apply (optional)
        "reds_vehicles:environment/on_land"
      ],
      value: float                            # Coefficient of drag
    },
    {
      type: "elytra_glide",                   # Vehicle base entity acts like it's wearing an elytra
      predicates: [                           # List of predicates required for this force to apply (optional)
        "reds_vehicles:environment/in_air"
      ]
    },
    {
      type: "uniform_quadratic_drag",         # Applies a uniform quadratic drag force
      predicates: [                           # List of predicates required for this force to apply (optional)
        "reds_vehicles:is_moving"
      ],
      value: float                            # Coefficient of drag
    }
  ],
  events: [                     # A list of events that trigger special behavior
    {
      trigger: str,             # Scoreboard used to trigger this event (optional)
      predicates: [],           # A list of predicates required for this event to trigger (optional)
      actions: [                # List of actions to take when this event is triggered
        {
          action: "playsound",  # Plays a sound
          arguments: {
            sound: str,         # Name of sound to play (required)
            pitch: float,       # Pitch of sound (optional, defaults to 1.0)
            volume: float       # Volume of sound (optional, defaults to 1.0)
          }
        },
        {
          action: "particle",   # Show particles
          arguments: {
            name: str,          # Name of particle to show
            offset: float[3],   # Offset of particles relative to vehicle (defaults to [0.0, 0.0, 0.0])
            delta: float[3],    # Spread of particles (defaults to [0.0, 0.0, 0.0])
            count: int,         # Number of particles to show with invocation (defaults to 1)
            speed: float        # Speed of particle animation (default to 1.0)
          }
        },
        {
          action: "relative_particle",   # Show particles relative to a display entity
          arguments: {
            name: str,          # Name of particle to show
            relative_to: str,   # Name of display entity that we're relative to
            offset: float[3],   # Offset of particles relative to vehicle (defaults to [0.0, 0.0, 0.0])
            delta: float[3],    # Spread of particles (defaults to [0.0, 0.0, 0.0])
            count: int,         # Number of particles to show with invocation (defaults to 1)
            speed: float        # Speed of particle animation (default to 1.0)
          }
        },
        {
          action: "set_model",  # Modify a display entity's item model
          arguments: {
            name: str,          # Name of display entity(ies) to affect
            value: str          # Resource location of item model
          }
        },
        {
          action: "set_score",  # Set a score
          arguments: {
            name: str,          # Name of scoreboard
            value: int          # Value to set
          }
        },
        {
          action: "add_score",  # Add a value to a score
          arguments: {
            name: str,          # Name of scoreboard
            value: int          # Value to add
          }
        },
        {
          action: "subtract_score",  # Subtract a value from a score
          arguments: {
            name: str,          # Name of scoreboard
            value: int          # Value to subtract
          }
        },
        {
          action: "toggle_score", # Toggle a score between 0 and 1.  Any nonzero number is interpreted as 1.
          arguments: {
            name: str,            # Name of scoreboard
          }
        },
        {
          action: "projectile", # Fire a projectile
          arguments: {
            type: str,          # Type of projectile (arrow|missile|fireball|bullet)
            direction: str      # Direction to fire projectile in (forwards|down)
          }
        },
        {
          action: "effect_passenger", # Apply a potion effect to a passenger
          arguments: {
            name: str,          # Name of effect to apply (required)
            duration: int,      # Duration of potion effect (optional, defaults to 0)
            amplifier: int,     # Potion effect amplifier (optional, defaults to 0)
            hide_particles: bool, # Whether to show/hide particles (optional, defaults to false)
          }
        },
        {
          action: "modify_transform",  # Edit property of an existing transform
          arguments: {
            source: str,    # Name of score to grab value from
            scale: float,   # Scale applied to score
            precision: int, # Score's precision multiplier (auto-generated)
            name: str,      # Name of mounted display entity to target.  Mutually exclusive with "group"
            group: str,     # Tag used to target mounted display entities.  Mutually exclusive with "name"
            transform: str, # Name of transform to modify
            property: str   # Name of transformation parameter to modify
          }
        },
        {
          action: "set_transform",  # Sets a transform to an exact NBT value
          arguments: {
            name: str,      # Name of mounted display entity to target.  Mutually exclusive with "group"
            group: str,     # Tag used to target mounted display entities.  Mutually exclusive with "name"
            transform: str, # Name of transform to modify
            parameter: any  # NBT tag to set transformation to
          }
        },
        {
          action: "set_rotation_axis_angle",  # Sets a rotation given a static axis and dynamic angle
          arguments: {
            source: str,    # Name of score to grab value from
            scale: float,   # Scale applied to score
            precision: int, # Score's precision multiplier (auto-generated)
            name: str,      # Name of mounted display entity to target. Mutually exclusive with "group"
            group: str,     # Tag used to target mounted display entities. Mutually exclusive with "name"
            transform: str, # Name of transform to modify (left_rotation or right_rotation)
            axis: float[3], # Axis of rotation
          }
        },
        {
          action: "message",    # Displays a message in the passenger's actionbar
          arguments: {
            text: nbt           # The message, as NBT-formatted JSON text
          }
        },
      ]
    }
  ],
  parts: [    # A collection of tags describing the display entities that make up the visual model
    {
      scale: float[3],        # Model scale factors in the x, y, and z directions.  Overridden by transform.
      translation: float[3],  # Model translation in the x, y, and z directions.  Overridden by transform.
      transform: float[16],   # An array of floats representing the display's initial 4x4 transformation matrix
      item: str,              # Name of the item displayed by the entity (required)
      model: str,             # Item's custom model (optional)
      groups: str[],          # A list of strings indicating which groups this part will join
      name: str               # Name assigned to display entity.  Cannot contain spaces.  (required)
    }
  ],
  seat: {
    width: float,       # Width of seat entity (default=1.0)
    height: float       # Height of seat entity (default=1.0)
  },
  default_scores: [     # A list of key-value default scores applied to newly spawned vehicles (optional)
    {
      name: str,        # Name of scoreboard objective
      value: num,       # Value to set.  Non-integer types are allowed
      precision: int    # Precision factor to multiple "value" by
    }
  ],
  preview: str,         # Item model used for the spawn egg preview
  ground_offset: float, # The offset between the root entity's base and the seat (default=1.0)
  step_height: float,   # The maximum block height that a vehicle can climb
  min_version: int,     # The minimum datapack version required for this definition to be loaded (required)
  do_not_update: bool   # If true, the vehicle will NEVER be updated
}
```

To ensure consistency in vehicle definitions from one version to the next, this specification will be made *immutable* once ready: tags can never be removed, only added.  Existing tags *may* be marked as "deprecated," though they will be automatically translated into applicable replacement tags.

Several of these tags have an option to specify a predicate.  These allow certain effects/physics to apply only in certain environments.  The standard set of predicates that come with the datapack are:
|                 Name                       |                         Description                           |
| ------------------------------------------ | ------------------------------------------------------------- |
| reds_vehicles:environment/in_air           | Passes when the current fluid is air                          |
| reds_vehicles:environment/in_lava          | Passes when the current fluid is lava                         |
| reds_vehicles:environment/in_water         | Passes when the current fluid is water                        |
| reds_vehicles:environment/mid_air          | Passes when the current block is air AND when stepping on air |
| reds_vehicles:environment/on_dry_land      | Passes when standing on ground and current fluid is air       |
| reds_vehicles:environment/landed           | Passes when standing on ground                                |
| reds_vehicles:environment/on_lava_surface  | Passes when current fluid is air AND stepping on lava         |
| reds_vehicles:environment/on_water_surface | Passes when current fluid is air AND stepping on water        |
| reds_vehicles:state/engine_on              | Passes when the vehicle's `vehicle.engine` score is 1         |
| reds_vehicles:state/engine_off             | Passes when the vehicle's `vehicle.engine` score is 0         |
| reds_vehicles:has_passenger                | Passes when any player is a passenger in the vehicle          |
| reds_vehicles:is_moving                    | Passes when the vehicle is moving                             |
| reds_vehicles:has_applied_force            | Passes when any of the applied force variables are nonzero    |



## Automatic Vehicle Definition Components
  
To avoid re-evaluating conditions and tags that do not change each tick, the raw vehicle definitions are processed into their final form, with additional tags being added.  These automated tags operate on a lower level 

Automatic evaluation only occurs upon reload.

```yaml
{
  inputs: [       # List of inputs needed by the vehicle.  These are iterated over during the input-collection phase
    "rotation",       # Gather the rotation.pitch and rotation.yaw tags
    "motion",         # Gather the motion.x and motion.z tags
    "look",           # Gather the look.x, look.y, and look.z tags
    "directed",       # Gather the directed.x, directed.y, and directed.z tags
    "rotation_diff",  # Gather the rotation_diff.pitch and rotation_diff.yaw tags
    "click",          # Gather the click.left and click.right tags
    "input"           # Gather the input.forward and input.side tags
  ],
  physics: [
    {   # The predicates list is combined into a single statement compatible with /execute
      type: "buoyant",
      value: -1.0,       # The sign is inverted in order to invert the direction of the force
      uid: int,          # Randomly-generated integer used to differentiate two forces of the same type
      predicate: "if predicate reds_vehicles:environment/in_air if predicate reds_vehicles:state/engine_on "
    }
  ],
  entities: [      # A list of entities to summon that will be riding the root vehicle entity
    {
      type: "interaction",  # The interaction representing the vehicle hitbox.  Automatically added in
      hitbox: true,         # Whether this interaction is the hitbox
      tags: {
        width: float,       # Defaults to 1.0, or set to seat.width if provided
        height: float,      # Defaults to 1.0, or set to seat.width if provided
        response: 1b        # Hard-coded
      }
    },
    {
      type: "interaction",  # The interaction representing the pilot seat.  Automatically added in
      pilot: true,          # Whether this interaction is the primary cockpit
      tags: {
        width: 0.0f,        # Hard-coded
        height: 0.0f,       # Hard-coded
      }
    },
    {
      type: "item_display",   # One of the item display entities specified in "parts"
      transform: float[16],   # An array of floats representing the display's initial 4x4 transformation matrix\
      item: {
        id: str,              # ID of item displayed by the entity
        components: {}        # Map of item components applied to the item
      },
      extra_tags: str[],      # Identical to part's "groups" argument, but with "vehicle.group." prepended to every entry
      name: str               # Name assigned to display entity
    }
  ],
  events: [
    {  # The trigger and predicates list are combined into a single statement compatible with /execute
      predicate: "if predicate reds_vehicles:state/engine_on ",
      actions: [
        {
          action: "particle",
          arguments: {
            offsetU: float,  # Offset is converted from an array to tags due to function macro limitations
            offsetV: float,
            offsetW: float,
            deltaX: float,   # Delta is converted from an array to tags due to function macro limitations
            deltaY: float,
            deltaZ: float
          }
        }
      ]
    }
  ],
  scale: float,         # Base entity scale attribute
  base_gravity: float,  # Base gravity attribute for rapid lookup
  seat_count: int,      # Number of seats.  Currently unused but reserved for future use
}
```

Since this specification is only used internally, it is *not* subject to the immutability requirements laid out for the standard vehicle definition.  As such, these tags and their format are subject to change.



### Note on Entity Scaling

Currently, vehicles use a small armor stand for the base entity, as they obey motion physics and are sufficiently well-behaved.  A small armor stand has a height of 0.9875 blocks, but adjust its scale attribute to achieve any arbitrary height:
$$
Scale = \frac{Height}{0.9875} = Height \times \frac{80}{79}
$$

From testing, a bug occurs where the player's Motion tag will spontaneously zero in a particular direction.  This bug has only been observed for scale factors $\lesssim$ 0.6 (0.5925 blocks).  Fortunately, this only matters in versions $\leq$ 1.21.2 due to the predicate-based method.


## How Users Add New Vehicles



## Error Handling

The vehicle definition loader will have a built-in system for catching errors/mistakes in definitions.  Any vehicle that encounters an error upon load will be dropped from the final processed vehicle table to prevent unexpected behavior.  Additionally, a message will be announced to chat stating that errors occurred:
```
[Red's Vehicles]: N vehicles could not be loaded.  Use `/trigger vehicle.showlog` for more information
```

Clicking on the text `/trigger vehicle.showlog` will suggest the command in the player's chat.


### Internal Format

When an error occurs, an entry will be appended to the `reds_vehicles:definitions` storage under the `errors` tag.  Each entry has the following format:
```yaml
{
  vehicle: str,      # Name of the vehicle that was being loaded when error occurred
  description: str,  # Raw JSON string describing the error
  source: str        # Name of the function that detected the error
}
```


### Displaying errors

There are two means of displaying errors: one using `/trigger`, and one using `/function`.  The former announces only to the player who ran the command, while the latter announces globally and exists primarily for unit testing purposes.

The first method using `/trigger`:
```
/trigger vehicle.showlog
```

The second method using `/function`:
```
/function reds_vehicles:showlog
```

Error messages will have the following format:
```
---------------------------------------------
Function: "%s"
Vehicle: "%s"
Description: %s
Extra: [Hover]
```

The extra field is optional, and will not be printed if not present.  This field is used to display additional information that might be useful for debugging.

## Visuals and Animations

Here are examples of visuals we would like to handle:
* Vehicle model points in direction
* Plane rolls to compensate for changes in direction of travel
* Submarine propellers emit bubbles when craft is moving
* Rotating helicopter blades
* Helicopter leans in direction of travel
* Wheels on a car roll while moving
* Tank cannon matches player's direction, while body matches vehicle's direction
* Show a different item model if vehicle's engine is on/off

We can break this down in terms of:
1) What drives a visual?
2) What does the visual do?

For the former:
* Change in state (engine turning on/off, firing a projectile, etc.)
* Progression in time
* A dynamic variable after some computation
* A predicate that can either pass or fail

For the latter, here are all the actions we can take to create a visual:
* Show particle effects
* Set the display entity's rotation NBT
* Set the display entity's model transform
  * Translation
  * Left rotation
  * Right rotation
  * Scale
* Set the display entity's custom model data


So, we basically have multiple different types of visuals:
* Procedural animations - model transformations update based on some variables
* Keyframed animations - model transformations set to one of several static states based on some variable
* Model changes - change in the custom item model(s)
* Particle effects


Similar to the force system, we can assign our animations a predicate (or list of predicates) to control when they're applied.

### Keyframed Animations:

Keyframed animations consist of a list of model transformations that are applied to appropriate models.  The current model is chosen by converting some variable into an index

The proposed spec for this would be:
```yaml
{
  type: "keyframed", # This is a "keyframed" type animation
  source: str,       # Name of vehicle scoreboard to use as indexing variable
  divisor: int,      # Value that scoreboard is divided by.  This can be used to determine the frame duration
  frames: [          # A list of NBT compounds containing each frame's display transformation
    {left_rotation:{angle: 0.0000000000000000, axis: [0.0f, 1.0f, 0.0f]}},
    {left_rotation:{angle: 0.7853981633974483, axis: [0.0f, 1.0f, 0.0f]}},
    {left_rotation:{angle: 1.5707963267948966, axis: [0.0f, 1.0f, 0.0f]}},
    {left_rotation:{angle: 2.3561944901923450, axis: [0.0f, 1.0f, 0.0f]}},
    {left_rotation:{angle: 3.1415926535897939, axis: [0.0f, 1.0f, 0.0f]}},
    {left_rotation:{angle: 3.9269908169872414, axis: [0.0f, 1.0f, 0.0f]}},
    {left_rotation:{angle: 4.7123889803846900, axis: [0.0f, 1.0f, 0.0f]}},
    {left_rotation:{angle: 5.4977871437821380, axis: [0.0f, 1.0f, 0.0f]}}
  ],
  predicates: str[]  # List of all predicates that must be met for this animation to play.  Optional, defaults to []
}
```

Additional properties generated by the datapack:
```yaml
{
  length: int   # The frame count
}
```


### Particle Animations:

Particle animations are the simplest to implement, as they only require a handful of clear parameters:
* Particle name (str)
* Particle offset (double[3])
* Relative (^) or absolute (~) offset (bool)
* Spread (double[3])
* Speed (float)
* Count (int)
* Force visibility (bool)
* Predicates (str[])

Which, after some data processing, can be compiled into a single command string like so:
```mcfunction
particle $(name) $(fmt)$(dx) $(fmt)$(dy) $(fmt)$(dz) $(sx) $(sy) $(sz) $(speed) $(count) $(force_string)
```

So, the proposed spec for this would be:
```yaml
{
  type: "particle",  # This is a "particle" type animation
  name: str,         # Particle name string
  offset: double[3], # Particle offset 3-vector
  relative: bool,    # Whether to use relative (^) or absolute (~) coordinate offset.  Optional, defaults to 1b
  spread: double[3], # Particle spread 3-vector.  Optional, defaults to [0.0d, 0.0d, 0.0d]
  speed: float,      # Particle animation speed.  Optional, defaults to 1.0
  count: int,        # Particle count per tick.  Optional, defaults to 1
  force: bool,       # Whether to disable distance culling.  Optional, defaults to 0b
  predicates: str[]  # List of all predicates that must be met for this animation to play.  Optional, defaults to []
}
```

Which is processed into:
```yaml
{
  type: "particle",      # This is a "particle" type animation
  name: str,             # Particle name string
  offset: double[3],     # Particle offset 3-vector
  fmt: str,              # Either "^" or "~"
  spread: double[3],     # Particle spread 3-vector
  speed: float,          # Particle animation speed
  count: int,            # Particle count per tick
  force: str,           # Either "force" or ""
  predicate_string: str  # /execute-compatible string representing the full predicate
}
```

Which is substituted into a function using macros like so:
```mcfunction
execute $(predicate)run particle $(name) $(fmt)$(dx) $(fmt)$(dy) $(fmt)$(dz) $(sx) $(sy) $(sz) $(speed) $(count) $(force)
```

Unfortunately, pre-compiling the arguments into a full /particle command is not practical, since one layer of quotes are removed at each macro substitution, and some particle effects allow for quotes in their name.


### State Machines

Another option for handling animations is to use *state machines*.  Briefly, a state machine describes a discrete set of possible states a system might be in, as well as how one state leads into another.

We can have multiple of these state machines that all act at the same time

### Concept: Event-Triggered Animations

Certain animations only make sense to occur following some "event."  For example: helicopter blades start spinning after the engine turns on.  What if, instead of checking for a predicate every tick, me made the animation list itself *dynamic*?  That is, events can add or remove active animations?

This, of course, *would* require that every display entity in the vehicle have a data holder entity.  Additionally, it would require some sort of update mechanism to ensure vehicles stay in line with the global definitions.

Perhaps it would be better to implement some sort of event system first and come back to visuals later.

## Event System

The event system allows vehicles to react to certain conditions.  Event tags consist of the following attributes:
* Actions: a list of actions to perform when the event is triggered
* Trigger: a score that active for event to trigger
* Predicates: a list of predicates that must be met for an event to trigger

```yaml
{
  actions: [],   # An action to take
  trigger: str,  # Name of score used to trigger this event
  predicates: [] # Predicates that must be met for this event to trigger
}
```

Here, we have two different fields for specifying an event's conditions.  The first, `trigger`, checks that the specified score is *nonzero* for the vehicle.  This allows, for example, for custom scores outside the spec to trigger events without needing to add extra predicates.  The second, `predicates`, is a list of predicates to be met similar to the physics system.  Predicates allow for a more general set of conditions to be met, so long as the needed predicate has actually been implemented.

Several action types are possible, including:
* playsound: plays a sound
  * Sound (str)
  * Pitch (default 1.0)
  * Volume (default 1.0)
* particle: shows a particle at a location
  * Name (str)
  * Offset (float[3])
  * Delta (float[3])
  * Count (default 1)
  * Speed (default 1.0)
* set_model: sets the custom model data of one of the item displays
  * Display entity name (str)
  * New value (int)
* set_score:
  * Name of scoreboard (str)
  * Value (int)


## Returning to Visuals

With the addition of the events system, we can now tick off a few of the visuals I hoped to support:

* Vehicle model points in direction
* Plane rolls to compensate for changes in direction of travel
* ~~Submarine propellers emit bubbles when craft is moving~~
* Rotating helicopter blades
* Helicopter leans in direction of travel
* Wheels on a car roll while moving
* Tank cannon matches player's direction, while body matches vehicle's direction
* ~~Show a different item model if vehicle's engine is on/off~~

## How Display Transformations Work

Now, because the initial section on display entity transformation is outright wrong, we have a bit of work to do.  Display entities follow these order of operations:
1) Right rotation
2) Scale
3) Left rotation
4) Translation

Or, expressed using matrices:
$$
\bold{M} = \bold{T}\bold{R_L}\bold{S}\bold{R_R}
$$

Besides these transformations unique to the display entity, we also have the entity's yaw rotation, pitch rotation, and world position.  These are applied AFTER the above transformations:
$$
\vec{v} \ ' = \bold{T_{pos}}\bold{R_{yaw}}\bold{R_{pitch}}\bold{M}\vec{v}
\\
\boxed{\vec{v} \ ' = \bold{T_{pos}}\bold{R_{yaw}}\bold{R_{pitch}}\bold{T}\bold{R_L}\bold{S}\bold{R_R}\vec{v}}
$$


### A Vector in Homogeneous Coordinates:

In homogeneous coordinates, 3D vectors are given an extra fourth element that's always equal to one:
$$
\vec{v} = \left[\begin{matrix} x \\ y \\ z \\ 1 \end{matrix}\right]
$$

This allows transformations such as translation and perspective projection to be performed using matrix multiplication.


### Translations

The translation matrix exploits homogeneous coordinates to apply a constant offset to a vector.  It is given by:
$$
\bold{T} = \left[\begin{matrix}
1 & 0 & 0 & t_x \\
0 & 1 & 0 & t_y \\
0 & 0 & 1 & t_z \\
0 & 0 & 0 & 1
\end{matrix}\right]
$$


### Scaling

The scaling matrix is given by a simple diagonal matrix:
$$
\bold{S} = \left[\begin{matrix}
s_x & 0 & 0 & 0 \\
0 & s_y & 0 & 0 \\
0 & 0 & s_z & 0 \\
0 & 0 & 0 & 1
\end{matrix}\right]
$$


### Rotations

To determine what these $\bold{R_{yaw}}$ and $\bold{R_{pitch}}$ matrices should be in Minecraft's coordinate system, we reverse-engineer the matrices required to produce an entity's relative coordinate system.

From testing, the unit vector in the direction of ($\theta$, $\phi$) is given by:
$$
\hat{r}(\theta,\phi) = -\sin\theta \cos\phi \hat{x} - \sin\phi \hat{y} + \cos\theta \cos\phi \hat{z}
$$

An entity's relative coordinate system is given by:
$$
\hat{u} = \hat{r}(\theta,\phi)
\\
\hat{v} = \hat{r}(\theta,\phi-90^o)
\\
\hat{w} = \hat{r}(\theta-90^o,0)
$$

Where:
* $\hat{u}$ is forward relative to the camera
* $\hat{v}$ is vertical relative to the camera
* $\hat{w}$ is left relative to the camera

Expanding:
$$
\hat{u} = -\sin\theta \cos\phi \hat{x} - \sin\phi \hat{y} + \cos\theta \cos\phi \hat{z}
\\
\hat{v} = -\sin\theta \sin\phi \hat{x} + \cos\phi \hat{y} + \cos\theta \sin\phi \hat{z}
\\
\hat{w} = \cos\theta \hat{x} + \sin\theta \hat{z}
$$

For the special case of $\theta=\phi=0$ (i.e. not rotated, so $\bold{R_{yaw}}=\bold{R_{pitch}}=\bold{1}$):
$$
\hat{u}_0 = \hat{z} \\
\hat{v}_0 = \hat{y} \\
\hat{w}_0 = \hat{x}
$$

Therefore, if we write out the transformation matrix required to bring $[\hat{u}_0, \hat{v}_0, \hat{w}_0]$ to $[\hat{u}, \hat{v}, \hat{w}]$:
$$
\bold{R_{yaw}}\bold{R_{pitch}}
\left[\begin{matrix}
\uparrow & \uparrow & \uparrow \\
\hat{w}_0 & \hat{v}_0 & \hat{u}_0 \\
\downarrow & \downarrow & \downarrow
\end{matrix}\right]
=
\left[\begin{matrix}
\uparrow & \uparrow & \uparrow \\
\hat{w} & \hat{v} & \hat{u} \\
\downarrow & \downarrow & \downarrow
\end{matrix}\right]
$$
$$
\bold{R_{yaw}}\bold{R_{pitch}}
\left[\begin{matrix}
1 & 0 & 0 \\
0 & 1 & 0 \\
0 & 0 & 1
\end{matrix}\right]
=
\left[\begin{matrix}
\cos\theta & -\sin\theta \sin\phi & -\sin\theta \cos\phi \\
0 & \cos\phi & -\sin\phi \\
\sin\theta & \cos\theta \sin\phi & \cos\theta\cos\phi
\end{matrix}\right]
$$

Separating $\bold{R_{yaw}}(\theta)$ and $\bold{R_{pitch}}(\phi)$ is quite easy.  First, we try $\theta=0$, in which case $\bold{R_{yaw}} = \bold{1}$:
$$
\bold{R_{pitch}}
=
\left[\begin{matrix}
1 &        0 &         0 \\
0 & \cos\phi & -\sin\phi \\
0 & \sin\phi &  \cos\phi
\end{matrix}\right]
$$

Similarly, for $\phi=0$ and $\bold{R_{pitch}} = \bold{1}$:
$$
\bold{R_{yaw}}
=
\left[\begin{matrix}
\cos\theta & 0 & -\sin\theta \\
0 & 1 & 0 \\
\sin\theta & 0 & \cos\theta
\end{matrix}\right]
$$

Just to verify:
$$
\bold{R_{yaw}}\bold{R_{pitch}}=
\left[\begin{matrix}
\cos\theta & 0 & -\sin\theta \\
0 & 1 & 0 \\
\sin\theta & 0 & \cos\theta
\end{matrix}\right]
\left[\begin{matrix}
1 &        0 &         0 \\
0 & \cos\phi & -\sin\phi \\
0 & \sin\phi &  \cos\phi
\end{matrix}\right]
=
\left[\begin{matrix}
\cos\theta & -\sin\theta\sin\phi & -\sin\theta\cos\phi \\
0 & \cos\phi & -\sin\phi \\
\sin\theta & \cos\theta\sin\phi & \cos\theta\cos\phi
\end{matrix}\right]
\checkmark
$$

Upgrading to 4D homogeneous coordinates, the pitch and yaw matrices are:
$$
\boxed{
\bold{R_{yaw}}
=
\left[\begin{matrix}
\cos\theta & 0 & -\sin\theta & 0 \\
0 & 1 & 0 & 0 \\
\sin\theta & 0 & \cos\theta & 0 \\
0 & 0 & 0 & 1
\end{matrix}\right]
\ \ \ \ \ \ \ \ \ \ \ \ 
\bold{R_{pitch}}
=
\left[\begin{matrix}
1 &        0 &         0 & 0 \\
0 & \cos\phi & -\sin\phi & 0 \\
0 & \sin\phi &  \cos\phi & 0 \\
0 & 0 & 0 & 1
\end{matrix}\right]
}
$$

### Axis-Angle Rotation Matrix

Here, we derive the axis-angle rotation matrix, $\bold{R_{\vec{u}}}(\theta)$, in Minecraft's coordinate system.  First, we assert the special cases for 3D rotation matrices:
$$
\bold{R_x}(\theta) = \left[\begin{matrix}
1 &          0 &           0  \\
0 & \cos\theta & -\sin\theta \\
0 & \sin\theta &  \cos\theta
\end{matrix}\right]
 \ \ \ \ \ \
\bold{R_y}(\theta) = \left[\begin{matrix}
\cos\theta & 0 & -\sin\theta \\
0 & 1 & 0 \\
\sin\theta & 0 & \cos\theta
\end{matrix}\right]
 \ \ \ \ \ \
\bold{R_z}(\theta) = \left[\begin{matrix}
\cos\theta & -\sin\theta & 0 \\
\sin\theta & \cos\theta & 0 \\
0 & 0 & 1
\end{matrix}\right]
$$

The axis-angle rotation matrix that simplifies to the above cases is given by:
$$
\boxed{
\bold{R}_{\vec{u}}(\theta) = \left[\begin{matrix}
u_x^2 (1-\cos\theta) + \cos\theta & u_x u_y(1-\cos\theta) - u_z\sin\theta & u_x u_z (1-\cos\theta) - u_y\sin\theta \\
u_x u_y(1-\cos\theta) + u_z\sin\theta & u_y^2 (1-\cos\theta) + \cos\theta & u_y u_z (1-\cos\theta) - u_x\sin\theta \\
u_x u_z (1-\cos\theta) + u_y\sin\theta & u_y u_z (1-\cos\theta) + u_x\sin\theta & u_z^2 (1-\cos\theta) + \cos\theta
\end{matrix}\right]
}
$$

### Quaternion Rotation Matrix

Quaternions can be related to a physical rotation using:
$$
w + x\bold{i} + y\bold{j} + z\bold{k} = \cos\left(\frac{\theta}{2}\right) + (u_x\bold{i} + u_y\bold{j} + u_z\bold{k})\sin\left(\frac{\theta}{2}\right)
\\ \downarrow \\
\bold{q} = \cos\left(\frac{\theta}{2}\right) + \bold{u}\sin\left(\frac{\theta}{2}\right)
$$

Where $\bold{q}$ is a quaternion representing a rotation of $\theta$ about the axis $\vec{u}$.  Using this, we can convert the axis-angle rotation matrix into quaternion form:
$$
w = \cos\left(\frac{\theta}{2}\right)    \ \ \ \ \ \ \ 
x = u_x\sin\left(\frac{\theta}{2}\right) \ \ \ \ \ \ \ 
y = u_y\sin\left(\frac{\theta}{2}\right) \ \ \ \ \ \ \ 
z = u_z\sin\left(\frac{\theta}{2}\right)
\\ \downarrow \\
w = \cos\left(\frac{\theta}{2}\right)    \ \ \ \ \ \ \ 
u_x = \frac{x}{\sin\left(\frac{\theta}{2}\right)} \ \ \ \ \ \ \ 
u_y = \frac{y}{\sin\left(\frac{\theta}{2}\right)} \ \ \ \ \ \ \ 
u_z = \frac{z}{\sin\left(\frac{\theta}{2}\right)}
$$

Substituting:
$$
\bold{R}_{\bold{q}} = \left[\begin{matrix}
\frac{x^2}{\sin^2\left(\frac{\theta}{2}\right)} (1-\cos\theta) + \cos\theta & \frac{xy}{\sin^2\left(\frac{\theta}{2}\right)}(1-\cos\theta) - \frac{z}{\sin\left(\frac{\theta}{2}\right)}\sin\theta & \frac{xz}{\sin^2\left(\frac{\theta}{2}\right)} (1-\cos\theta) - \frac{y}{\sin\left(\frac{\theta}{2}\right)}\sin\theta \\
\frac{xy}{\sin^2\left(\frac{\theta}{2}\right)}(1-\cos\theta) + \frac{z}{\sin\left(\frac{\theta}{2}\right)}\sin\theta & \frac{y^2}{\sin^2\left(\frac{\theta}{2}\right)} (1-\cos\theta) + \cos\theta & \frac{yz}{\sin^2\left(\frac{\theta}{2}\right)} (1-\cos\theta) - \frac{x}{\sin\left(\frac{\theta}{2}\right)}\sin\theta \\
\frac{xz}{\sin^2\left(\frac{\theta}{2}\right)} (1-\cos\theta) + \frac{y}{\sin\left(\frac{\theta}{2}\right)}\sin\theta & \frac{yz}{\sin^2\left(\frac{\theta}{2}\right)} (1-\cos\theta) + \frac{x}{\sin\left(\frac{\theta}{2}\right)}\sin\theta & \frac{z^2}{\sin^2\left(\frac{\theta}{2}\right)} (1-\cos\theta) + \cos\theta
\end{matrix}\right]
$$
$$
 = \left[\begin{matrix}
\frac{2x^2}{1-\cos(\theta)} (1-\cos\theta) + \cos\theta & \frac{2xy}{1-\cos(\theta)}(1-\cos\theta) - \frac{z}{\sin\left(\frac{\theta}{2}\right)}\sin\theta & \frac{2xz}{1-\cos(\theta)} (1-\cos\theta) - \frac{y}{\sin\left(\frac{\theta}{2}\right)}\sin\theta \\
\frac{2xy}{1-\cos(\theta)}(1-\cos\theta) + \frac{z}{\sin\left(\frac{\theta}{2}\right)}\sin\theta & \frac{2y^2}{1-\cos(\theta)} (1-\cos\theta) + \cos\theta & \frac{2yz}{1-\cos(\theta)} (1-\cos\theta) - \frac{x}{\sin\left(\frac{\theta}{2}\right)}\sin\theta \\
\frac{2xz}{1-\cos(\theta)} (1-\cos\theta) + \frac{y}{\sin\left(\frac{\theta}{2}\right)}\sin\theta & \frac{2yz}{1-\cos(\theta)} (1-\cos\theta) + \frac{x}{\sin\left(\frac{\theta}{2}\right)}\sin\theta & \frac{2z^2}{1-\cos(\theta)} (1-\cos\theta) + \cos\theta
\end{matrix}\right]
$$
$$
 = \left[\begin{matrix}
2x^2 + (2\cos^2\left(\frac{\theta}{2}\right)-1) & 2xy - \frac{z}{\sin\left(\frac{\theta}{2}\right)}(2\sin\left(\frac{\theta}{2}\right)\cos\left(\frac{\theta}{2}\right)) & 2xz - \frac{y}{\sin\left(\frac{\theta}{2}\right)}(2\sin\left(\frac{\theta}{2}\right)\cos\left(\frac{\theta}{2}\right)) \\
2xy + \frac{z}{\sin\left(\frac{\theta}{2}\right)}(2\sin\left(\frac{\theta}{2}\right)\cos\left(\frac{\theta}{2}\right)) & 2y^2 + (2\cos^2\left(\frac{\theta}{2}\right)-1) & 2yz - \frac{x}{\sin\left(\frac{\theta}{2}\right)}(2\sin\left(\frac{\theta}{2}\right)\cos\left(\frac{\theta}{2}\right)) \\
2xz + \frac{y}{\sin\left(\frac{\theta}{2}\right)}(2\sin\left(\frac{\theta}{2}\right)\cos\left(\frac{\theta}{2}\right)) & 2yz + \frac{x}{\sin\left(\frac{\theta}{2}\right)}(2\sin\left(\frac{\theta}{2}\right)\cos\left(\frac{\theta}{2}\right)) & 2z^2 + (2\cos^2\left(\frac{\theta}{2}\right)-1)
\end{matrix}\right]
$$
$$
\boxed{\bold{R}_{\bold{q}} = \left[\begin{matrix}
2x^2 + 2w^2 - 1 & 2xy - 2zw & 2xz - 2yw \\
2xy + 2zw & 2y^2 + 2w^2 - 1 & 2yz - 2xw \\
2xz + 2yw & 2yz + 2xw & 2z^2 + 2w^2 - 1
\end{matrix}\right]}
$$

## Singular Value Decomposition

Display entities can have their transformation set to a full 4x4 matrix.  Upon doing so, the game will automatically factors this 4x4 matrix into individual translation, rotation, and scaling matrices:
$$
\bold{M} = \bold{T}\bold{R_L}\bold{S}\bold{R_R}
$$

To achieve this, the game first discards the first three entries in the bottom row as though they were set to zero:
$$
\left[\begin{matrix}
a_{11} & a_{12} & a_{13} & a_{14} \\
a_{21} & a_{22} & a_{23} & a_{24} \\
a_{31} & a_{32} & a_{33} & a_{34} \\
a_{41} & a_{42} & a_{43} & a_{44}
\end{matrix}\right]
\rightarrow
\left[\begin{matrix}
a_{11} & a_{12} & a_{13} & a_{14} \\
a_{21} & a_{22} & a_{23} & a_{24} \\
a_{31} & a_{32} & a_{33} & a_{34} \\
0 & 0 & 0 & a_{44}
\end{matrix}\right]
$$

Next, all entries in the matrix are divided by the value in the bottom-right corner:
$$
\left[\begin{matrix}
a_{11} & a_{12} & a_{13} & a_{14} \\
a_{21} & a_{22} & a_{23} & a_{24} \\
a_{31} & a_{32} & a_{33} & a_{34} \\
0 & 0 & 0 & a_{44}
\end{matrix}\right]
\rightarrow
\left[\begin{matrix}
a_{11}/a_{44} & a_{12}/a_{44} & a_{13}/a_{44} & a_{14}/a_{44} \\
a_{21}/a_{44} & a_{22}/a_{44} & a_{23}/a_{44} & a_{24}/a_{44} \\
a_{31}/a_{44} & a_{32}/a_{44} & a_{33}/a_{44} & a_{34}/a_{44} \\
0 & 0 & 0 & 1
\end{matrix}\right]
$$

This step is necessary to keep the matrix in *homogeneous coordinates*.  Next, the *translation* is factored out using the values in the right column.  This step is quite simple, since translation is the only factored transformation that actually affects this column:
$$
\left[\begin{matrix}
a_{11}/a_{44} & a_{12}/a_{44} & a_{13}/a_{44} & a_{14}/a_{44} \\
a_{21}/a_{44} & a_{22}/a_{44} & a_{23}/a_{44} & a_{24}/a_{44} \\
a_{31}/a_{44} & a_{32}/a_{44} & a_{33}/a_{44} & a_{34}/a_{44} \\
0 & 0 & 0 & 1
\end{matrix}\right]
\rightarrow
\bold{T}
\left[\begin{matrix}
a_{11}/a_{44} & a_{12}/a_{44} & a_{13}/a_{44} & 0 \\
a_{21}/a_{44} & a_{22}/a_{44} & a_{23}/a_{44} & 0 \\
a_{31}/a_{44} & a_{32}/a_{44} & a_{33}/a_{44} & 0 \\
0 & 0 & 0 & 1
\end{matrix}\right]
$$
$$
t_x = a_{14}/a_{44} \\ t_y = a_{24}/a_{44} \\ t_z = a_{34}/a_{44}
$$

With the bottom row and right column taken care of, we now only need to focus in the 3x3 inner matrix:
$$
\bold{N}=
\frac{1}{a_{44}}
\left[\begin{matrix}
a_{11} & a_{12} & a_{13} \\
a_{21} & a_{22} & a_{23} \\
a_{31} & a_{32} & a_{33} 
\end{matrix}\right]
$$

The remaining scaling, left-rotation, and right-rotation are factored using a process known as [singular value decomposition](https://en.wikipedia.org/wiki/Singular_value_decomposition).  If $\bold{N}$ is real-valued, the SVD takes the form:
$$
\bold{N} = \bold{U}\bold{\Sigma}\bold{V}^T
$$

Where $\bold{\Sigma}$ is a diagonal matrix, while $\bold{U}$ and $\bold{V}$ are both orthogonal matrices, so:
$$
\bold{U}^T\bold{U} = \bold{V}^T\bold{V} = \bold{1}
$$

Now, in order to obtain $\bold{U}$ and $\bold{V}$, note what happens when we substitute the above SVD for $\bold{N}$ in $\bold{N}^T\bold{N}$ and $\bold{N}\bold{N}^T$:
$$
\bold{N}^T\bold{N} = (\bold{U}\bold{\Sigma}\bold{V}^T)^T(\bold{U}\bold{\Sigma}\bold{V}^T) = 
\bold{V}\bold{\Sigma}^T\bold{U}^T\bold{U}\bold{\Sigma}\bold{V}^T = \bold{V}\bold{\Sigma}^T\bold{\Sigma}\bold{V}^T
$$

$$
\bold{N}\bold{N}^T = (\bold{U}\bold{\Sigma}\bold{V}^T)(\bold{U}\bold{\Sigma}\bold{V}^T)^T = 
\bold{U}\bold{\Sigma}\bold{V}^T\bold{V}\bold{\Sigma}^T\bold{U}^T = \bold{U}\bold{\Sigma}\bold{\Sigma}^T\bold{U}^T
$$

Now, since $\bold{\Sigma}$ is diagonal, $\bold{\Sigma}=\bold{\Sigma}^T$ and:
$$
\bold{N}^T\bold{N} = \bold{V}\bold{\Sigma}^2\bold{V}^T \\
\bold{N}\bold{N}^T = \bold{U}\bold{\Sigma}^2\bold{U}^T
$$

In this form, we see that $\bold{N}^T\bold{N}$ can be diagonalized to obtain $\bold{V}$, and $\bold{N}\bold{N}^T$ can be diagonalized to obtain $\bold{U}$.  In both cases, $\bold{\Sigma}^2$ represents the eigenvalues of $\bold{N}^T\bold{N}$ and/or $\bold{N}\bold{N}^T$.  For the time being, we will ignore the scalar $\frac{1}{a_{44}}$ in front of the above 3x3 matrix, as we can simply pull that into the scaling matrix later.  This process is *far* to tedious to calculate exactly here (especially for the general 3x3 matrix!).  However, there are a few special cases that may be of use:
$$
\bold{N}=
\left[\begin{matrix}
a & 0 & 0 \\
b & 0 & 0 \\
c & 0 & 0 
\end{matrix}\right]
$$

In this case:
$$
\bold{N}^T \bold{N} = 
\left[\begin{matrix}
a & 0 & 0 \\
b & 0 & 0 \\
c & 0 & 0 
\end{matrix}\right]
\left[\begin{matrix}
a & b & c \\
0 & 0 & 0 \\
0 & 0 & 0 
\end{matrix}\right]
=
\left[\begin{matrix}
a^2 & ab  & ac \\
ab  & b^2 & bc \\
ac  & bc  & c^2
\end{matrix}\right]
$$

After diagonalizing:
$$
\left[\begin{matrix}
a^2 & ab  & ac \\
ab  & b^2 & bc \\
ac  & bc  & c^2
\end{matrix}\right]
=
\left[\begin{matrix}
a/c & -c/a & -b/a \\
b/c & 0    & 1    \\
1   & 1    & 0
\end{matrix}\right]
\left[\begin{matrix} a^2+b^2+c^2 & 0 & 0 \\ 0 & 0 & 0 \\ 0 & 0 & 0 \end{matrix}\right]
\left[\begin{matrix}
a/c & -c/a & -b/a \\
b/c & 0    & 1    \\
1   & 1    & 0
\end{matrix}\right]^{-1}
$$

Therefore, the resulting scaling matrix is:
$$
\bold{\Sigma^2}=
\left[\begin{matrix}
a^2 + b^2 + c^2 & 0 & 0 \\
0 & 0 & 0 \\
0 & 0 & 0
\end{matrix}\right]
\rightarrow
\bold{S}=
\left[\begin{matrix}
\sqrt{a^2 + b^2 + c^2} & 0 & 0 \\
0 & 0 & 0 \\
0 & 0 & 0
\end{matrix}\right]
$$

This gives us a way to calculate a square root with floating-point precision!

Additionally, taking a look at $\bold{V}$, we know it represents a rotation matrix.  Recall that the game converts this matrix into quaternion form:
$$
\bold{V} =
\left[\begin{matrix}
a/c & -c/a & -b/a \\
b/c & 0    & 1    \\
1   & 1    & 0
\end{matrix}\right]
=
\left[\begin{matrix}
2x^2 + 2w^2 - 1 & 2xy - 2zw & 2xz - 2yw \\
2xy + 2zw & 2y^2 + 2w^2 - 1 & 2yz - 2xw \\
2xz + 2yw & 2yz + 2xw & 2z^2 + 2w^2 - 1
\end{matrix}\right]
$$

Note that, if we take the trace of these matrices:
$$
\text{tr}(\bold{V}) = \frac{a}{c} = 2x^2 + 2w^2 - 1 + 2y^2 + 2w^2 - 1 + 2z^2 + 2w^2 - 1 \\
\text{tr}(\bold{V}) = \frac{a}{c} = 2(\underbrace{x^2 + y^2 + z^2 + w^2}_{1}) + 4w^2 - 3 \\
\text{tr}(\bold{V}) = \frac{a}{c} = 4w^2 - 1 \\
\boxed{\frac{1}{2}\sqrt{\text{tr}(\bold{V})+1} = \frac{1}{2}\sqrt{\frac{a}{c}+1} = w }
$$

Computing the other terms:
$$
(2yz+2xw)-(2yz-2xw) = 1-1 \rightarrow 4xw = 0 \rightarrow x=0 \\
(2xz+2yw)-(2xz-2wy) = 1+\frac{b}{a} \rightarrow y = \left(1+\frac{b}{a}\right)\frac{1}{4w} \\
(2xy+2zw)-(2xy-2zw) = \frac{b}{c}+\frac{c}{a} \rightarrow z = \left(\frac{b}{c}+\frac{c}{a}\right)\frac{1}{4w}
$$

So, the quaternion corresponding to $\bold{V}$ is:
$$
\bold{q} = \left(\frac{1}{2}\sqrt{\frac{a}{c}+1}\right) + 0\bold{x} + \left(\frac{\frac{b}{a}+1}{2\sqrt{\frac{a}{c}+1}}\right)\bold{y} + \left(\frac{\frac{b}{c}+\frac{c}{a}}{2\sqrt{\frac{a}{c}+1}}\right)\bold{z}
$$

> Note: The above formula breaks down when $\frac{a}{c} \leq -1$

Note that if we set $c=1$ and $a=x-1$:
$$
w=\frac{1}{2}\sqrt{x-1+1} = \frac{1}{2}\sqrt{x}
$$

Meaning we *just* have a way to compute a square root.




Another potentially useful scenario(?):
$$
\bold{N} = \bold{x}\bold{y}^T
\left[\begin{matrix}
x_1 y_1 & x_1 y_2 & x_1 y_3 \\
x_2 y_1 & x_2 y_2 & x_2 y_3 \\
x_3 y_1 & x_3 y_2 & x_3 y_3 
\end{matrix}\right]
$$

Skipping over a LOT of algebra, we find that:
$$
\bold{S} = 
\left[\begin{matrix}
\sqrt{(\bold{x} \cdot \bold{x})(\bold{y} \cdot \bold{y})} & 0 & 0 \\
0 & 0 & 0 \\
0 & 0 & 0 
\end{matrix}\right]
$$

> Note: this is NOT useful, since it would require more multiplications than datapacks are suited for.




## Sample Cases

### Introducing Roll for Planes

Now, let's say we wanted to introduce *roll*.  Based on the above yaw and pitch matrices, the roll matrix takes the form:
$$
\bold{R_{roll}} = \left[\begin{matrix}
\cos\theta & -\sin\theta & 0 & 0 \\
\sin\theta & \cos\theta & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{matrix}\right]
$$

As for how to insert this into a display entity's overall transformation, recall it's transformation matrix:
$$
\bold{M} = \bold{T_{pos}}\bold{R_{yaw}}\bold{R_{pitch}}\bold{T}\bold{R_L}\bold{S}\bold{R_R}
$$

Here, we choose to work with $\bold{R_L}$, as it's closest to being in the correct position.  In order for it to commute with $\bold{T}$ and provide reasonable results, however, we must restrict $\bold{T}$:
$$
\bold{T}\bold{R_L} = \bold{R_L}\bold{T}
\\
\left[\begin{matrix}
1 & 0 & 0 & t_x \\
0 & 1 & 0 & t_y \\
0 & 0 & 1 & t_z \\
0 & 0 & 0 & 1 \end{matrix}\right]
\left[\begin{matrix}
\cos\theta & -\sin\theta & 0 & 0 \\
\sin\theta & \cos\theta & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{matrix}\right]
=
\left[\begin{matrix}
\cos\theta & -\sin\theta & 0 & 0 \\
\sin\theta & \cos\theta & 0 & 0 \\
0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1
\end{matrix}\right]
\left[\begin{matrix}
1 & 0 & 0 & t_x \\
0 & 1 & 0 & t_y \\
0 & 0 & 1 & t_z \\
0 & 0 & 0 & 1 \end{matrix}\right]
$$
$$
\left[\begin{matrix}
\cos\theta & -\sin\theta & 0 & t_x \\
\sin\theta &  \cos\theta & 0 & t_y \\
0 & 0 & 1 & t_z \\
0 & 0 & 0 & 1 \end{matrix}\right]
=
\left[\begin{matrix}
\cos\theta & -\sin\theta & 0 & t_x\cos\theta - t_y\sin\theta \\
\sin\theta & \cos\theta & 0 & t_x\sin\theta + t_y\cos\theta \\
0 & 0 & 1 & t_z \\
0 & 0 & 0 & 1
\end{matrix}\right]
$$

So:
$$
t_x = t_x\cos\theta - t_y\sin\theta \ \ \ \ \ \ \ \ \ \ \ \ t_y = t_x\sin\theta + t_y\cos\theta
\\
t_x = t_x\cos\theta - t_y\sin\theta \ \ \ \ \ \ \ \ \ \ \ \ t_y = \frac{\sin\theta}{1- \cos\theta}t_x
\\
t_x = t_x\cos\theta - \frac{\sin^2\theta}{1- \cos\theta}t_x
\\
t_x(1-\cos\theta) = t_x\cos\theta-t_x\cos^2\theta - t_x\sin^2\theta
\\
t_x(1-\cos\theta) = t_x\cos\theta - t_x
\\
t_x(1-\cos\theta) = t_x(\cos\theta - 1)
$$

There are only two ways to satisfy this equation: $\theta=0$ and $t_x=t_y=0$.  Of these, we obviously choose the latter.  So, we limit ourselves to translations of $[0,0,t_z]$.  With this, we can set $\bold{R_L} = \bold{R_{roll}}$ and achieve the target transformation:
$$
\boxed{\bold{M} = \bold{T_{pos}}\bold{R_{yaw}}\bold{R_{pitch}}\bold{R_{roll}}\bold{T}\bold{S}\bold{R_R}}
$$

### The Wheels on The Bus

Consider a vehicle, such as a car, which uses separate display entities for its wheels.  These wheels are allowed to roll, but must still match the car's orientation.  Is this (easily) achievable with display transformations?

The order of operations is:
1. Scaling*
2. Rotating of wheel (pitch direction)*
3. Translation to actual wheel position
4. Rotation to match vehicle orientation (only yaw)

* Note: technically, the scaling and rotation can be performed in either order if the model is centered on the axis of rotation.

Starting with:
$$
\bold{R_{yaw}}\bold{R_{pitch}}\bold{T}\bold{R_L}\bold{S}\bold{R_R}
$$

The car doesn't need to pitch, so $\bold{R_{pitch}} = \bold{I}$.  Additionally, we don't need $\bold{R_R}$, so:
$$
\bold{R_{yaw}}\bold{T}\bold{R_{spin}}\bold{S}
$$

Basically: this effect is trivially achievable.

### Helicopter Helicopter

Consider a helicopter that uses a separate display entity for its main rotor.  The rotor is allowed to spin while the craft is flying.  Additionally, the helicopter leans in the direction of travel.  Is this (easily) achievable with display transformations?

The order of operations is:
1. Scaling
2. Rotating of rotor blade (yaw direction)
3. Translation of rotor into actual position
4. Rotation to match vehicle orientation (yaw, pitch, roll)

At first, it may seem that there aren't enough rotation matrices (or, they're in the wrong order) to achieve this effect.  However, so long as the scaling matrix is the same in the x and z directions, we can swap $\bold{S}$ and $\bold{R_R}$:
$$
\bold{S}\bold{R_R}
 = \left[\begin{matrix} s & 0 & 0 & 0 \\ 0 & s_y & 0 & 0 \\ 0 & 0 & s & 0 \\ 0 & 0 & 0 & 1 \end{matrix}\right]
\left[\begin{matrix} \cos\theta & 0 & -\sin\theta & 0 \\ 0 & 1 & 0 & 0 \\ \sin\theta & 0 & \cos\theta & 0 \\ 0 &  0 & 0 & 1 \end{matrix}\right]
=\left[\begin{matrix} \cos\theta & 0 & -\sin\theta & 0 \\ 0 & 1 & 0 & 0 \\ \sin\theta & 0 & \cos\theta & 0 \\ 0 &  0 & 0 & 1 \end{matrix}\right]
\left[\begin{matrix} s & 0 & 0 & 0 \\ 0 & s_y & 0 & 0 \\ 0 & 0 & s & 0 \\ 0 & 0 & 0 & 1 \end{matrix}\right]
= \bold{R_R}\bold{S}
$$

Additionally, if the rotor is perfectly centered to begin with, (i.e. $t_x=t_z=0$) then $\bold{T}\bold{R_L}=\bold{R_L}\bold{T}$.  Finally, we use $\bold{R_L}$ for $\bold{R_roll}$ and $\bold{R_R}$ for $\bold{R_{spin}}$:
$$
\bold{R_{yaw}}\bold{R_{pitch}}\bold{R_{roll}}\bold{T}\bold{R_{spin}}\bold{S}
$$

Thus, we achieve the intended effect so long as the following constraints are met:
* The rotor only needs to be translated in the y-direction
* The rotor is scaled identically in the x and z directions


## Manipulating Display Entity Transformations

Equipped with a solid understanding of display entity transformations, how do we dynamically modify these transformations to achieve an intended visual?

Consider some of the tests cases shown so far.  What variables do their transformation matrices require?

### Yaw & Pitch

The yaw & pitch transformations are trivial to implement, as they merely require the yaw & pitch scores to be written to the display entity's `Rotation` tag (with appropriate precision factor, of course).


### Plane Roll

The axis-angle rotation matrix requires an angle, $\theta$, and a vector $\vec{u}$:
$$
\bold{R_L} = \bold{R_{\vec{u}}}(\theta)
$$

Display entities assume $\theta$ is in radians, whereas our system stores yaw, pitch, and roll in degrees.  For this, either a hard-coded or user-provided scale factor will be needed.  Additionally, roll requires that the axis, $\vec{u}$, be set to $\hat{z}$.


### Car Wheel Spinning

Recall the transformations matrices required for this effect:
$$
\bold{R_{yaw}}\bold{T}\bold{R_{spin}}\bold{S} = \bold{R_{yaw}}\bold{T}\bold{R_L}\bold{S}
$$

Here:
* Translation $(\bold{T})$ matrix is constant, and can be assigned upon vehicle spawn
* The scaling $(\bold{S})$ matrix is constant, and can be assigned upon vehicle spawn
* The yaw $\bold{R_{yaw}}$ is set by writing the vehicle's *yaw* score to the display's `Rotation[0]` with a precision factor
* Spin $\bold{R_{spin}}$ is set using:
  * $\theta$: Time, multiplied by a scale factor
  * $\vec{u}$: The constant unit vector $\hat{x}$ (parallel to untransformed wheel axle)


### Helicopter Rotor Spinning

Recall the transformation matrices required for this effect:
$$
\bold{R_{yaw}}\bold{R_{pitch}}\bold{R_{roll}}\bold{T}\bold{R_{spin}}\bold{S}
$$

Here:
* Translation $(\bold{T})$ matrix is constant, and can be assigned upon vehicle spawn
* The scaling $(\bold{S})$ matrix is constant, and can be assigned upon vehicle spawn
* The yaw $\bold{R_{yaw}}$ is set by writing the *yaw* to `Rotation[0]` with a precision factor
* Spin $\bold{R_{spin}}$ is set using:
  * $\theta$: Time, multiplied by a scale factor
  * $\vec{u}$: The constant unit vector $\hat{y}$


### Bringing Things Together

Here, we see a common theme of writing values (such as vehicle scores) to some display entity's nbt tags.  Under this notion, here are some of the attributes required to define a dynamic transform:
* Data source
  * Score name
  * Score precision
* Scale factor
* Display entity(s) to affect
* Name of transformation to affect 
* Additional constant arguments

The possible transformation attributes we might want to modify are:
|          NBT Path          |              Format              |
| -------------------------- | -------------------------------- |
| `Rotation[0]`              | `float`                          |
| `Rotation[1]`              | `float`                          |
| `transform.translation`    | `float[3]`                       |
| `transform.scale`          | `float[3]`                       |
| `transform.left_rotation`  | `{angle: float, axis: float[3]}` |
| `transform.right_rotation` | `{angle: float, axis: float[3]}` |

Unfortunately, the default format for `left_rotation` and `right_rotation` is quaternion, so we can't write to `angle` directly.  As a result, this system will need a way of preparing the full NBT tag to write.

With all of this in mind, the following transformation spec is proposed:
```yaml
{
  source: str,    # Name of vehicle score to grab data from
  axis: float[3], # Axis to rotate about when "transform" is "left_rotation" or "right_rotation"
  transform: str, # Name of the affected transform
  scale: float,   # Scale factor multiplied by the data source
  name: str,      # Name of mounted display entity to target.  Mutually exclusive with "group"
  group: str      # Tag used to target mounted display entities.  Mutually exclusive with "name"
}
```

Valid values for `transform` are:
* left_rotation
* left_rotation_x
* left_rotation_y
* left_rotation_z
* left_rotation_w
* right_rotation
* right_rotation_x
* right_rotation_y
* right_rotation_z
* right_rotation_w
* translation_x
* translation_y
* translation_z
* scale_x
* scale_y
* scale_z
* yaw
* pitch


Internally, this is converted on load to a slightly different spec to save time each tick:
```yaml
{
  scale: float,        # Scale factor multiplied by the data source
  temporary_init: {},  # Initial NBT that gets written to the intermediate tag
  temporary_path: str, # Path to value in intermediate NBT that gets written to directly
  path: str,           # Path to write intermediate tag to
  selector: str        # The target selector tag used to select entities
}
```

If `temporary_path` is present, the system will first declare an intermediate NBT tag with the initial data given by `temporary_init`.  Then, the value will be written to this tag using the path given by `temporary_path`.  Finally, the intermediate tag is written directly to the display entity using `path`.

Otherwise, if `temporary_path` is missing, then the system will simply write the value directly to `path`.

The logic for generating `temporary_init`, `temporary_path`, and `path` is as follows:
```
Switch (transform):
  Case left_rotation:
    path = "transformation.left_rotation"
    temporary_path = "angle"
    temporary_init = {angle: 0.0f, axis: [1.0f,0.0f,0.0f]}
    temporary_init.axis = axis
    done

  Case right_rotation:
    path = "transformation.left_rotation"
    temporary_path = "angle"
    temporary_init = {angle: 0.0f, axis: [1.0f,0.0f,0.0f]}
    temporary_init.axis = axis
    done

  Case left_rotation_x:
    path = "transformation.left_rotation[0]"
    done
  Case left_rotation_y:
    path = "transformation.left_rotation[1]"
    done
  Case left_rotation_z:
    path = "transformation.left_rotation[2]"
    done
  Case left_rotation_w:
    path = "transformation.left_rotation[3]"
    done

  Case right_rotation_x:
    path = "transformation.left_rotation[3]"
    done
  Case right_rotation_y:
    path = "transformation.left_rotation[3]"
    done
  Case right_rotation_z:
    path = "transformation.left_rotation[3]"
    done
  Case right_rotation_w:
    path = "transformation.right_rotation[3]"
    done

  Case translation_x:
    path = "transformation.translation[0]"
    done
  Case translation_y:
    path = "transformation.translation[1]"
    done
  Case translation_z:
    path = "transformation.translation[2]"
    done

  Case scale_x:
    path = "transformation.scale[0]"
    done
  Case scale_y:
    path = "transformation.scale[1]"
    done
  Case scale_z:
    path = "transformation.scale[2]"
    done

  Case yaw:
    path = "Rotation[0]"
    done

  Case pitch:
    path = "Rotation[1]"
    done

  Default:
    Invalid
```


Examples of the processed output:

**Roll:**
```yaml
{
  scale: 1.0,
  temporary_init: {angle: 0.0, axis: [0.0f, 0.0f, 1.0f]},
  path: "transformation.left_rotation.angle",
  selector: "@s[name=foobar]"
}
```

**Yaw:**
```yaml
{
  scale: 1.0,
  path: "Rotation[0]",
  selector: "@s[name=foobar]"
}
```


### Alternative Proposal 1

As an alternative to the above proposed spec, here is a spec that might be more powerful at the cost of performance:
```yaml
{
  transform: str,  # Name of transformation to affect.  See above for allowed values
  name: str,       # Name of mounted display entity to target.  Mutually exclusive with "group"
  group: str,      # Tag used to target mounted display entities.  Mutually exclusive with "name"
  arguments: {}    # Arguments to be supplied to this transform.  Depend on transform
}
```

As for the allowed values of `transform` along with the corresponding arguments:
* translation
  * x
  * y
  * z
* left_rotation
  * angle
  * x
  * y
  * z
* right_rotation
  * angle
  * x
  * y
  * z
* scale
  * x
  * y
  * z
* yaw
  * angle
* pitch
  * angle

Here, *any* argument would be able to reference a vehicle score along with a *scale* tag.

Ideally, not specifying an argument would simply leave it unaffected.  Unfortunately, that is not practical for left_rotation and right_rotation since they are stored as quaternions.  Currently, there is no practical way of converting from quaternion form to axis-angle form in Minecraft, as this would require evaluating square-roots and inverse trig functions.

It may be necessary to handle left_rotation/right_rotation in a specially: saving the tag to a special location before applying it, so that it may be retrieved later.


### Alternate Proposal 2

We could technically build the dynamic animation system into the event system by simply adding an action for modifying transformations:
```yaml
{
  action: "modify_transform",  # Edit property of an existing transform
  arguments: {
    source: str,    # Name of score to grab value from
    scale: float,   # Scale applied to score
    precision: float, # Inverse of score's precision multiplier (auto-generated)
    name: str,      # Name of mounted display entity to target.  Mutually exclusive with "group"
    group: str,     # Tag used to target mounted display entities.  Mutually exclusive with "name"
    transform: str, # Name of transform to modify
    property: str   # Name of transformation property to modify
  }
}
```

```yaml
{
  action: "set_transform",  # Sets a transform to an exact NBT value
  arguments: {
    name: str,      # Name of mounted display entity to target.  Mutually exclusive with "group"
    group: str,     # Tag used to target mounted display entities.  Mutually exclusive with "name"
    transform: str, # Name of transform to modify
    parameter: any  # NBT tag to set transformation to
  }
}
```

```yaml
{
  action: "set_rotation_axis_angle",  # Sets a rotation given a static axis and dynamic angle
  arguments: {
    source: str,    # Name of score to grab value from
    scale: float,   # Scale applied to score
    precision: float, # Inverse of score's precision multiplier (auto-generated)
    name: str,      # Name of mounted display entity to target.  Mutually exclusive with "group"
    group: str,     # Tag used to target mounted display entities.  Mutually exclusive with "name"
    transform: str, # Name of transform to modify (left_rotation or right_rotation)
    axis: float[3], # Axis of rotation
  }
}
```

The allowed properties for each transform are as follows:
| Transformation Name | Properties  |
| ------------------- | ----------- |
| translation         | x, y, z     |
| left_rotation       | x, y, z, w  |
| right_rotation      | x, y, z, w  |
| scale               | x, y, z     |
| yaw                 | angle       |
| pitch               | angle       |


This proposal is easier to implement, as scenarios that require different implementation (looking at you: rotations) can be split into different actions.  Additionally, it builds upon an already existing system thus preventing overhead from extra data preparation.  As such, we'll be going with this option.


### Looking Towards the Future

If, in the future, we ever get *a good way to do basic math*, it may be desirable to expand upon this system.  Particularly: allowing precise control over which transformations a display entity is subject to, as well as their order.  This would require matrix multiplication, evaluation of trig functions, and non-insanity-inducing data processing.

Firstly, part (aka display entity) tags would receive an additional field defining the order and type of transformations to be applied:
```yaml
{
  transformations: [
    {
      type: str,     # The type of transformation
      name: str,     # Name assigned to this transformation
      axis: float[3] # Axis to rotate around when type="axis_rotation"
    }
  ]
}
```

Here, transformation matrices are applied first-to-last, and multiplied together right-to-left.  Additionally, the allowed values of "type" are:
* translation
* rotation
* axis_rotation
* scale

For example, the current default transformations list would be:
```yaml
{
  transformation: [
    {
      type: "rotation",
      name: "right_rotation"
    },
    {
      type: "scale",
      name: "scale"
    },
    {
      type: "rotation",
      name: "left_rotation"
    },
    {
      type: "translation",
      name: "translation"
    },
    {
      type: "axis_rotation",
      name: "pitch",
      axis: [1.0f, 0.0f, 0.0f]
    },
    {
      type: "axis_rotation",
      name: "yaw",
      axis: [0.0f, 1.0f, 0.0f]
    }
  ]
}
```

Which, expressed using matrix multiplication, is:
$$
\bold{M} = \bold{R_{yaw}}\bold{R_{pitch}}\bold{T}\bold{R_L}\bold{S}\bold{R_R}
$$


## Additional Remarks

### Has Science Gone Too Far?

It should be noted that this system is MASSIVELY over-engineered.  At this point, we might as well write a script that generates a bunch of functions to achieve the requested behavior.

However, my hope with this framework is to reduce the work required to port vehicles to newer versions.  As updates are released, only the framework will (in theory) need to be updated.  As long as the vehicle specification remains consistent, existing vehicle definitions will "just work."

### The Challenge of Updates

Although offering a consistent specification across versions is nice and all, we'll inevitably need to contend with changes in implementation.

For example, let's say Mojang bestows upon us data-driven entities for Java edition.  No longer would we need to use an assembly of interactions, item displays, and armor stands.  Instead, we get to rewrite the entire framework around using a singular entity—hooray!  Yet, this poses a problem: what about existing vehicles in people's worlds?  Are they rendered unsupported and broken—left to waste away in obsolescence?

A seamless upgrade is clearly the ideal user experience.  However, this would require the implementation and careful maintenance of a system capable of upgrading between datapack versions.  Besides changes in the framework's implementation, recall that commands and their syntax frequency change between updates in datapack-breaking ways.  Now, Minecraft *does* have a system for this in the form of overlays, allowing datapacks to function across multiple versions by simply overriding files based on version.  

This means we'd need to maintain *every* updater function for *every future datapack format*.  As the number of updates to both the game and datapack grow, we'd have to test updating from *every single version* to make sure the new updater functions work.

Put simply: this is untenable.  I do not have the time or resources to test upgrading from *every single version*.  As such, we're left with a couple of options:

* Suck it up and maintain every single updater function ever written.  Most of them likely won't do much, since significant implementation changes are far rarer than simple syntax changes.
  * We may be able to automate setting up versions using a fleet of local servers.  A script would automatically stand up each server with a copy of the datapack for testing.  The world could be empty, and a player wouldn't even need to log in!
  * We'd also want unit-testing functions to rapidly test features.  That way, each server could automatically test features without user intervention.
  * Of course, some features couldn't be unit-tested due to their reliance on a player.  However, basic updating could still be tested without player intervention.
  * This has the potential to very rapidly consume resources as the number of server.jar's increase.
  * This would probably still require some decent maintenance.
  * The time required to test all upgrade functions can only increase.
  * Newer features will NEVER be backported to overlays (that's a can of worms I don't like!)
  * Bug fixes may be backported to overlays if applicable
  * Only FULL RELEASE game versions will be tested (datapack format number increased from 26 to 41 between 1.20.4 and 1.20.5 alone!)

* Pretend older versions don't exist and don't worry about it.

### Data Processing Sucks in Datapacks

Current estimates place the number of commands required to parse/validate a vehicle definition at around **800**.  With a default value for `maxCommandChainLength` of 65536, this gives a maximum of about *80 vehicles*.

Needless to say, this isn't great.  As such, it may be beneficial to split the vehicle definition process over multiple ticks.  The current system inherently can't support this, so for now I've added an automatic failure check in case we hit the limit during reload.


---

# Some Coordinate Shenanigans

In Minecraft, the unit vector in the direction of ($\theta$, $\phi$) is given by:
$$
\hat{r}(\theta,\phi) = -\sin\theta \cos\phi \hat{x} - \sin\phi \hat{y} + \cos\theta \cos\phi \hat{z}
$$

The player's relative coordinate system is given by:
$$
\hat{u} = \hat{r}(\theta,\phi)
\\
\hat{v} = \hat{r}(\theta,\phi-90^o)
\\
\hat{w} = \hat{r}(\theta-90^o,0)
$$

Where:
* $\hat{u}$ is forward relative to the camera
* $\hat{v}$ is vertical relative to the camera
* $\hat{w}$ is left relative to the camera

Additionally, the player's XZ-snapped look vector is given by:
$$
\hat{u}_{xz} = \hat{r}(\theta,0)
\\
\hat{w}_{xz} = \hat{r}(\theta-90^o,0)
$$

Now, imagine the player is attempting to move in some direction.  We can obtain a vector, $\vec{m}$ that represents the XZ-snapped direction of travel:
$$
\vec{m} = -m\sin\alpha \hat{x} + m\cos\alpha \hat{z}
$$

Our goal is to convert this into a vector, $\vec{m}'$, that is *not* XZ-snapped.  Instead, it should correspond to WASD in the direction, $\hat{u}$, the player is looking.

For this, our first step is to decompose $\vec{m}$ with respect to $\{\hat{u}_{xz},\hat{w}_{xz}\}$:
$$
\vec{m} = (\vec{m} \cdot \hat{u}_{xz})\hat{u}_{xz} + (\vec{m} \cdot \hat{w}_{xz})\hat{w}_{xz}
$$

Next, we replace the basis vectors $\{\hat{u}_{xz},\hat{w}_{xz}\}$ with $\{\hat{u},\hat{w}\}$:
$$
\boxed{\vec{m}' = (\vec{m} \cdot \hat{u}_{xz})\hat{u} + (\vec{m} \cdot \hat{w}_{xz})\hat{w}}
$$

Finally, we convert back to a $\{\hat{x}, \hat{y}, \hat{z}\}$ basis.  This step is trivially performed in-game using carrot notation.

So, we need to calculate $\vec{m} \cdot \hat{u}_{xz}$ and $\vec{m} \cdot \hat{w}_{xz}$, and then use carrot notation to obtain $\vec{m}'$.

Is there a faster way of obtaining $\vec{m} \cdot \hat{u}_{xz}$ and $\vec{m} \cdot \hat{w}_{xz}$ than using the dot product?
$$
\vec{m} \cdot \hat{u}_{xz} = (m_x\hat{x} + m_z\hat {z}) \cdot (\hat{u}_{xz}) = 
$$




