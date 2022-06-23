extends Control

onready var location_view = $LocationView
onready var world_map = $Port/Viewport/WorldMap
var location_node


var xi_yu_huang_sha_huan_jing
var XiYuHuangShaHuanJin

func _ready():
#	location_view.hide()
#	location_node = world_map.get_node("Locations/L_mountain_001")
#	location_view.set_position(location_node.position + Vector2(32,0))
#	location_view.set_location(location_node.location)
#	location_view.show()
	print(world_map.get_node("Locations/L_mountain_001").cell)
	pass
#	connect("mouse_entered")


func _on_WorldMap_find_location(pos):
	location_view.set_position(pos)
	location_view.show()
	pass # Replace with function body.
