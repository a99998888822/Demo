extends Node2D

@onready var weaponAni = $AnimatedSprite2D
@onready var shoot_position = $shoot_position
@onready var timer = $Timer
@onready var bullet = preload("res://scene/bullet/bullet.tscn")

var selected_level = "level_1"
var bullet_shoot_time = 0.5
var bullet_speed = 2000
var bullet_hurt = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	weaponAni.material.set_shader_parameter("color", Color(selected_level))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# 定时器结束
func _on_timer_timeout():
	var now_bullet = bullet.instantiate()
	now_bullet.speed = bullet_speed
	now_bullet.hurt = bullet_hurt
	now_bullet.position = shoot_position.global_position
	now_bullet.dir = Vector2(1, 0)
	pass # Replace with function body.
