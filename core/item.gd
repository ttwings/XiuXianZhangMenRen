extends Buff
class_name Item

signal onSetNum()

var price = 4000
var num = 1 :set = setNum

func setNum(val):
	num = val
	emit_signal("onSetNum")
