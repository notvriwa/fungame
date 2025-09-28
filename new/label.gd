extends Label

var pablo: Node

func _ready():
	# Find Pablo in the scene tree
	pablo = get_parent().get_parent().get_node("pablo") # adjust path

func _process(delta):
	if pablo:
		text = "Health: " + str(pablo.health)
