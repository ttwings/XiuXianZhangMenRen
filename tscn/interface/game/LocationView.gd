extends Panel

export(Resource) var location setget set_location

signal location_change(location)

export(Resource) var region_event

onready var alias = $MarginContainer/VBoxContainer/CenterContainer/Alias
onready var concentration = $MarginContainer/VBoxContainer/Concentration/Value
onready var category = $MarginContainer/VBoxContainer/Category/Value
onready var gather = $MarginContainer/VBoxContainer/Gather/Value
onready var res_stone = $MarginContainer/VBoxContainer/ResStone/Value
onready var res_plant = $MarginContainer/VBoxContainer/ResPlant/Value
onready var sect = $MarginContainer/VBoxContainer/Sect/Value
onready var space = $MarginContainer/VBoxContainer/Space/Value
onready var field = $MarginContainer/VBoxContainer/Field/Value
onready var mine = $MarginContainer/VBoxContainer/Mine/Value

#var pos

func _ready():
	pass
#	connect("location_change",self,"on_locaion_changed")
#
func on_region_click():
	if region_event and region_event is RegionEvent:
		region_event.connect("region_click",self,"on_region_click")
#		connect("location_change",region_event,"")


func on_locaion_changed():
#	pos = get_global_mouse_position()
#	set_position(pos)
#	show()
	if location and location is Location:
		self.show()
		alias.text = str(location.alias)
		category.text = str(location.category)
		gather.text = str(location.gather)
		res_stone.text = str(location.res_stone)
		res_plant.text = str(location.res_plant)
		sect.text = str(location.sect)
		space.text = str(location.space)
		field.text = str(location.field)
		mine.text = str(location.mine)
	else:
		self.hide()	
		
func set_location(loc):
	location = loc
	if location and location is Location:
		alias.text = str(location.alias)
		category.text = str(location.category)
		gather.text = str(location.gather)
		res_stone.text = str(location.res_stone)
		res_plant.text = str(location.res_plant)
		sect.text = str(location.sect)
		space.text = str(location.space)
		field.text = str(location.field)
		mine.text = str(location.mine)
	emit_signal("location_change",loc)		
