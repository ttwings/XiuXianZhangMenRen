extends TileMap

signal find_location()
signal cell_changed()

signal game_time_changed( to )
signal cell_selected( cell )

@export var location_dic:Dictionary
@export var region_event:Resource

var map_hovered = false:
	set = _set_map_hovered
var cell_hovered = null:
	set = _set_cell_hovered

var map
var loc_dict = {} :
	set = _set_loc_dict,
	get = _get_loc_dict
@onready var locations = $Locations

var game_time = 0 :
	set = _set_game_time

func _ready():
	var size = locations.get_child_count()
	var cell
	var loc
	for i in size:
		loc = locations.get_child(i)
		cell = Vector2(14,14)
		loc_dict[cell] = loc
		print_debug(loc_dict)

	map = self
	
func add_loc(cell,loc):
	loc_dict[cell] = loc

func find_loc(cell):
	if loc_dict and loc_dict[cell]:
		return loc_dict[cell]
	else:
		print_debug("location not find on cell:",cell)		
	
func _set_loc_dict(dict):
	loc_dict = dict	

func _get_loc_dict():
	return loc_dict	

func _on_Port_gui_input( ev ):
	# Place the Map Cursor
	if ev is InputEventMouseMotion:
		if !self.map_hovered:
			self.map_hovered = true
		var mcell = map.world_to_map( get_global_mouse_position() )
		if mcell != self.cell_hovered:
			self.cell_hovered = mcell
	# 划过关键点时候，响应显示内容
		if loc_dict and loc_dict.has(mcell):
			print_debug(loc_dict[mcell])		
			
	# Select a cell that's clicked
	if ev is InputEventMouseButton and map_hovered:
		if ev.pressed and ev.button_index == MOUSE_BUTTON_LEFT:
			print("click!",self.cell_hovered)
			emit_signal( "cell_selected", self.cell_hovered )
		elif ev.pressed and ev.button_index == MOUSE_BUTTON_RIGHT:
			print("cancelled")
			emit_signal( "cell_selected", null )

func _on_Port_mouse_exited():
	self.map_hovered = false
	self.cell_hovered = null


func _set_cell_hovered( what ):
	cell_hovered = what
	if cell_hovered:
		$Cursor.position = map.map_to_world( cell_hovered )


func _set_map_hovered( what ):
	map_hovered = what
	$Cursor.visible = map_hovered



func _set_game_time( what ):
	game_time = what
	emit_signal("game_time_changed", game_time)


func _on_LocationNode_mouse_entered_location(loc):
	emit_signal("find_location",loc)
	pass # Replace with function body.
