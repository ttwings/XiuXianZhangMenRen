extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var equip_dialog = $Tabs/EquipConfirmationDialog
onready var equip_button = $HBoxContainer/Right/VBoxContainer/Item

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Item_pressed():
	equip_dialog.popup()
	pass # Replace with function body.


func _on_ConfirmationDialog_confirmed():
	pass # Replace with function body.
