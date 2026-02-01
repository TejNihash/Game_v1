extends Node

#This is the base class that is used by all the states as a blue print. 

class_name State
var character
var state_machine


func enter(): pass
func update(delta): pass
func exit(): pass

func check_attack():
	var attack_state = false
	#check for J or K attack buttons.
	if Input.is_action_just_pressed("attack1"):
		state_machine.attack_action = "Attack1"
		attack_state = true
	elif Input.is_action_just_pressed("attack2"):
		state_machine.attack_action = "Attack2"
		attack_state = true
	return attack_state
