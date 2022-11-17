extends Area

var rotation_speed: float = 300.0 * rand_range(0.8, 1.2)

onready var coin_mesh: MeshInstance = $MeshInstance

func _process(delta):
	coin_mesh.rotation_degrees.y += rotation_speed * delta


func _on_Coin_body_entered(body):
	if body is Player:
		ScoreEvents.award_points(1)
		queue_free()
