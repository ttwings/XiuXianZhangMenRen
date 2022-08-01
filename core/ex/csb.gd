extends Item
class_name Csb #消耗品

func _init():
	isNum = true
	price *= 0.5

func use():
	self.num -= 1
	_use()
	if num <= 0 :
		sys.player.items.delItem(self)
	
func _use():
	pass
