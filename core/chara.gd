extends Obj
class_name Chara

signal onPressed()  #被点击时
signal onHurtStart(atkInfo)  #被伤害前（攻击信息）
signal onHurt(atkInfo)  #被伤害后（攻击信息）
signal onCastHurtStart(atkInfo) #造成伤害前（攻击信息）
signal onCastHurt(atkInfo)  #造成伤害后（攻击信息）
signal onPlusHp(val,castCha)  #回复生命值（回复值，施放者）
signal onCastPlusHp(val,Cha)  #施放回复生命值（回复值，被施放者）
signal onPlusWard(val,castCha) #获得护盾值（护盾值，施放者）
signal onCastPlusWard(val,Cha) #给目标施放护盾时(护盾值，被施放者)
signal onDeathStart(atkInfo) 
signal onDeath(atkInfo)
signal onKillStart(atkInfo)
signal onKill(atkInfo)
signal onCastSkill(skill) #施放主动技能时（施放的技能）
signal onChangeTeam()
signal onChangeTexture()
signal onSetEqp(item,inx)
signal onChangeEqp(inx1,inx2)
signal onCastBuff(buff)
signal onAddBuff(buff)
signal onAnimTrig()
signal onPlayAnim(id,spd)
signal onSetDire()
signal onPlusLv()
signal onPlusXp(val)
signal onChangeImg()
signal onSetAnimFile()
signal onChangeTgUnit()
signal onNormAtk()
signal onAiRanUnit(cha)
signal onDiag(cha)
signal onRevive()
signal onPlaySe(file,scale)

var hp = 0 : set = setHp
var ward = 0 : set = setWard
var pop = 0
func setWard(val):ward = val
func setHp(val):hp=val
var team 
var aiCha = null
var qlv = 1
var eqps:ItemGrid
var skills:ItemPck = ItemPck.new()

var isInvin = false

var normAtk = null #普通攻击
var normAtkTime = 0  #普通攻击时间
var nowAnim = ""
var animFile = "res://res/anim/p/p1.tres"
var animOffset = Vector2.ZERO
var animScale = Vector2(1.5,1.5)
var baseAtkS = 1
var atkFram = 3
var imgCenterPos = Vector2.ZERO
var attLv = Att.new()
var xp = 0
var maxXp = 2

func loadInfo(id):
	ran = 1
	spd = 1.0
	cdSpd = 1.0
	rpHp = 1.0
	criR = 2.0
	cri = 0.0
	addAtt(attLv)
	super.loadInfo(id)

func _dataEnd():
	hp = maxHp
	if pop == 0 :
		pop = qlv
	attBase.erase("hp")
	eqps = ItemGrid.new(qlv)
	
func inStart(mas):
	skills.connect("onAddItem",self,"rAddSkill")
	normAtk = data.newBase("k_norm")
	normAtk.inStart(self)
	playAnim("idle")
	super.inStart(mas)
	
var dire:int = 1 : set = setDire
func setDire(val):
	if val == 0 :return
	elif val > 0 :dire = 1
	elif val < 0 :dire = -1
	emit_signal("onSetDire")
#按价值比率 单位 品级 设置属性
func attRatio(ds):
	for i in cons.upAtt :
		set(i,ds[i] * cons.attDs[i].rt * (1 + (qlv -1) * 0.5))

func setLv(val):
	for i in cons.upAtt:
		attLv[i] = attBase[i] * (val - 1) * 0.2
	super.setLv(val)
	
func setEqp(item,inx):
	var itemb = eqps.items[inx]
	eqps.delItem(itemb)
	var inxItems = sys.player.items.delItem(item)
	eqps.addItem(item,inx)
	if itemb != null:
		sys.player.items.addItem(itemb,inxItems)
	
func rAddSkill(item,inx):
	addAff(item)
func rDelSkill(item,inx):
	delAff(item)

func hurtBase(atkInfo:AtkInfo):
	if atkInfo.hitCha == null || atkInfo.hitCha.isDeath  || atkInfo.hitCha.isInvin: return
	atkInfo.atkCha.emit_signal("onCastHurtStart",atkInfo)
	atkInfo.hitCha.emit_signal("onHurtStart",atkInfo)
	scene.emit_signal("onChaCastHurtStart",atkInfo)
	scene.emit_signal("onChaHurtStart",atkInfo)
	var defVal = atkInfo.hitCha.def
	atkInfo.atkVal *= atkInfo.hurtL
	atkInfo.hurtVal = atkInfo.atkVal * ( 1 - defVal/(defVal+100) )
	if atkInfo.canCri && sys.rndPer(cri) :
		atkInfo.hurtVal *= criR
		atkInfo.atkVal *= criR
		atkInfo.isCri = true
	atkInfo.hitCha.ward -= atkInfo.hurtVal
	if atkInfo.hitCha.ward < 0 :
		atkInfo.hitCha.hp += atkInfo.hitCha.ward
		atkInfo.hitCha.ward = 0
	if atkInfo.hitCha.hp < 0 :
		atkInfo.hitCha.hp = 0
		atkInfo.hitCha.death(atkInfo)
	var rh = atkInfo.atkCha.suck * atkInfo.hurtVal
	if rh > 0 :
		atkInfo.atkCha.plusHp(rh)
	atkInfo.atkCha.emit_signal("onCastHurt",atkInfo)
	atkInfo.hitCha.emit_signal("onHurt",atkInfo)
	scene.emit_signal("onChaCastHurt",atkInfo)
	scene.emit_signal("onChaHurt",atkInfo)
	#print_debug(atkInfo.hitCha.hp)
	return atkInfo.hurtVal
	
