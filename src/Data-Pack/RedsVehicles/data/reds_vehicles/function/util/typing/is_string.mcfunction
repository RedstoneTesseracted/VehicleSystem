# This function checks if the provided data value is a string
# and returns the result
#
# Value must be provided by setting the "check" tag in the 
# reds_vehicles:types storage
#

data modify storage red_vehicles:types compare set value [""]
return run data modify storage red_vehicles:types compare append from storage red_vehicles:types check
