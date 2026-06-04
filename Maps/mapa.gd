extends Node3D

var peer = ENetMultiplayerPeer.new()

@export var rope_scene: PackedScene
@export var player_scene: PackedScene

@onready var pantalla_inicio = $PantallaInicio

# MENU PRINCIPAL
@onready var menu_principal = $PantallaInicio/Control/VBoxContainer

# PANEL COOP
@onready var panel_coop = $PantallaInicio/Control/PanelCoop

# PANEL SONIDO
@onready var panel_opciones = $PantallaInicio/Control/PanelOpciones

func _ready() -> void:
	# Ocultar paneles secundarios
	panel_coop.visible = false
	panel_opciones.visible = false
	multiplayer.connected_to_server.connect(_create_rope_if_needed)
	multiplayer.peer_connected.connect(_create_rope_if_needed)

func _create_rope_if_needed():
		var rope = rope_scene.instantiate()
		add_child(rope)

# =====================================================
# MENU PRINCIPAL
# =====================================================

func _on_multijugador_pressed() -> void:

	menu_principal.visible = false
	panel_coop.visible = true


func _on_sonido_pressed() -> void:

	menu_principal.visible = false
	panel_opciones.visible = true


func _on_salir_pressed() -> void:

	get_tree().quit()


# =====================================================
# VOLVER
# =====================================================

func _on_volver_pressed() -> void:

	panel_coop.visible = false
	panel_opciones.visible = false

	menu_principal.visible = true


# =====================================================
# HOST
# =====================================================

func _on_crear_pressed() -> void:

	var error = peer.create_server(1027)

	if error != OK:
		print("Error creando servidor")
		return

	multiplayer.multiplayer_peer = peer

	print("Servidor creado")

	# Cuando entra alguien
	multiplayer.peer_connected.connect(add_player)

	# Crear host
	add_player(multiplayer.get_unique_id())

	pantalla_inicio.hide()


# =====================================================
# JOIN
# =====================================================

func _on_unirse_pressed() -> void:

	var error = peer.create_client("", 1027)

	if error != OK:
		print("Error conectando")
		return

	multiplayer.multiplayer_peer = peer

	print("Conectado al servidor")

	pantalla_inicio.hide()


# =====================================================
# SINGLEPLAYER
# =====================================================

func _on_jugar_pressed() -> void:

	add_player(1)

	pantalla_inicio.hide()


# =====================================================
# SONIDOS
# =====================================================

func _on_sonidos_pressed() -> void:

	# Baja volumen general
	AudioServer.set_bus_volume_db(0, -10)

	print("Volumen bajado")


func _on_musica_pressed() -> void:

	# Silenciar música
	var bus_index = AudioServer.get_bus_index("Music")

	if bus_index != -1:
		AudioServer.set_bus_mute(bus_index, true)

	print("Música muteada")


# =====================================================
# SPAWN PLAYER
# =====================================================

func add_player(id):
	if player_scene == null:
		print("No hay Player Scene asignada")
		return
	var player = player_scene.instantiate()
	player.name = str(id)
	#call_deferred("add_child", player)
	add_child(player)

	# Crear cuerda
	await get_tree().process_frame
	var players = get_tree().get_nodes_in_group("players")
	if players.size() >= 2:
		print("Creando cuerda")
		print("Creando instancia")
		var rope = rope_scene.instantiate()
		#add_child(rope)
		call_deferred("add_child", rope)


# =====================================================
# REMOVE PLAYER
# =====================================================

func exit_game(id):

	del_player(id)


func del_player(id):

	rpc("_del_player", id)


@rpc("any_peer", "call_local")
func _del_player(id):

	if has_node(str(id)):
		get_node(str(id)).queue_free()
