extends Node

var infoDs = {}
var resDs = {}

func _init():
	connect("tree_entered",self,"loadDir",["res://ex"])
	pass	

func loadDir(dirStr):
	var dir = Directory.new()
	dir.open(dirStr)
	dir.list_dir_begin()
	var dname = dir.get_next()
	while dname != "":
		if dir.current_is_dir() && dname != "core" && dname != "." && dname != "..":
			loadDir(dirStr + "/" + dname)
		elif dname.get_extension() != "":
			var ds = {
				id = dname.get_basename(),
				type = dname.get_extension(),
				dir = dirStr + "/" + dname
			}
			var ty = ds.id.split("_")[0]
			if infoDs.has(ty) == false: infoDs[ty] = {}
			infoDs[ty][ds.id] = ds
		dname = dir.get_next()
	dir.list_dir_end()

#创建指定id的实例
func newBase(id):
	var base = load(infoDs[id.split("_")[0]][id].dir).new()
	base.loadInfo(id)
	return base
func getInfo(id):
	pass
	
var nullPng = preload("res://icon.png")
#创建指定id的资源
func newRes(id):
	if id == "" :
		push_error("id为空的资源")
		return nullPng
	if resDs.has(id) == false:
		if infoDs[id.split("_")[0]].has(id) == false:
			push_error("读取%s 资源错误" % id)
			return nullPng
		var res = load(infoDs[id.split("_")[0]][id].dir)
		resDs[id] = res
		return res
	return resDs[id]
#获取指定类型的数据列表
func getList(tName):
	return infoDs[tName].values()

func getRndPool(ty):
	var pool = RndPool.new()
	for i in data.getList(ty):
		var item = newBase(i.id) 
		if item.lock == 1 : pool.addItem(item)
	return pool
