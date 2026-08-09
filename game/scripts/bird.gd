class_name Bird extends CharacterBody2D

@export var speed: float = 200.0
@export var gravity: float = 900.0
@export var flap: float = -800.0 #upward force for flapping
@export var terminal_velocity: float = 400.0
var push_force = 40.0 # This represents the player's inertia.

@export var main: Node2D
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var interaction_detector: Area2D = %InteractionDetector

var interactables : Array[Interactable] = []
var held_interactable: Interactable = null

signal interacted(object: Interactable)

func _ready() -> void:
	sprite.play()

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

	
	if velocity.x > 0: # Face right
		sprite.flip_h = true
		interaction_detector.get_child(0).position.x = abs(interaction_detector.get_child(0).position.x)
		
	elif velocity.x < 0: # Face left
		sprite.flip_h = false
		interaction_detector.get_child(0).position.x = -abs(interaction_detector.get_child(0).position.x)
	
	move_and_slide()
	
	# after calling move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is Interactable:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"): # E key
		interact()


func interact() -> void:
	var interactable := find_interactable()
	if held_interactable:
		# If we can place it down, try to place it down
		if interactable is PlaceInteractable:
			var placed = interactable.interact_with_held(self, held_interactable)
		
		# Always drop the item no matter what.
		# If it were placed somewhere, something will happen to it.
		drop_held_item()
	else:
		# Not interactable. Nothing to do
		if not interactable:
			return
		
		# Try to pick it up otherwise interact
		if interactable.can_pick_up:
			interactable.pick_up(self)
			held_interactable = interactable
		else:
			interactable.interact(self)
		interacted.emit(interactable)

func drop_held_item() -> void:
	held_interactable.drop()
	held_interactable = null
	interacted.emit(null) # null signal means object is dropped

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
