extends Node

#This is the base class that is used by all the states as a blue print. 

class_name State
var character
var state_machine:Node


func enter(): pass
func update(delta): pass
func exit(): pass
