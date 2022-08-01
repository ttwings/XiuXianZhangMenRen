class_name Base

signal onAddAff(base) #获得附属物时
signal onDelAff(base) #移除附属物时
signal onDel() #被移除时
signal onSetLv() #等级改变时
signal onExit() #从itemPck 移除时
signal onEnter() #从itemPck 进入时

var name = ""
var dec = "" :
	set = setDec,
	get = getDec
func setDec(val):dec = val
func getDec():return dec

var id = ""
var mas:Base = null
var lv = 1 : set = setLv

var tab = ""
var isNum = false
var weight = 0
var scene:Scene
var lock = 1 #解锁状态 -1 从不出现在池中，0 未解锁，1 已解锁

enum HURTTYPE {NORMAL,SKILL,EFF}

var affs = []

func setLv(val):
	lv = val
	emit_signal("onSetLv")
		
func _data():
	pass
	
func _dataEnd():
	pass

func loadInfo(id):
	self.id = id
	_data()
	self.lv = lv
	_dataEnd()

#添加附属物  属性，buff，天赋，技能，通用统一了
func addAff(base):
	if affs.has(base) :return base
	affs.append(base)
	base.inStart(self)
	emit_signal("onAddAff",base)
	return base
#删除附属物
func delAff(base): 
	if affs.has(base):
		affs.erase(base)
		emit_signal("onDelAff",base)
		base.emit_signal("onDel")
		base.mas = null
	return base
	
#查找是否有目标id的Aff	
func hasAff(id):
	for i in affs:
		if i.id == id :
			return i
	return null

func inStart(mas):
	self.mas = mas
	_in()
	
func _in():
	pass
	
func del():
	if mas != null:
		mas.delAff(self)
	emit_signal("onDel")
#按等级比率增加数值
func lvPer(lv,baseVal,val):
	return baseVal * (1 + (lv-1) * val)

#是否包含所有标签 tabs 可以是多个标签如“xxx xxx”
func hasTab(tabs):
	var list = tabs.split(" ")
	var list2 = tab.split(" ")
	for i in list:
		var b = false
		for j in list2:
			if i == j :
				b = true
				continue
		if !b :return false
	return true
	
#是否包含其中一个 tabs 可以是多个标签如“xxx xxx”
func hasOrTab(tabs):
	var list = tabs.split(" ")
	for i in list:
		if tab.find(i) != -1 :
			return true
	return false

func _inScene():
	pass
## todo 20220731 change to new gd 2.0	
#func connect(sig,target,method,binds=[],flags=0):
#	if is_connected(sig,target,method) == false:
#		super.connect(sig,target,method,binds,flags)
	
func delAllConnect():
	for i in get_incoming_connections ():
		i["source"].disconnect(i["signal_name"],self,i["method_name"])	
