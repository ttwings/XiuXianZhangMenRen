extends Equip

export(int,0,99) var physical_damage
export(int,0,99) var spell_damage
export(int,FLAGS,"Slash","Stab","Shoot","Hammer") var physical_damage_type
export(int,FLAGS,"Fire","Ice","Electric","Stone") var spell_damage_type

# 斩击 突刺 射 锤击
# Slash, stab, shoot, hammer

# 火 冰 电
# Fire ice electric
