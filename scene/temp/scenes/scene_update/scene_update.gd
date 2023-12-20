extends CanvasLayer

@onready var attr_item_choose = $attr_item_choose
@onready var attr_item_template = $attr_item_choose/attr_item_template

@onready var attr_list  = $attr/MarginContainer/ScrollContainer/attr_list
@onready var attr_template = $attr/MarginContainer/ScrollContainer/attr_list/attr_template

@onready var refresh_btn = $refresh
@onready var upgrade_btn = $upgrade
@onready var continue_btn = $continue

const ATTR_GROUP = {
	"attack":{
		"name": "攻击力",
		"type1": {
			"name": "基础伤害叠加",
			"img": "basic_hurt"
		},
		"type2": {
			"name": "基础伤害倍数",
			"img": "basic_hurt"
		},
	},
	"speed":{
		"name": "速度",
		"type1": {
			"name": "移动速度",
			"img": "speed"
		}
	},
	"hp":{
		"name": "血量",
		"type1": {
			"name": "最大血量",
			"img": "max_hp"
		}
	},
	"get_add":{
		"name": "获取叠加",
		"type1": {
			"name": "金币获取叠加",
			"img": "gold_get"
		},
		"type2": {
			"name": "经验获取叠加",
			"img": "exp_get"
		},
	},
}

const attr_data = {
	"basic_hurt": {
		"group": ATTR_GROUP.attack,
		"type": "type1",
		"range": "1-5"
	},
	"basic_multiple": {
		"group": ATTR_GROUP.attack,
		"type": "type2",
		"range": "2-4"
	},
	"speed": {
		"group": ATTR_GROUP.speed,
		"type": "type1",
		"range": "50-200"
	},
	"max_hp": {
		"group": ATTR_GROUP.hp,
		"type": "type1",
		"range": "1-10"
	},
	"gold_get": {
		"group": ATTR_GROUP.get_add,
		"type": "type1",
		"range": "1-5"
	},
	"exp_get": {
		"group": ATTR_GROUP.get_add,
		"type": "type2",
		"range": "1-5"
	},
}

# Called when the node enters the scene tree for the first time.
func _ready():
	# todo 待优化
	attr_template.hide()
	attr_item_template.hide()
	init()
	pass # Replace with function body.

# 初始化
func init():
	# 加载属性选择
	gen_attr_choose()  
	# 加载角色属性
	load_player_attr()
	pass
	
# 加载属性选择
func gen_attr_choose():
	for item in attr_item_choose.get_children():
		if item.is_visible():
			attr_item_choose.remove_child(item)
			item.queue_free()
	for item in range(4):
		var attr_item = attr_item_template.duplicate()
		attr_item.show()
		# 获取一个随机的属性选项
		var keys = attr_data.keys()
		var num = randi_range(0, keys.size()-1)
		var attr_choosen_data = attr_data[keys[num]]
		attr_item.get_node("MarginContainer/HBoxContainer/TextureRect").texture = load("res://scene/temp/scenes/scene_update/assets/"+ attr_choosen_data.group[attr_choosen_data.type] +".png")
		
		attr_item_choose.add_child(attr_item)
	pass

# 加载角色属性
func load_player_attr():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
