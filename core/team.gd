extends Obj
class_name Team
signal onAddCha(cha)

var chas:Array = []

func _in():
	pass

func addCha(cha):
	cha.team = self
	chas.append(cha)
	emit_signal("onAddCha",cha)
