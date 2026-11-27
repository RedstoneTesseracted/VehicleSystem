# Redstone⁴'s Vehicle System

This datapack provides a framework for adding controllable, data-driven vehicles to Minecraft.  Three vehicles are included with the pack:
* Submarine
* Biplane
* Helicopter

![Biplane on runway](images/biplane.png)


# Built-In Vehicles

**Submarine**:
* WASD + mouse to move around
* Does not sink in water

**Biplane**:
* Left-click to toggle engine
* Forward/Backward to increase/decrease thrust

**Helicopter**:
* Left-click to toggle engine
* WASD + mouse to move around
* Jump to move upwards


# Adding Vehicles

All vehicle definitions are declared in the global `vehicles` array under the `reds_vehicles:definitions` storage.  These vehicles are then processed and validated upon reload.

To add a new vehicle, create a new function that appends its definition to the `vehicles` array.  This function must then be added to the `#reds_vehicles:declare_vehicles` function tag to ensure it's run at reload.

For example vehicle definitions, see [`src/Data-Pack/RedsVehicles/data/reds_vehicles/function/vehicles/`](src/Data-Pack/RedsVehicles/data/reds_vehicles/function/vehicles/).  The full vehicle spec is outlined in `Vehicle Format.md`.


# Version Support

This datapack uses overlays to support multiple versions of the game with a single ZIP file.

|  Game Version  | Data Pack Version |
| -------------- | ----------------- |
| 1.21.6-26.3    | 1.0.0-alpha       |


# Credits

This datapack makes use of the following sound effects:

| Name | Author | Link | License |
| ---- | ------ | ---- | ------- |
| Lawn tractor startup | ursenfuns | https://freesound.org/s/440592/ | [Creative Commons 0](https://creativecommons.org/publicdomain/zero/1.0/) |
| JCB_Engine_Shutoff.wav | mickyman5000 | https://freesound.org/s/340682/ |[Creative Commons 0](https://creativecommons.org/publicdomain/zero/1.0/) |
| ENGINE~1.WAV | MarlonHJ | https://freesound.org/s/242739/ | [Creative Commons 0](https://creativecommons.org/publicdomain/zero/1.0/) |
| Helicopter Paasing and engine shut-down at Film Shoot.mp3 | Cymeon | https://freesound.org/s/205897/ |[Creative Commons 0](https://creativecommons.org/publicdomain/zero/1.0/) |
