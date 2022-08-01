extends Att
class_name Obj

signal onSetCell()
signal onSetGoalCell()

var isDeath = false
var goalCell 
var vis

var cell:Vector2 : set = setCell
var position := Vector2.ZERO

func setCell(val):
	if self.cell == val :
		return
	cell = val
	emit_signal("onSetCell")

func matMove(cell):
	if self.cell == cell :
		return false
	return scene.matMove(cell,self)

#到另一个单位的距离
func distanceTo(obj):
	return scene.oddr_distance(cell,obj.cell)

func del():
	super.del()
	scene.exitMat(self)
	
func inScene():
	_inScene()
	for i in affs:
		i.scene = scene
		i._inScene()

func _inScene():
	pass
