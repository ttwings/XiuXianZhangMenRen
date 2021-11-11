tool
extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(Resource) var item
onready var Name = $HBoxContainer/Name
onready var Desc = $HBoxContainer/Desc
# Called when the node enters the scene tree for the first time.
func _ready():
	show_item()
	pass # Replace with function body.

func show_item():
	Name.text = item.name
	Desc.text = item.describe
