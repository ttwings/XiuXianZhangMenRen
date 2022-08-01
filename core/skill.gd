extends Buff
class_name Skill
signal onCast()

var cd = 5
var cdVal = 0
var ranDec = ""
var castRan = 10
var isActive = true #是否主动技能
 
func castStart():
	if _castIf() :
		_cast()
		cdVal = 0
		emit_signal("onCast")
		masCha.emit_signal("onCastSkill",self)
		return true
	return false

func _cast():
	pass
	
func _castIf():
	if mas.isNormAnim() && cdVal >= cd && isActive:
		return true
	return false
	
func _selIf(cha):
	return true
#按比率造成伤害
func hurtPer(cha,per):
	hurt(cha,mas.atk * per)
#造成伤害
func hurt(cha,val):
	mas.hurt(cha,val,HURTTYPE.SKILL,self)

func _process(delta):
	._process(delta)
	if isActive :
		cdVal += mas.cdSpd * delta
