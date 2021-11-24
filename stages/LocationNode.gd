extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(Resource) var location

signal mouse_entered_location()

var cell:Vector2 setget ,get_cell
var pos_mouse:Vector2
var map:TileMap
var ui

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_cell():
	map = get_parent().get_parent()
	if map is TileMap:
		cell = map.world_to_map(position)
	else:
		cell = Vector2(-1,-1)
		print_debug("no tilemap find")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_mouse_entered():
	pos_mouse = get_global_mouse_position()
	emit_signal("mouse_entered_location",pos_mouse)
#	print_debug(pos_mouse)
	print_debug(cell)
	pass # Replace with function body.
