@icon("res://icons/icon_mob.svg")
class_name Mob extends Area2D

@export var health: int = 100 : set = set_health

@onready var _health_bar: ProgressBar = %HealthBar

var _tween: Tween = null

func _ready() -> void:
	_health_bar.max_value = health
	set_health(health)

func set_health(new_health: int) -> void:
	health = maxi(0, new_health)
	
	if _health_bar != null:
		if _tween != null:
			_tween.kill()
		_tween = create_tween()
		_tween.tween_property(_health_bar, "value", health, 0.2)
		
	if health <= 0:
		_die()

func _die() -> void:
	queue_free()

func take_damage(amount: int) -> void:
	health -= amount
	var damage_indicator: Node2D = preload("uid://bq0ta0wigo4jt").instantiate()
	get_tree().current_scene.add_child(damage_indicator)
	damage_indicator.global_position = global_position
	damage_indicator.display_amount(amount)
