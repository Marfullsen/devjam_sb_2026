@tool
extends EditorPlugin

const CUSTOM_TYPE_NAME := "VerletRope"
const SCRIPT_PATH := "res://addons/verlet_rope_4_gd/verlet_rope.gd"
const ICON_PATH := "res://addons/verlet_rope_4_gd/icon.svg"

func _enter_tree():
	var script := load(SCRIPT_PATH)
	var texture := load(ICON_PATH)
	add_custom_type(CUSTOM_TYPE_NAME, "MeshInstance3D", script, texture)

func _exit_tree():
	remove_custom_type(CUSTOM_TYPE_NAME)
