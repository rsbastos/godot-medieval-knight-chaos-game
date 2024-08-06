extends Node


@export var mob_spawner: MobSpawner
@export var initial_spawn_rate: float = 60.0
@export var spaw_rate_per_minute: float = 30.0
@export var wave_duration: float = 20.0
@export var break_intensity: float = 0.5

var time: float = 0.0


func _process(delta: float) -> void:
	# Se gameover ignorar processo
	if GameManager.is_game_over: return
	
	# Incrementar temporizador
	time += delta
	
	# Dificuldade linear
	var spaw_rate = initial_spawn_rate + spaw_rate_per_minute * (time / 60.0)
	
	# Sistema de ondas
	var sin_wave = sin((time * TAU) / wave_duration)
	var wave_factor = remap(sin_wave, -1.0, 1.0, break_intensity, 1)
	spaw_rate *=  wave_factor
	
	# Aplicar dificuldade
	mob_spawner.mobs_per_minute = spaw_rate
	
	
