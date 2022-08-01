class_name ItemPck

signal onAddItem(item,inx)
signal onDelItem(item,inx)
signal onFullItem(item)
signal onChangeItem(pck,inx1,inx2)

var items :Array = []
var weight = 0  #总物品的重量

func _init():
	pass

func addItem(item,inx = -1):
	if item.isNum :
		var oi = hasIdItem(item.id)
		if oi != null:
			oi.num += item.num
			return
	if inx == -1 :inx = items.size()
	items.insert(inx,item)
	weight += 1
	emit_signal("onAddItem",item,inx)
	item.emit_signal("onEnter")
	return item
	
func hasIdItem(id):
	for i in items :
		if i.id == id:
			return i
	return null
	
func delItem(item):
	var inx = items.find(item)
	if inx != -1:
		#items[inx] = null
		items.remove(inx)
		weight -= 1
		emit_signal("onDelItem",item,inx)
		item.emit_signal("onExit")
		return inx
	
func delInxItem(inx):
	var item = items[inx]
	delItem(item)
	return item
	
