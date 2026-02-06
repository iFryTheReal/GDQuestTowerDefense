extends Node2D

@onready var _player_hurtbox: Area2D = %PlayerHurtbox

func _ready() -> void:
	_player_hurtbox.area_entered.connect(
		func(_other_area: Area2D) -> void:
			PlayerUI.player_health -= 1
	)
	
	PlayerUI.health_depleted.connect(
		func() -> void:
			get_tree().paused = true
			PlayerUI.game_over.visible = true
	)
