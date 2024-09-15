# This function builds up the default precision table

data modify storage reds_vehicles:precision defaults append value {key: "vehicle.rot.yaw", value: 10000}
data modify storage reds_vehicles:precision defaults append value {key: "vehicle.rot.pitch",value: 10000}
data modify storage reds_vehicles:precision defaults append value {key: "vehicle.rot.roll",value: 10000}
data modify storage reds_vehicles:precision defaults append value {key: "vehicle.dvel.x",value: 1000}
data modify storage reds_vehicles:precision defaults append value {key: "vehicle.dvel.y",value: 1000}
data modify storage reds_vehicles:precision defaults append value {key: "vehicle.dvel.z",value: 1000}
data modify storage reds_vehicles:precision defaults append value {key: "vehicle.engine",value: 1}
data modify storage reds_vehicles:precision defaults append value {key: "vehicle.accel.forward",value: 1000}
data modify storage reds_vehicles:precision defaults append value {key: "vehicle.thrust",value: 1000}

