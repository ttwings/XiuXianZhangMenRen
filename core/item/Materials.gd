extends Item

class_name Materials

# 当材料改变时，触发此事件
signal material_changed(args)

# 金属 植物 液体 气体 土壤 
# 金    木  水  火  土
# Metal plant liquid gas soil
export(int,FLAGS, "Gas", "Soil","Metal","Liquid","Plant") var category

var gas := 0
var soil := 0
var metal := 0
var liquid := 0
var plant := 0

var max_gas := 0
var max_soil := 0
var max_metal := 0
var max_liquid := 0
var max_plant := 0



func Materials(gas :int, soil :int, metal :int, liquid :int, plant :int):
    self.gas = gas
    self.soil = soil
    self.metal = metal
    self.liquid = liquid
    self.plant = plant

## 这里需要复杂的元素转换
## 先后顺序比较重要
## 计算相生、相克、相同
## 相生 gas 生 soil、soil 生 metal、metal 生 liquid、liquid 生 plant、plant 生 gas
## 相克 gas 克 metal、metal 克 plant、plant 克 soil、soil 克 liquid、liquid 克 gas

func add(gas :int, soil :int, metal :int, liquid :int, plant :int):
    # 首先计算相生
    self.max_soil += gas
    self.max_metal += soil
    self.max_liquid += metal
    self.max_plant += liquid
    self.max_gas += plant
    # 然后计算相克
    self.max_metal -= gas
    self.max_plant -= metal
    self.max_soil -= plant
    self.max_liquid -= soil
    self.max_gas -= liquid
    # 再来计算相加
    self.gas += gas
    self.soil += soil
    self.metal += metal
    self.liquid += liquid
    self.plant += plant
    # 最后限定范围
    self.gas = clamp(self.gas,0,5)
    self.soil = clamp(self.soil,0,5)
    self.metal = clamp(self.metal,0,5)
    self.liquid = clamp(self.liquid,0,5)
    self.plant = clamp(self.plant,0,5)  


func add(material:Materials):
    # 首先计算相生
    self.max_soil += material.gas
    self.max_metal += material.soil
    self.max_liquid += material.metal
    self.max_plant += material.liquid
    self.max_gas += material.plant
    # 然后计算相克
    self.max_metal -= material.gas
    self.max_plant -= material.metal
    self.max_soil -= material.plant
    self.max_liquid -= material.soil
    self.max_gas -= material.liquid
    # 再来计算相加
    self.gas += material.gas
    self.soil += material.soil
    self.metal += material.metal
    self.liquid += material.liquid
    self.plant += material.plant
    # 最后限定范围
    self.gas = clamp(self.gas,0,5)
    self.soil = clamp(self.soil,0,5)
    self.metal = clamp(self.metal,0,5)
    self.liquid = clamp(self.liquid,0,5)
    self.plant = clamp(self.plant,0,5)  

func get_material_level():
    var level = 0
    var num = 0
    if gas > 0 :
        num += 1
    if soil > 0 :
        num += 1
    if metal > 0 :
        num += 1
    if liquid > 0 :
        num += 1
    if plant > 0 :
        num += 1
    level = sqrt((gas*gas + soil*soil + metal*metal + liquid*liquid + plant*plant) / num)
    return level