extends Loca
class_name LocaTake

var enemys := []
var layers := []

class Layer:
	var items := []
	var lv = 1
	var loca :LocaTake
	var size = 1

func _pressed():
	pass
	
func _newWeek():
	newLayer(1,1)
	newLayer(1,2)
	newLayer(2,1)

func newLayer(lv,size):
	var layer = Layer.new()
	layer.lv = lv
	layer.size = size
	layer.loca = self
	
	var i1 = data.newBase("mater_gold")
	i1.num = lvPer(size,lvPer(lv,3000,0.5),0.5) 
	layer.items.append(i1)
	
	var i2 = data.newBase(sys.player.materPool.rndItem().id) 
	i2.num = lvPer(size,lvPer(lv,40,0.5),0.5) 
	layer.items.append(i2)
	
	for j in 1 :
		var item = EqpCreate.new()
		item.create(layer.lv)
		item.loadInfo("")
		layer.items.append(item)

	layers.append(layer)
