extends Control

signal health_depleted

@onready var _h_box_container: HBoxContainer = %HBoxContainer

var player_health: int = 5 : set = set_health

func _ready() -> void:
	set_health(player_health)

func set_health(new_health: int) -> void: 
	player_health = clampi(new_health, 0, 5)
	for child in _h_box_container.get_children():
		child.visible = player_health > child.get_index()
	
	if player_health <= 0:
		health_depleted.emit()
