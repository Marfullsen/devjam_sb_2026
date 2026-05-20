extends Control

@onready var stamina_label = $Label

func update_stamina(current, max_value):

	var percent = int((current / max_value) * 100)

	stamina_label.text = str(percent) + "%"
