extends Label

func _process(delta):
	text = "Meat " + str(Game.points) + "/4 collected"
