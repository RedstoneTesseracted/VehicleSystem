# Cleans up temporary scores used in reds_vehicles:define/bonus_list/parse
scoreboard players reset vehicle.bonus_list_error vehicle.local
data remove storage reds_vehicles:definitions unprocessed_bonuses
data remove storage reds_vehicles:definitions processed_bonuses
data remove storage reds_vehicles:definitions working_bonus
