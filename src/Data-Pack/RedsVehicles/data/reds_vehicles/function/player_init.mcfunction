# Function for first-time player setup
# This is called using an advancement trigger as soon as the player joins the game

# Welcome message
tellraw @a [{text:"[",color: "#00FF00"},{text:"Redstone⁴'s Vehicles",color:"light_purple"},{text:"]: ",color: "#00FF00"},{translate: "reds_vehicles.welcome.message", fallback: "Thank you for using Redstone⁴'s Vehicles!", color:"green"},{translate:"reds_vehicles.welcome.not_installed_hint",fallback: "  If you can read this, it means you don't have the resource pack enabled.  Don't forget to enable it!",color:"dark_green"}]

# Grant all recipes
function #reds_vehicles:grant_recipes
