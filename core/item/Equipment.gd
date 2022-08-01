extends Item

class_name Equipment

## 质量 
## 耐久度
export(int,0,200) var quality setget set_quality,get_quality
export(int,0,999) var durability
export(String,"None","Weapon","Armor","Accessories") var equipment_slot

var owner
var is_equiped setget set_is_equiped,get_is_equiped

# 武器 护甲 饰品
# Weapon Armor Accessories

func set_quality(q:int):
    if q<0 :
        q = 0
    if q>100 :
        q = 100
    quality = q

func set_durability(d:int):
    if d<0 :
        d = 0
    if d>100 :
        d = 100
    durability = d

func get_quality() ->int :
    return quality

func get_durability() ->int :
    return durability

