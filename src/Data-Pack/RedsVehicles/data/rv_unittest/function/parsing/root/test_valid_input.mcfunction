#### UNIT TEST ####

data modify storage reds_vehicles:unittest name set value "parsing/root/test_valid_input"
data modify storage reds_vehicles:unittest description set value {text:"Try to declare a valid vehicle"}
data modify storage reds_vehicles:unittest reason set value ""

#####################################################################################################

# Setup
function #reds_vehicles:define/cleanup_all
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

function rv_unittest:parsing/root/valid_sample

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/root/parse

#tellraw @a {"nbt":"working_root","storage": "reds_vehicles:definitions"}
# > {base_gravity:0.0f,default_scores:[{name:"vehicle.foobar",value:20}],entities:[{pilot:1b,tags:{height:2.0f,width:4.0f},type:"interaction"},{item:{id:"minecraft:glass"},name:"display.outer",transform:[4.0f,0.0f,0.0f,0.0f,0.0f,4.0f,0.0f,0.0f,0.0f,0.0f,4.0f,0.0f,0.0f,0.0f,0.0f,1.0f],type:"item_display"}],events:[{actions:[{action:"playsound",arguments:{pitch:1.0d,sound:"minecraft:block.stone.break",volume:1.0d}}],predicate:""},{actions:[{action:"particle",arguments:{count:1,deltaX:0.0d,deltaY:0.0d,deltaZ:0.0d,name:"minecraft:bubble",offsetU:0.0d,offsetV:0.0d,offsetW:0.0d,speed:0.0d}}],predicate:""}],handling:[{input:"directed.x",operation:"increase",precision:1000,scale:{source:"constant",value:0.05d},variable:"vehicle.dvel.x"}],inputs:["directed"],min_version:1,name:"orb",physics:[{predicate:"if predicate reds_vehicles:has_passenger ",type:"applied",uid:727297308,value:1.0f}],scale:0.050632913f,seat_count:1,step_height:0.6f}

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

