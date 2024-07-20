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

We distribute the mass amongst the individual forces as a constant:
$$
\underbrace{\vec{F}_{net} = \sum_i \vec{F}_i \ \ \ \ \ \ \ \ \ \ \ \vec{a} = \frac{\vec{F}_{net}}{m}}
\\
\vec{a} = \sum_i \frac{1}{m}\vec{F}_i
$$

Below are various forces we may wish to include.  All related force equations will be presented as solved for acceleration.


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
* $v$ = Velocity relative to air
* $m$ = Mass constant

For the sake of simplicity, we collect various constants together:
$$
\boxed{a_L = b_l v^2}
$$

Where:
$$
b_l = \frac{1}{m}C_l A\left(\frac{1}{2}\rho\right) 
$$


## Drag Force

Drag occurs due to collisions between the surrounding air and a vehicle.  For the velocity regime planes are subject to, it is described by:
$$
a_D = \frac{1}{m}C_D\left(\frac{1}{2}\rho v^2\right)A
$$

Where:
* $a_D$ = Acceleration due to drag
* $C_D$ = Coefficient of drag
* $A$ = Cross sectional area perpendicular to direction of travel
* $\rho$ = Air density
* $v$ = Velocity relative to air
* $m$ = Mass constant

For the sake of simplicity, we collect various constants together:
$$
\boxed{a_D = b_Dv^2}
$$

Where:
$$
b_D = \frac{1}{m}C_D A\left(\frac{1}{2}\rho\right)
$$


Be warned, however, as second-order air resistance is notorious for being difficult to simulate.


In addition, Minecraft already applies its own first-order drag force.  This is applied by multiplying the horizontal and vertical velocity components by a constant factor each tick:
$$
\vec{v}_{h, \ after} = (1-k_h)\vec{v}_{h, \ before} \\
\vec{v}_{v, \ after} = (1-k_v)\vec{v}_{v, \ before}
$$

Where:
* $\vec{v}_h$ = Horizontal component of velocity vector
* $\vec{v}_v$ = Vertical component of velocity vector
* $\vec{v}_{before}$ = Velocity before drag
* $\vec{v}_{after}$ = Velocity after drag
* $k_h$ = Horizontal drag coefficient.  For players and other living entities this is 0.09 in air and ~0.454 on the ground
* $k_v$ = Vertical drag coefficient.  0.02 for players and other living entities

For players and living entities, drag is applier AFTER acceleration due to gravity.


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



You know, it might've been simpler to assume a force from the thrust, and just orient the aircraft in a believeable direction relative to the velocity.  So:
* Adjust yaw/pitch to point plane in direction of velocity
* Adjust roll such that...


