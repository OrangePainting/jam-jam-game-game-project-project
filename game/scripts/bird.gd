extends CharacterBody2D

@export var speed: float = 200.0
@export var gravity: float = 900.0
@export var flap: float = -800.0 #upward force for flapping
@export var terminal_velocity: float = 400.0

@export var main: Node2D

var interactables : Array[Interactable] = []

signal interact

func _physics_process(delta: float) -> void:
	# move left/right
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	
	# Add the gravity.
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, terminal_velocity)
	
	# flap
	if Input.is_action_just_pressed("flap"):
		velocity.y = flap
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"): # E key
		find_interactable()
		interact.emit() # later may add a paramter for what the object is


func find_interactable() -> Interactable:
	if len(interactables) == 0: return null
	
	return interactables[-1]


func _on_interaction_detector_body_entered(body: Node2D) -> void:
	if body is Interactable:
		if body not in interactables:
			interactables.append(body)
			print("object added")


func _on_interaction_detector_body_exited(body: Node2D) -> void:
	if body is Interactable:
		if body in interactables:
			interactables.erase(body)
			print("object removed")
