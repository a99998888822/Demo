extends Node2D

@onready var weaponAni = $AnimatedSprite2D
@onready var shoot_position = $shoot_position
@onready var timer = $Timer
@onready var bullet = preload("res://scene/bullet/bullet.tscn")

var selected_level = "level_1"
var bullet_shoot_time = 0.5
var bullet_speed = 2000
var bullet_hurt = 1
var attack_enemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	weaponAni.material.set_shader_parameter("color", Color(selected_level))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attack_enemies.size() != 0:
		self.look_at(attack_enemies[0].position)
	else:
		rotation_degrees = 0
	pass
	
# 定时器结束
func _on_timer_timeout():
	if attack_enemies.size() != 0:
		var now_bullet = bullet.instantiate()
		now_bullet.speed = bullet_speed
		now_bullet.hurt = bullet_hurt
		now_bullet.position = shoot_position.global_position
		now_bullet.dir = (attack_enemies[0].global_position - now_bullet.position).normalized()
		get_tree().root.add_child(now_bullet)
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy") and !attack_enemies.has(body):
		attack_enemies.append(body)
	sort_enemy()
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.is_in_group("enemy") and attack_enemies.has(body):
		attack_enemies.remove_at(attack_enemies.find(body))
	sort_enemy()
	pass # Replace with function body.

# 给敌人排序
func sort_enemy():
	if attack_enemies.size() != 0:
		attack_enemies.sort_custom(
			func(x, y):
				return x.global_position.distance_to(self.global_position) < y.global_position.distance_to(self.global_position)
		)
	pass
