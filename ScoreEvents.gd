extends Node

signal score_changed

var score_total: int = 0

func reset():
	score_total = 0

func award_points(score):
	score_total += score
	emit_signal("score_changed")
