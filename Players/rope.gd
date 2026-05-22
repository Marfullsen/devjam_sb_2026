extends Node3D

@onready var rope_mesh = $RopeMesh


func _process(delta):

	var players = get_tree().get_nodes_in_group("players")

	if players.size() < 2:
		return

	var player1 = players[0]
	var player2 = players[1]

	var p1 = player1.global_position
	var p2 = player2.global_position

	# =====================================================
	# POSICIÓN CENTRAL
	# =====================================================

	global_position = (p1 + p2) / 2.0

	# =====================================================
	# MIRAR HACIA PLAYER 2
	# =====================================================

	look_at(p2, Vector3.UP)

	# =====================================================
	# DISTANCIA
	# =====================================================

	var distance = p1.distance_to(p2)

	# =====================================================
	# ESCALA
	# =====================================================

	rope_mesh.scale = Vector3(
		0.2,
		0.2,
		distance * 0.5
	)

	# =====================================================
	# ROTACIÓN
	# =====================================================

	rope_mesh.rotation_degrees.x = 90
