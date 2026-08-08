class_name BreakableInteractable
extends Interactable

## Can be picked up and breaks on contact with objects named break_on_name
## 
## Can be picked up and dropped inherited from Interactable 
## Breaks on contact with objects named break_on_name

@export var break_on_name: String = ""

var broken: bool = false;

func _ready() -> void:
	if break_on_name == "":
		push_error("%s's break_on_name is empty" % name)
	
	super()

func _on_body_entered(body: Node) -> void:
	# If the body is named break_on_name
	print(linear_velocity.length())
	if broken == false and is_held == false and body.name.match(break_on_name):
		_break_open()

func _on_zone_entered(area: Area2D) -> void: # No functionality
	pass

# Controls the breaking open animation
func _break_open():
	print("%s broke!" % name)
	broken = true
	set_deferred("freeze", true)
	$AnimatedSprite2D.play("Cracked")
	
