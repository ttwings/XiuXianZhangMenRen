extends Node

const attDs = {
	maxHp={name="最大生命值",isPer=false,rt=80},
	atk={name="攻击",isPer=false,rt=6},
	def={name="防御",isPer=false,rt=6},
	resi={name="抗性",isPer=false,rt=0.05},
	ran={name="射程",isPer=false,rt=1},
	cri={name="暴击率",isPer=true,rt=0.05},
	criR={name="暴击伤害",isPer=true,rt=0.15},
	spd={name="攻速",isPer=true,rt=0.075},
	cdSpd={name="冷却速度",isPer=true,rt=0.075},
	rpHp={name="治疗效果",isPer=true,rt=0.075},
	suck={name="吸血",isPer=true,rt=0.04},
}

const upAtt = ["maxHp","atk","def"]

const colorDs = {
	att="#99dd99",
	lvs = ["#dadada","#88abfe","#e883f6","#ff9a0c","#68d747","#ff4444"]
}
