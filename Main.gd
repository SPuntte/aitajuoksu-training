extends Spatial

# Player movement
var run_speed: float = 8.0
var jump_length: float = 5.5
var jump_height: float = 2.0

var initial_road_count: int = 5
var road_scenes = [
	load("res://Road1.tscn"),
	load("res://Road2.tscn"),
	load("res://Road3.tscn"),
]

# References to nodes
onready var player = $Player
onready var camera_pivot = $CameraPivot


# Called when the node enters the scene tree for the first time.
func _ready():
	# Make every play different
	randomize()
	
	player.setup_jump(jump_length, jump_height, run_speed)
	
	for i in range(initial_road_count):
		var road = make_random_road()
		road.translation.z = -(i + 1) * RoadBase.LENGTH
		add_child(road)


func _physics_process(delta):
	if player.translation.z < -RoadBase.LENGTH:
		# Teleport player back to the origin
		player.translation.z += RoadBase.LENGTH
		
		# Teleport all road pieces backwards
		for child in get_children():
			var road = child as RoadBase
			if road:
				road.translation.z += RoadBase.LENGTH
				# Discard road pieces behind the player
				if road.translation.z > RoadBase.LENGTH:
					road.queue_free()
		
		# Add a new road piece to the front of the player
		var new_road := make_random_road()
		new_road.translation.z = -initial_road_count * RoadBase.LENGTH
		add_child(new_road)
	
	# Attach camera to the ground at player position
	camera_pivot.translation = player.translation
	camera_pivot.translation.y = 0


# Choose and instanciate a random road piece
func make_random_road() -> RoadBase:
	var road_scene = road_scenes[randi() % road_scenes.size()]
	var road = road_scene.instance()
	return road
