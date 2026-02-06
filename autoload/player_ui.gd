extends Control

signal health_depleted

@onready var _h_box_container: HBoxContainer = %HBoxContainer
@onready var _retry: Button = %Retry
@onready var _quit: Button = %Quit
@onready var game_over: ColorRect = %GameOver

var player_health: int = 5 : set = set_health

func _ready() -> void:
	set_health(player_health)
	
	_retry.pressed.connect(func () -> void:
		print_debug("retry")
		get_tree().paused = false
		game_over.visible = false
		get_tree().reload_current_scene.call_deferred()
		player_health = 5
	)
	
	_quit.pressed.connect(func() -> void:
		print_debug("quit")
		get_tree().quit()
	)
	
func set_health(new_health: int) -> void: 
	player_health = clampi(new_health, 0, 5)
	for child in _h_box_container.get_children():
		child.visible = player_health > child.get_index()
	
	if player_health <= 0:
		health_depleted.emit()
