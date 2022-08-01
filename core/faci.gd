extends Obj
class_name Faci  #冒险中的设施和事件

signal onSetGlow()
signal onPressed()

var glow = false setget setGlow 

var icoId = ""
var txt = ""

func loadInfo(id):
	self.id = id
	icoId = "ico_%s" % id
	_data()
	for i in cons.attDs:
		if get(i) != null:
			attBase[i] = get(i)
	self.lv = lv
	_dataEnd()

func setGlow(val):
	glow = val
	emit_signal("onSetGlow")

func _trig():
	pass

func forBuff(id = "",lv = 10):
	var bf
	if id == "" : 
		bf =  sys.player.buffPool.rndItem(self,"rfBuff")
		id = bf.id
	else:bf = data.newBase(id)
	for cha in sys.rogue.batScene.getAllChas():
		if cha.team == sys.rogue.masTeam :
			cha.castBuff(cha,id,lv)
	txt +=  "受到祝福，全队获得 %d层 %s\n"%[lv,bf.name]
	
func forDeBuff(id = "",lv = 2):
	var bf
	if id == "" : 
		bf =  sys.player.buffPool.rndItem(self,"rfDeBuff")
		id = bf.id
	else:bf = data.newBase(id)
	for cha in sys.rogue.batScene.getAllChas():
		if cha.team == sys.rogue.masTeam :
			cha.castBuff(cha,id,lv)
	txt += "遭遇陷阱，全队附加 %d层 %s\n"%[lv,bf.name]

func rfBuff(buff):
	if buff.hasTab("buff") :return true
	return false

func rfDeBuff(buff):
	if buff.hasTab("deBuff") :return true
	return false