# Check output
execute unless data storage reds_vehicles:definitions working_root{author:"Redstone⁴"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.author to be \"Redstone⁴\" (was "},{nbt:"working_root.author", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{author:"Redstone⁴"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{base_gravity:0.0f} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.base_gravity to be 0.0f (was "},{nbt:"working_root.base_gravity", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{base_gravity:0.0f} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{default_scores:[{name:"vehicle.foobar",value:20}]} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.default_scores to be [{name:\"vehicle.foobar\",value:20}] (was "},{nbt:"working_root.default_scores", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{default_scores:[{name:"vehicle.foobar",value:20}]} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{entities:[{hitbox:1b,tags:{height:2.0f,width:4.0f},type:"interaction"},{pilot:1b,tags:{height:0.0f,width:0.0f},type:"interaction"},{item:{id:"minecraft:glass"},name:"display.outer",transform:[4.0f,0.0f,0.0f,0.0f,0.0f,4.0f,0.0f,0.0f,0.0f,0.0f,4.0f,0.0f,0.0f,0.0f,0.0f,1.0f],type:"item_display"}]} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.entities to be [{pilot:1b,tags:{height:2.0f,width:4.0f},type:\"interaction\"},{item:{id:\"minecraft:glass\"},name:\"display.outer\",transform:[4.0f,0.0f,0.0f,0.0f,0.0f,4.0f,0.0f,0.0f,0.0f,0.0f,4.0f,0.0f,0.0f,0.0f,0.0f,1.0f],type:\"item_display\"}] (was "},{nbt:"working_root.entities", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{entities:[{hitbox:1b,tags:{height:2.0f,width:4.0f},type:"interaction"},{pilot:1b,tags:{height:0.0f,width:0.0f},type:"interaction"},{item:{id:"minecraft:glass"},name:"display.outer",transform:[4.0f,0.0f,0.0f,0.0f,0.0f,4.0f,0.0f,0.0f,0.0f,0.0f,4.0f,0.0f,0.0f,0.0f,0.0f,1.0f],type:"item_display"}]} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_root.parts run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_root.parts to have been dropped"}
execute if data storage reds_vehicles:definitions working_root.parts run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_root.events[0] run data modify storage reds_vehicles:unittest reason set value {text:"Vehicle was not declared with any events"}
execute if data storage reds_vehicles:definitions working_root.events[0] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{handling:[{input:"directed.x",operation:"increase",precision:1000,scale:{source:"constant",value:0.05d},variable:"vehicle.dvel.x"}]} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.handling to be [{input:\"directed.x\",operation:\"increase\",precision:1000,scale:{source:\"constant\",value:0.05d},variable:\"vehicle.dvel.x\"}] (was "},{nbt:"working_root.handling", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{handling:[{input:"directed.x",operation:"increase",precision:1000,scale:{source:"constant",value:0.05d},variable:"vehicle.dvel.x"}]} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{physics:[{predicate:"if predicate reds_vehicles:has_passenger ",type:"applied",value:1.0f}]} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.physics to be [{predicate:\"if predicate reds_vehicles:has_passenger \",type:\"applied\",uid:727297308,value:1.0f}] (was "},{nbt:"working_root.physics", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{physics:[{predicate:"if predicate reds_vehicles:has_passenger ",type:"applied",value:1.0f}]} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{inputs:["directed"]} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.inputs to be [\"directed\"] (was "},{nbt:"working_root.inputs", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{inputs:["directed"]} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{seat_count: 1} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.seat_count to be 1 (was "},{nbt:"working_root.seat_count", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{seat_count: 1} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{scale: 0.050632913f} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.scale to be 0.050632913f (was "},{nbt:"working_root.scale", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{scale: 0.050632913f} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_root.ground_offset run data modify storage reds_vehicles:unittest reason set value {text:"Expected working_root.ground_offset to be dropped"}
execute if data storage reds_vehicles:definitions working_root.ground_offset run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{step_height: 0.6f} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.step_height to be 0.6f (was "},{nbt:"working_root.step_height", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{step_height: 0.6f} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{min_version: 1} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.min_version to be 1 (was "},{nbt:"working_root.min_version", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{min_version: 1} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{base_gravity: 0.0f} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.base_gravity to be 0.0f (was "},{nbt:"working_root.base_gravity", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{base_gravity: 0.0f} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{name: "orb"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.base_gravity to be 0.0f (was "},{nbt:"working_root.base_gravity", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{name: "orb"} run return run function rv_unittest:common/fail


#####################################################################################################

# Setup - MINIMAL SAMPLE
function #reds_vehicles:define/cleanup_all
data merge storage reds_vehicles:definitions {vehicles:[],processed:[]}
function reds_vehicles:define/logging/reset

function rv_unittest:parsing/root/minimal_sample

# Run functions
execute store result score vehicle.unittest.result vehicle.unittest.local run function reds_vehicles:define/root/parse

#tellraw @a {"nbt":"working_root","storage": "reds_vehicles:definitions"}
# > {base_gravity:0.0f,default_scores:[{name:"vehicle.foobar",value:20}],entities:[{pilot:1b,tags:{height:2.0f,width:4.0f},type:"interaction"},{item:{id:"minecraft:glass"},name:"display.outer",transform:[4.0f,0.0f,0.0f,0.0f,0.0f,4.0f,0.0f,0.0f,0.0f,0.0f,4.0f,0.0f,0.0f,0.0f,0.0f,1.0f],type:"item_display"}],events:[{actions:[{action:"playsound",arguments:{pitch:1.0d,sound:"minecraft:block.stone.break",volume:1.0d}}],predicate:""},{actions:[{action:"particle",arguments:{count:1,deltaX:0.0d,deltaY:0.0d,deltaZ:0.0d,name:"minecraft:bubble",offsetU:0.0d,offsetV:0.0d,offsetW:0.0d,speed:0.0d}}],predicate:""}],handling:[{input:"directed.x",operation:"increase",precision:1000,scale:{source:"constant",value:0.05d},variable:"vehicle.dvel.x"}],inputs:["directed"],min_version:1,name:"orb",physics:[{predicate:"if predicate reds_vehicles:has_passenger ",type:"applied",uid:727297308,value:1.0f}],scale:0.050632913f,seat_count:1,step_height:0.6f}

# Analyze and display results
# Check success/failure status
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run data modify storage reds_vehicles:unittest reason set value {text:"Failed to parse valid input"}
execute if score vehicle.unittest.result vehicle.unittest.local matches 0 run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{author:"Redstone⁴"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected working_root.author to be \"Redstone⁴\" (was "},{nbt:"working_root.author", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{author:"Redstone⁴"} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_root.handling[0] run data modify storage reds_vehicles:unittest reason set value {text:"Minimal vehicle was not declared with any events"}
execute if data storage reds_vehicles:definitions working_root.handling[0] run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_root.events[0] run data modify storage reds_vehicles:unittest reason set value {text:"Minimal vehicle was not declared with any events"}
execute if data storage reds_vehicles:definitions working_root.events[0] run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_root.physics[0] run data modify storage reds_vehicles:unittest reason set value {text:"Minimal vehicle was not declared with any physics"}
execute if data storage reds_vehicles:definitions working_root.physics[0] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{base_gravity: 0.08d} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected minimal vehicle's working_root.base_gravity to be 0.08d (was "},{nbt:"working_root.base_gravity", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{base_gravity: 0.08d} run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_root.default_scores[0] run data modify storage reds_vehicles:unittest reason set value {text:"Minimal vehicle was not declared with any default scores"}
execute if data storage reds_vehicles:definitions working_root.default_scores[0] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root.entities[{type:"interaction"}] run data modify storage reds_vehicles:unittest reason set value {text:"Expected minimal vehicle to have an \"interaction\" type entity"}
execute unless data storage reds_vehicles:definitions working_root.entities[{type:"interaction"}] run return run function rv_unittest:common/fail

execute if data storage reds_vehicles:definitions working_root.entities[2] run data modify storage reds_vehicles:unittest reason set value {text:"Minimal vehicle has more than two entities in its entities list"}
execute if data storage reds_vehicles:definitions working_root.entities[2] run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{seat_count: 1} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected minimal vehicle's working_root.seat_count to be 1 (was "},{nbt:"working_root.seat_count", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{seat_count: 1} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{name: "air"} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected minimal vehicle's working_root.name to be \"air\" (was "},{nbt:"working_root.name", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{name: "air"} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{scale: 1.0126582f} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected minimal vehicle's working_root.scale to be 1.0126582f (was "},{nbt:"working_root.scale", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{scale: 1.0126582f} run return run function rv_unittest:common/fail

execute unless data storage reds_vehicles:definitions working_root{min_version: 1} run data modify storage reds_vehicles:unittest reason set value [{text:"Expected minimal vehicle's working_root.min_version to be 1 (was "},{nbt:"working_root.min_version", storage:"reds_vehicles:definitions"},{text:")"}]
execute unless data storage reds_vehicles:definitions working_root{min_version: 1} run return run function rv_unittest:common/fail

# Everything passed!
return run function rv_unittest:common/pass
