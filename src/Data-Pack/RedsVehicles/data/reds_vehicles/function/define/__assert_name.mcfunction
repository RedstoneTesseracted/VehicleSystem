scoreboard players set vehicle.ok_flag vehicle.local 1
$execute if data storage reds_vehicles:definitions processed[{name:'$(name)'}] run return 1
return 0
