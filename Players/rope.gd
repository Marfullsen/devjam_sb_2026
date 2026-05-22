extends Node3D

@onready var rope_mesh = $RopeMesh

func _process(delta):

	var players = get_tree().get_nodes_in_group("players")

	if players.size() < 2:
		return

	var p1 = players[0].global_position
	var p2 = players[1].global_position

	global_position = (p1 + p2) / 2.0

	var distance = p1.distance_to(p2)

	look_at(p2)

	rope_mesh.scale = Vector3(
		0.2,
		distance * 0.5,
		0.2
	)
	rope_mesh.rotation_degrees.x = 90
