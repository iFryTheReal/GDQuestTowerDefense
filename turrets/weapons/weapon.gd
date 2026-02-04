@icon("res://icons/icon_weapon.svg")
class_name Weapon extends Sprite2D

@export var mob_detection_range: float = 400.0

var _area_2d: Area2D = _create_area_2d()
@onready var _collision_shape_2d: CollisionShape2D = _create_collision_shape_2d()

func _ready() -> void:
	add_child(_area_2d)
	_area_2d.add_child(_collision_shape_2d)

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
