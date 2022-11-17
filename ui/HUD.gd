class_name HUD
extends Control

func set_score(score):
	$Label.text = "Score: %d" % score
