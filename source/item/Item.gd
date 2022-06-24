tool
extends Resource

class_name Item

export(String) var alias
export(String) var describe
export(int,0,9) var lv
export(int,0,999999) var price

## 五行属性
## 金属 植物 液体 气体 土壤 
## 金    木  水  火  土
## Metal plant liquid gas soil

export(int,0,9) var metal
export(int,0,9) var plant
export(int,0,9) var liquid
export(int,0,9) var gas
export(int,0,9) var soil

export()


