extends Spatial

# Player movement
var run_speed: float = 8.0
var jump_length: float = 5.5
var jump_height: float = 2.0

# References to nodes
onready var player = $Player
onready var camera_pivot = $CameraPivot


# Called when the node enters the scene tree for the first time.
func _ready():
	player.setup_jump(jump_length, jump_height, run_speed)


func _process(delta):
	# Attach camera to the ground at player position
	camera_pivot.translation = player.translation
	camera_pivot.translation.y = 0
