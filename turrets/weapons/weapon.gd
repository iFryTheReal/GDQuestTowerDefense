@icon("res://icons/icon_weapon.svg")
class_name Weapon extends Sprite2D

@export var mob_detection_range: float = 400.0
@export var attack_rate: float = 1.0

var _area_2d: Area2D = _create_area_2d()

@onready var _collision_shape_2d: CollisionShape2D = _create_collision_shape_2d()
@onready var _timer: Timer = _create_timer()

func _ready() -> void:
	z_index = 10
	
	add_child(_area_2d)
	_area_2d.add_child(_collision_shape_2d)
	add_child(_timer)
	_timer.start()
	_timer.timeout.connect(_attack)

func _create_area_2d() -> Area2D:
	var area: Area2D = Area2D.new()
	area.monitoring = true
	area.monitorable = false
	return area

func _create_collision_shape_2d() -> CollisionShape2D:
	var collision_shape: CollisionShape2D = CollisionShape2D.new()
	collision_shape.shape = CircleShape2D.new() 
	collision_shape.shape.radius = mob_detection_range
	return collision_shape

func _create_timer() -> Timer:
	var timer: Timer = Timer.new()
	timer.wait_time = 1.0 / attack_rate
	return timer

func _attack() -> void:
	return
