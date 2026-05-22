extends Node3D

var player_a: CharacterBody3D
var player_b: CharacterBody3D

@onready var rope_mesh = $RopeMesh

func _physics_process(_delta):

	if !is_instance_valid(player_a):
		queue_free()
		return

	if !is_instance_valid(player_b):
		queue_free()
		return

	update_rope_visual()

func update_rope_visual():

	var start = player_a.global_position
	var end = player_b.global_position

	var distance = start.distance_to(end)

	if distance < 0.01:
		return

	var center = (start + end) * 0.5

	global_position = center

	look_at(end, Vector3.UP)

	rotate_object_local(
		Vector3.RIGHT,
		deg_to_rad(90)
	)

	rope_mesh.scale = Vector3(
		1,
		distance * 0.5,
		1
	)
