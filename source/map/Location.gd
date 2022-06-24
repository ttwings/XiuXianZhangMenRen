extends Resource

class_name Location

@export var alias = ""
@export_flags("金","水","木","火","土") var category
@export_enum("一阶","二阶","三阶","四阶","五阶","六阶") var gather
@export_range(0,999999,1) var res_stone
@export_range(0,999999,1) var res_plant
@export var sect:String
@export_range(1,9,1) var space
@export_range(0,9,1) var field
@export_range(0,9,1) var mine

var id := 0
var cell := Vector2()
var position := Vector2()
#var unit : Unit = null setget _set_unit
#var terrain : Terrain = null
var side_number := -1
var team_name := ""
var _neighbors := []
#var castle := []
func _init():
	_neighbors.resize(6)
func set_terrain(code:Array) -> void:
	var data := []
#	for c in code:
#		data.append(Data.terrains[c])
#	terrrain = Terrain.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_neighbor(loc: Location, direction: int) -> void:
	_neighbors[direction] = loc

func get_neighbor(direction: int) -> Location:
	return _neighbors[direction]

func get_neighbors() -> Array:
	var neighbors := []
	for n in _neighbors:
		if n:
			neighbors.append(n)
	return neighbors

func get_all_neighbors() -> Array:
	return _neighbors

func get_all_neighbors_top_bottom() -> Array:
	return [_neighbors[0], _neighbors[-1], _neighbors[1], _neighbors[-2], _neighbors[2], _neighbors[3]]

