extends Node3D

var peer = ENetMultiplayerPeer.new()
@export var player_scene :PackedScene
@export var rope_visual_scene: PackedScene

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(del_player)

func _process(_delta):
	create_local_rope_if_possible()

func create_local_rope_if_possible():
	if has_node("LocalRope"):
		return
	var players := []
	for child in get_children():
		if child is CharacterBody3D:
			players.append(child)
	if players.size() != 2:
		return
	var rope = rope_visual_scene.instantiate()
	rope.name = "LocalRope"
	rope.player_a = players[0]
	rope.player_b = players[1]
	add_child(rope)

func _on_peer_connected(id):
	print("PEER CONNECTED: ", id)
	if multiplayer.is_server():
		add_player(id)

func _player_connected(id):
	add_player(id)
	rpc("_spawn_existing_players")

func _on_host_pressed():
	peer.create_server(1027)
	multiplayer.multiplayer_peer = peer
	add_player(multiplayer.get_unique_id())
	$PantallaInicio.hide()

func add_player(id = 1):
	if has_node(str(id)):
		return
	var player = player_scene.instantiate()
	player.name = str(id)
	add_child(player)
	player.set_multiplayer_authority(id)
	print("PLAYER ADDED: ", id)

func exit_game(id):
	del_player(id)

func _on_join_pressed() -> void:
	peer.create_client("127.0.0.1",1027)
	multiplayer.multiplayer_peer = peer
	$PantallaInicio.hide()
	
func del_player(id):
	rpc("_del_player",id)
	
@rpc("any_peer","call_local")
func _del_player(id):
	get_node(str(id)).queue_free()