You know, maybe I'll come back to this one...


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
  click: {
    right: bool,  # Whether the passenger just right-clicked
    left: bool,   # Whether the passenger just left-clicked
  },
  input: {
    forward: int, # Whether the player is moving forward/backward in the camera direction; 1=forward, -1=backward.
    side: int     # Whether the player is moving left/right in the camera direction; 1=left, -1=right.
  }
}
```

Inputs are gathered as a group, that is: requesting `look.x` will also gather `look.y` and `look.z`.  Additionally, certain groups will automatically cause other groups to be gathered as well to prevent regathering the same information:

|     Group     |   Dependencies  |
| ------------- | --------------- |
| look          |        -        |
| look_xz       |        -        |
| motion        |        -        |
| directed      | motion          |
| rotation      |        -        |
| rotation_diff |        -        |
| click         |        -        |
| input         | look_xz, motion |


## Vehicle Scoreboards

All vehicles will have common set of scoreboard values (stored by the root vehicle entity) that contain pertinent information about their state/motion.  These include:

|          Name          |         Format        |                    Description                       |
| ---------------------- | --------------------- | ---------------------------------------------------- |
| vehicle.rot.yaw        | x10000 fixed-precision | Yaw (↔️)                                              |
| vehicle.rot.pitch      | x10000 fixed-precision | Pitch (↕️)                                            |
| vehicle.rot.roll       | x10000 fixed-precision | Roll (↺)                                             |
| vehicle.vel.x          | x100 fixed-precision  | x-velocity                                           |
| vehicle.vel.y          | x100 fixed-precision  | y-velocity                                           |
| vehicle.vel.z          | x100 fixed-precision  | z-velocity                                           |
| vehicle.engine         | boolean 0 or 1        | Engine state                                         |
| vehicle.version        | integer               | Datapack version number vehicle was summoned with    |
| vehicle.accel.forward  | x100 fixed-precision  | Amount to change velocity in the vehicle's direction.  Reset to zero each tick |
| vehicle.thrust         | x1000 fixed-precision | Used in physics calculations to determine vehicle thrust |
| vehicle.event.firework | boolean 0 or 1        | Summon a firework once                               |
| vehicle.event.honk     | boolean 0 or 1        | Honk the horn                                        |
| vehicle.event.shoot    | boolean 0 or 1        | Fire a projectile                                    |
| vehicle.event.cooldown | integer               | Cooldown between event triggers in ticks             |


## Vehicle Definition Data Structure

This data structure fully defines a vehicle.  Each vehicle definition is added to the master vehicle table upon reload.
```yaml
{
  name: str,   # Name of vehicle (required)
  handling: [  # A list of tags that define how the vehicle's variables react to user input (optional)
    {
      input: "look.x",        # Path to the input value in the user input NBT tag
      operation: "increase",  # Operation to apply to vehicle variable.  May be "increase", "decrease", "set", or "toggle"
      scale: {                # Information regarding how the input value is scaled
        source: str,          # Where to obtain the scale factor from.  May be "constant," or "score"
        value: float,         # Amount to scale the input value by when source is "constant"
        name: str             # Name of the score to obtain when source is "score"
      },
      variable: "vel.x"       # Name of the affected score
    }
  ],
  physics: [  # A collection of tags that define what physics forces the vehicle is subject to (optional)
    {
      type: "gravity",  # Base acceleration due to gravity.  This is handled specially using attributes
      value: float      # Defaults to 0.08 if this tag is not present
    },
    {
      type: "buoyant",       # Vehicle is subject to buoyancy
      environment: "water",  # Environment vehicle is buoyant in.  May be "water", "lava", or "air"
      value: float           # Ratio between medium and vehicle densities
    },
    {
      type: "simple_lift",   # Vehicle experiences lift proportional to velocity squared
      value: float           # Lift constant
    },
    {
      type: "planar_drag",   # Vehicle experiences |v|² drag in its relative horizontal plane
      value: float           # Drag constant
    }
  ],
  bonuses: [  # A list of tags that enable certain bonuses (such as potion effects) when in certain environments (optional)
    {
      environment: "underwater",  # Environment that bonus applies to
      type: "effect",             # Type of bonus to apply.  May be "effect"
      value: str                  # Extra argument depending on effect type
    }
  ],
  events: {   # A collection of tags for configuring various event triggers (optional)
    cooldown: int,   # Cooldown, in ticks, between successive events
    horn: str,       # Sound played when horn is honked
    projectile: {    # What projectile to shoot
      direction: str,  # Direction to fire projectile in.  May be "forward" or "down"
      type: str        # Entity to summon as the projectile
    }
  },
  parts: [    # A collection of tags describing the display entities that make up the visual model
    {
      scale: float[3],       # Model scale factors in the x, y, and z directions.  Overidden by transform.
      translation: float[3], # Model translation in the x, y, and z directions.  Overidden by transform.
      transform: float[16],  # An array of floats representing the display's initial 4x4 transformation matrix
      item: str,             # Name of the item displayed by the entity
      model: int,            # Item's custom model
      name: str              # Name assigned to display entity.  Cannot contain spaces
    }
  ],
  seat: {
    width: float,       # Width of seat entity (default=1.0)
    height: float       # Height of seat entity (default=1.0)
  },
  ground_offset: float, # The offset between the root entity's base and the seat (default=1.0)
  step_height: float,   # The maximum block height that a vehicle can climb
  min_version: int,     # The minimum datapack version required for this definition to be loaded (required)
  do_not_update: bool   # If true, the vehicle will NEVER be updated
}
```

To ensure consistency in vehicle definitions from one version to the next, this specification will be made *immutable* once ready: tags can never be removed, only added.  Existing tags *may* be marked as "deprecated," though they will be automatically translated into applicable replacement tags.



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
  entities: [      # A list of entities to summon that will be riding the root vehicle entity
    {
      type: "interaction",  # The interaction representing the pilot seat.  Automatically added in
      pilot: true,          # Whether this interaction is the primary cockpit
      tags: {
        width: float,       # Defaults to 1.0, or set to seat.width if provided
        height: float       # Defaults to 1.0, or set to seat.width if provided
      }
    },
    {
      type: "item_display",  # One of the item display entities specified in "parts"
      transform: float[16],  # An array of floats representing the display's initial 4x4 transformation matrix
      item: str,             # Name of the item displayed by the entity
      model: int,            # Item's custom model
      name: str              # Name assigned to display entity
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

From testing, a bug occurs where the player's Motion tag will spontaneously zero in a particular direction.  This bug has only been observed for scale factors $\lesssim$ 0.6 (0.5925 blocks)

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
```


## Additional Remarks

### Has Science Gone Too Far?

It should be noted that this system is MASSIVELY over-engineered.  At this point, we might as well write a script that generates a bunch of functions to achieve the requested behavior.

However, my hope with this framework is to reduce the work required to port vehicles to newer versions.  As updates are released, only the framework will (in theory) need to be updated.  As long as the vehicle specification remains consistent, existing vehicle definitions will "just work."

### The Challenge of Updates

Although offering a consistent specification across versions is nice and all, we'll inevitably need to contend with changes in implementation.

For example, let's say Mojang bestows upon us data-driven entities for Java edition.  No longer would we need to use an assembly of interactions, item displays, and armor stands.  Instead, we get to rewrite the entire framework around using a singular entity—hooray!  Yet, this poses a problem: what about existing vehicles in people's worlds?  Are they rendered unsupported and broken—left to waste away in obsolescence?

A seamless upgrade is clearly the ideal user experience.  However, this would require the implementation and careful maintenance of a system capable of upgrading between datapack versions.  Besides changes in the framework's implementation, recall that commands and their syntax frequency change between updates in datapack-breaking ways.  Now, Minecraft *does* have a system for this in the form of overlays, allowing datapacks to function across multiple versions by simply overiding files based on version.  

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
