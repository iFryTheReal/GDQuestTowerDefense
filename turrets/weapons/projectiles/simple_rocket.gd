extends Area2D

@export var max_distance: float = 1000.0
@export var speed: float = 350.0
@export var damage: float = 20.0

var _traveled_distance: float = 0.0

func _ready() -> void:
	monitorable = false
	
	area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	
	_traveled_distance += speed * delta
	if _traveled_distance > max_distance:
		explode()

func explode() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is Mob:
		area.take_damage(damage)
		explode()