func hurt(chara,atkVal,hurtType = HURTTYPE.NORMAL,source = null):
	if source == null: source = self
	var atkInfo = AtkInfo.new()
	atkInfo.atkCha = self
	atkInfo.hitCha = chara
	atkInfo.atkVal = atkVal
	atkInfo.source = source
	atkInfo.hurtType = hurtType
	return hurtBase(atkInfo)
	
func aiSeekCha(exCha = null):
	for i in range(1,20):
		for j in scene.getRing(cell,i) :
			var cha = scene.matObj(j)
			if cha != null && cha != exCha && cha.team != team && !cha.isDeath :
				aiCha = cha
				return
	
func death(atkInfo):
	isDeath = true
	emit_signal("onDeathStart",atkInfo)
	atkInfo.atkCha.emit_signal("onKillStart",atkInfo)
	scene.emit_signal("onChaDeathStart",atkInfo)
	scene.emit_signal("onChaKillStart",atkInfo)
	if isDeath :
		emit_signal("onDeath",atkInfo)
		scene.emit_signal("onChaDeath",atkInfo)
		atkInfo.atkCha.emit_signal("onKill",atkInfo)
		scene.emit_signal("onChaDeath",atkInfo)
		scene.emit_signal("onChaKill",atkInfo)
		del()
		delAllBuff()
		#delAllConnect()
		
func del():
	scene.exitMat(self)
	
func atkNorm():
	if isNormAnim() && vis.isMove == false && aiCha != null && aiCha.isDeath == false && normAtkTime <= 0:
		normAtk.castStart()
		normAtkTime = 1.8 / (baseAtkS * spd)
		emit_signal("onNormAtk")
		return true
	return false
	
func isNormAnim():
	if nowAnim == "idle" || nowAnim == "move" || nowAnim == "atk":
		return true
	return false
	
func playAnim(id,spd = 1.0):
	if isDeath && nowAnim == "death" :return
	nowAnim = id
	emit_signal("onPlayAnim",id,spd)

func castBuff(cha,bId,lv = 1):
	var oldBf = cha.hasAff(bId)
	if oldBf != null:
		oldBf.lifeVal = oldBf.life
		oldBf.lv += lv
		emit_signal("onCastBuff",oldBf)
		emit_signal("onAddBuff",oldBf)
		scene.emit_signal("onChaCastBuff",oldBf)
		scene.emit_signal("onChaAddBuff",oldBf)
	else:
		var bf = data.newBase(bId)
		cha.addAff(bf)
		bf.lv = lv
		bf.lifeVal = bf.life
		bf.castCha = self
		emit_signal("onCastBuff",bf)
		emit_signal("onAddBuff",bf)
		scene.emit_signal("onChaCastBuff",bf)
		scene.emit_signal("onChaAddBuff",bf)
	
func plusHp(val,cha = null,isEff = true):
	if cha == null: cha = self
	val *= rpHp
	cha.hp += val
	if cha.hp > cha.maxHp :
		cha.hp = cha.maxHp
	if isEff && is_instance_valid(scene):
		scene.newEff("e_plusHp",cha.position,cha.imgCenterPos)
	emit_signal("onCastPlusHp",val,cha)
	cha.emit_signal("onPlusHp",val,self)
	if is_instance_valid(scene) == false:return
	scene.emit_signal("onChaCastPlusHp",self,val,cha)
	scene.emit_signal("onChaPlusHp",cha,val,self)
	
func plusWard(val,cha = null,isEff = true):
	if cha == null: cha = self
	val *= rpHp
	cha.ward += val
	if isEff :
		scene.newEff("e_plusHp",cha.position,cha.imgCenterPos)
	emit_signal("onCastPlusWard",val,cha)
	cha.emit_signal("onPlusWard",val,self)
	scene.emit_signal("onChaCastPlusWard",self,val,cha)
	scene.emit_signal("onChaPlusWard",cha,val,self)
	
func castSkill():
	pass

func plusLv(val):
	self.lv += val
	upMaxXp()
	emit_signal("onPlusLv")

func plusXp(val):
	xp += val
	var bl = false
	while xp >= maxXp :
		xp -= maxXp
		plusLv(1)
		bl = true
	emit_signal("onPlusXp",val)
	return bl

func upMaxXp():
	maxXp = 2 * pow(1.5,lv)

func delAllBuff():
	for i in affs:
		if i.tab.findn("buff") :
			delAff(i)
		elif i.get("cdVal") != null:
			i.cdVal = 0
	self.ward = 0
	
func getPow():
	return lv * qlv
