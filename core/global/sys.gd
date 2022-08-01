extends Node
class_name Sys

var main :Main 
var game :Game
var home :Home
var rogue :Rogue
var player :Player

func _ready():
	OS.window_size *= 2
	OS.center_window()

#百分比随机5
func rndPer(var val):
	if randf() <= val :
		return true
	return false
#范围随机	
func rndRan(mmin,mmax):
	var d = mmax - mmin + 1
	if d == 0 :return mmin
	return randi()%(d) + mmin
#随机	
func rnd(val):
	return randi()%val
#从列表中随机一个元素
func rndListItem(list):
	if list.size() > 0:
		return list[rnd(list.size())]
	return null

func newMsg(txt):
	var msg = preload("res://tscn/base/msgDlg.tscn").instance()
	main.ui.add_child(msg)
	msg.txt(txt)
	msg.popup()
	
func newDlg(file):
	var dlg = load(file).instance()
	main.ui.add_child(dlg)
	dlg.popup()
	return dlg

func addTip(node,txt):
	sys.main.addTip(node,txt)
