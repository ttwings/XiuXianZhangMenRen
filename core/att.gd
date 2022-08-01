extends Base
class_name Att

signal onAttSet(id)

var maxHp = 0 : set = setMaxHp
var def = 0 : set = setDef
var atk = 0 : set = setAtk
var cri = 0 : set = setCri
var criR = 0 : set = setCriR
var resi = 0 : set = setresi
var ran = 0 : set = setRan
var spd = 0 : set = setSpd
var cdSpd = 0 : set = setCdSpd
var rpHp = 0 : set = setRpHp
var suck = 0 : set = setSuck

var attBase :Dictionary= {}
var perAddDs = {}
var perMulDs = {}
var atts = []
var onAtt = false
var attDisabled = false : set = setAttDisabled

func setMaxHp(val):
	maxHp=val
	_fAtt("maxHp",val)

func setDef(val):
	def=val
	_fAtt("def",val)

func setAtk(val):
	atk=val
	_fAtt("atk",val)

func setCri(val):
	cri=val
	_fAtt("cri",val)

func setCriR(val):
	criR=val
	_fAtt("criR",val)

func setresi(val):
	resi=val
	_fAtt("resi",val)

func setRan(val):
	ran=val
	_fAtt("ran",val)

func setSpd(val):
	spd=val
	_fAtt("spd",val)

func setCdSpd(val):
	cdSpd=val
	_fAtt("cdSpd",val)

func setRpHp(val):
	rpHp=val
	_fAtt("rpHp",val)

func setSuck(val):
	suck=val
	_fAtt("suck",val)

func setAttDisabled(val): #属性禁用
	attDisabled = val
	upAtt(self)
		
func loadInfo(id):
	self.id = id
	_data()
	for i in cons.attDs:
		if get(i) != null:
			attBase[i] = get(i)
	self.lv = lv
	_dataEnd()
	
func _fAtt(id,val):
	if !onAtt && mas != null:
		mas.addAtt(self)
	emit_signal("onAttSet",id)

#属性百分比叠加
func perAdd(id,val):
	perAddDs[id] = val
	_fAtt(id,val)
#属性百分比相乘
func perMul(id,val):
	perMulDs[id] = val
	_fAtt(id,val)

#添加附属物  属性，buff，天赋，技能，通用统一了
func addAff(base):
	if affs.has(base) :return base
	affs.append(base)
	if ifAtt(base) :
		if addAtt(base):upAtt(base)
	base.inStart(self)
	emit_signal("onAddAff",base)
	return base
#删除附属物
func delAff(base): 
	if affs.has(base):
		affs.erase(base)
		if atts.has(base) :
			atts.erase(base)
			if base.is_connected("onAttSet",self,"rAttSet"):
				base.disconnect("onAttSet",self,"rAttSet")
		upAtt(base)
		emit_signal("onDelAff",base)
		base.emit_signal("onDel")
		#base.mas = null
	return base
	
func addAtt(base):
	if atts.has(base) : return false
	base.connect("onAttSet",self,"rAttSet")
	atts.append(base)
	onAtt = true
	return true
	
#查找是否有目标id的Aff	
func hasAff(id):
	for i in affs:
		if i.id == id :
			return i
	return null
	
func ifAtt(base):
	for i in cons.attDs:
		if base.get(i) != null && base.get(i) != 0 :
			return true
		if base.perAddDs.has(i) || perMulDs.has(i) :
			return true
	return false
	
func upAtt(base):
	for i in base.attBase:
		if base.get(i) == null : continue
		if base.get(i) != 0 || base.perAddDs.has(i) || base.perMulDs.has(i): 
			rAttSet(i)


func rAttSet(id):
	var val = attBase[id]
	var per = 1.0
	var mul = 1.0
	for i in atts:
		if i.attDisabled : continue
		if i.get(id) == null: continue
		val += i[id]
		if i.perAddDs.has(id) :
			per += i.perAddDs[id]
		if i.perMulDs.has(id) :
			mul *= 1.0 + i.perMulDs[id]
	set(id,val*per*mul)
	
