extends CanvasLayer

@onready var attr_item_choose = $attr_item_choose
@onready var attr_item_template = $attr_item_choose/attr_item_template

@onready var attr_list  = $attr/MarginContainer/ScrollContainer/attr_list
@onready var attr_template = $attr/MarginContainer/ScrollContainer/attr_list/attr_template

@onready var refresh_btn = $refresh
@onready var upgrade_btn = $upgrade
@onready var continue_btn = $continue

var player = null

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
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.

# 初始化
func init():
	self.show()
	# 加载属性选择
	gen_attr_choose()  
	# 加载角色属性
	load_player_attr()
	pass
	
# 加载属性选择
func gen_attr_choose():
	var keys = attr_data.keys()
	for item in range(4):
		# 获取一个随机的属性选项
		var num = randi_range(0, keys.size()-1)
		var attr_choosen_data = attr_data[keys[num]].group[attr_data[keys[num]].type]
		var range = attr_data[keys[num]].range.split("-")
		var attr_value = randi_range(int(range[0]), int(range[1]))
		# 如果已存在子节点，则修改子节点属性
		print("size is " + str(attr_item_choose.get_children().size()) + "item is "+ str(item))
		var attr_item
		if attr_item_choose.get_children().size() > item:
			attr_item = attr_item_choose.get_child(item)
		else:
			# 如果不存在子节点，则新建
			attr_item = attr_item_template.duplicate()
		# 设置节点树的相关属性
		attr_item.get_node("MarginContainer/HBoxContainer/upgrade_img").texture = load("res://scene/temp/scenes/scene_update/assets/"+ attr_choosen_data.img +".png")
		attr_item.get_node("MarginContainer/HBoxContainer/VBoxContainer/upgrade_name").text = attr_choosen_data.name
		attr_item.get_node("upgrade_value").text = "[color=green]" + str(attr_value) +"[/color] " + attr_choosen_data.name
		attr_item.get_node("upgrade_choosen_btn").pressed.connect(choose_attr.bind({
			"key": keys[num],
			"attr": attr_data[keys[num]],
			"val": attr_value
		}))
		if attr_item_choose.get_children().size() <= item:
			attr_item_choose.add_child(attr_item)
	pass
	
# 绑定按钮点击事件
func choose_attr(attr_info):
	player[attr_info.key] += attr_info.val
	gen_attr_choose()
	pass

# 加载角色属性
func load_player_attr():
	var prop_list = player.get_script().get_base_script().get_script_property_list()
	attr_template.hide()
	for prop in prop_list:
		if prop.name.rfind(".gd") == -1:
			var attr_item = attr_template.duplicate()
			attr_item.get_node("attr_name").text = str(prop.name)
			attr_item.get_node("attr_value").text = str(player[prop.name])
			attr_list.add_child(attr_item)
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
