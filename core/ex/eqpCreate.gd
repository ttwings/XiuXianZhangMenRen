extends Eqp
class_name EqpCreate #随机创建的装备

var maxLv = 4

func _data():
	icoId = "ico_item_000"

func create(lv):
	name = "随机装备"
	self.lv = lv
	for i in clamp(sys.rndRan(lv-1,lv+1),2,4):
		var gem = data.newBase(sys.player.gemPool.rndItem(self,"rndCreate").id)
		addGem(gem)
	var n = lv * 2 - gems.size()
	while(n > 0):
		var inx = sys.rndRan(0,gems.size()-1)
		if gems[inx].lv < maxLv:
			gems[inx].lv += 1
			n -= 1
	price = 4000 * lv
	

func rndCreate(item):
	for i in gems:
		if i.id == item.id :
			return false
	return true

