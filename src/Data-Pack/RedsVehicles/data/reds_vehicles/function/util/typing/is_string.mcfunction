# This function checks if the provided data value is a string
# and returns the result
#
# Value must be provided by setting the "check" tag in the 
# reds_vehicles:types storage
#

data modify storage red_vehicles:types compare set value ["regjmhniluhguioaer;jfg8iahgi5t;o4tujhal4ui5;ujftghrual;r94w8o4thy905h8uaoe4r9wue87lgzisbu.ghnj/s9g;e845ahiubw9ghu87lseui4;aow98ghlsua;49u58hslbinogiaef;w94eu85hsli534867gytbh9['eahsuybg589e]"]
return run data modify storage red_vehicles:types compare[0] set from storage red_vehicles:types check
