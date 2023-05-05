extends ColorRect

@onready var player = get_node("%Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.game_over.connect(_on_Game_Over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Game_Over():
	self.visible = true