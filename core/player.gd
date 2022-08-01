extends Base
class_name Player
signal onSetGold
signal onSetWood
signal onSetMetal
signal onSetHerbs

var gold = 20000 setget setGold
var wood = 0 setget setWood
var metal = 0 setget setMetal
var herbs = 0 setget setHerbs
var popl = 0
var maxPopl = 7
var weekNum = 0
var team:Team = Team.new()
var items :ItemPck = ItemPck.new()
var maxWeight = 10

var lccs = []
var lcts = []
var chaPool :RndPool
var gemPool :RndPool
var csbPool :RndPool
var materPool :RndPool
var buffPool :RndPool

func setGold(val):
	gold = val
	emit_signal("onSetGold")
func setWood(val):
	wood = val
	emit_signal("onSetWood")
func setMetal(val):
	metal = val
	emit_signal("onSetMetal")
func setHerbs(val):
	herbs = val
	emit_signal("onSetHerbs")

func newWeek():
	weekNum += 1
	for i in team.chas:
		if i.cell.x >= 5 :
			i.plusHp(i.maxHp,i)
	for i in lccs :
		i._newWeek()
	for i in lcts :
		i._newWeek()
		
func addAlterCha(cha):
	var ds = {}
	for i in team.chas :
		if i.cell.x >= 5 :
			ds[i.cell] = i
	for x in range(5,10):
		for y in range(7):
			if ds.has(Vector2(x,y)) == false:
				team.addCha(cha)
				cha.cell = Vector2(x,y)
				return true
	return false
	
func _in():
	._in()
	chaPool = data.getRndPool("c")
	for i in data.getList("lcc"):
		var t = data.newBase(i.id)
		lccs.append(t)
		t.inStart(self)
	for i in data.getList("lct"):
		var t = data.newBase(i.id)
		lcts.append(t)
		t.inStart(self)
	gemPool = data.getRndPool("gem")
	csbPool = data.getRndPool("csb")
	materPool = data.getRndPool("mater")
	buffPool = data.getRndPool("b")

###########################
	for i in data.getList("c"):
		var cha = data.newBase(i.id)
		cha.cell = Vector2(6,0)
		cha.team = self
		cha.inStart(self)
		addAlterCha(cha)
	
	for i in data.getList("csb"):
		var item = data.newBase(i.id)
		items.addItem(item)
		
#########################	
		
	newWeek()
	
func subWood(val):
	if wood >= val :
		self.wood -= val
		return true
	return false
	
func subGold(val):
	if gold >= val :
		self.gold -= val
		return true
	return false
	
func subMetal(val):
	if metal >= val :
		self.metal -= val
		return true
	return false

func subHerbs(val):
	if herbs >= val :
		self.herbs -= val
		return true
	return false

func fileLoad():
	pass

func fileSave():
	pass
