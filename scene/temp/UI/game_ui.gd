extends ProgressBar

@onready var hp_value_bar = $%hp_value_bar
@onready var exp_value_bar = $%exp_value_bar
@onready var gold = $%gold

var player;


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hp_value_bar.max_value = player.max_hp
	hp_value_bar.value = player.now_hp
	hp_value_bar.get_node("Label").text = str(player.now_hp) + '/' + str(player.max_hp)
	
	exp_value_bar.max_value = player.max_exp
	exp_value_bar.value = player.now_exp
	exp_value_bar.get_node("Label").text = 'Lv.' + str(player.level)
	
	gold.text = str(player.gold)
	pass
