extends Node

class_name State

@export var animation: AnimatedSprite2D

signal Transitioned

func enter():
	pass

func exit():
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
