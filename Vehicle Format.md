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
| vehicle.fuel                 | integer                | Amount of fuel in tank                                   |


## Vehicle Definition Data Structure

This data structure fully defines a vehicle.  Each vehicle definition is added to the master vehicle table upon reload.
```yaml
{
  name: str,        # Name of vehicle (required)
  author: str,      # Vehicle creator (required)
  collection: str,  # Vehicle collection (required)
  camera_multiplier: float,  # Camera distance multiplier while riding the vehicle (optional, defaults to 1)
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
          action: "consume_fuel",  # Decreases vehicle.fuel by 1, but clamps it at zero
          arguments: {}            # Required, but leave empty
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
  format_version: int,  # The vehicle definition format required for this definition to be loaded (required)
  do_not_update: bool,   # If true, the vehicle will NEVER be updated (do not use)
  max_fuel: int,        # Maximum capacity of fuel tank (optional, defaults to 8000)
  accepts_fuel: bool    # Whether the vehicle accepts fuel at all (optional, defaults to true)
}
```

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
| reds_vehicles:state/has_fuel               | Passes when the vehicle's `vehicle.fuel` score is above 0     |
| reds_vehicles:state/out_of_fuel            | Passes when the vehicle's `vehicle.fuel` score is 0 or below  |
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


## Error Handling

The vehicle definition loader has a built-in system for catching errors/mistakes in definitions.  Any vehicle that encounters an error upon load will be dropped from the final processed vehicle table to prevent unexpected behavior.  Additionally, a message will be announced to chat stating that errors occurred:
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



# Physics Forces

Vehicles are subject to varying types of forces based on their design.  Since Minecraft doesn't have a concept of mass (instead, it perform calculations directly on velocity) we'll use Netwon's second law to separate out the mass and acceleration:
$$
F_{net} = ma \rightarrow a = \frac{F_{net}}{m}
$$

Distributing the mass amongst the individual forces as a constant:
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


Of potential use: the minimum velocity for takeoff is given by:
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
