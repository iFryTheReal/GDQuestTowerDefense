class_name MobSpawner extends Node2D

@export var mob_packed_scene: PackedScene = preload("uid://bdtknw27u8ldw")
@export var mobs_count: int = 10
@export var spawn_interval: float = 1.0
@export var waves_interval: float = 2.0
@export var waves: Array[Dictionary] = [
	{"mobs_count": 2, "spawn_interval": 1.0},
	{"mobs_count": 5, "spawn_interval": 0.6},
]

@onready var _path_2d: Path2D = %Path2D
@onready var _remaining_mobs: int = mobs_count

var _spawn_timer: Timer = Timer.new()
var _waves_timer: Timer = Timer.new()
var current_wave: int = 0

func _ready() -> void:
	add_child(_spawn_timer)
	_spawn_timer.timeout.connect(spawn_mob)
	
	add_child(_waves_timer)
	_waves_timer.wait_time = waves_interval
	_waves_timer.one_shot = true
	_waves_timer.timeout.connect(load_wave)
	
	load_wave()

	
func spawn_mob() -> void:
	var mob_path: MobPathFollow = MobPathFollow.new()
	_path_2d.add_child(mob_path)
	
	var mob: Mob = mob_packed_scene.instantiate()
	mob_path.add_child(mob)
	mob_path.mob = mob
	
	_remaining_mobs -= 1
	if _remaining_mobs <= 0:
		_spawn_timer.stop()
		if current_wave < waves.size() -1:
			current_wave += 1
			_waves_timer.start()
			

func load_wave() -> void:
	_remaining_mobs = waves[current_wave].mobs_count
	_spawn_timer.wait_time = waves[current_wave].spawn_interval
	_spawn_timer.start()
