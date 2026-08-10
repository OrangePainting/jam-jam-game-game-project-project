extends Control

@onready var visual: Control = %Visual
@onready var sprite = %ClipboardSprite
@onready var bullet_text = %Bullets

var things_completed: Array[int] = []

@export var hover_position_offset := Vector2(350, 0)
@export var hover_rotation_deg: float = 10
@export var tween_duration: float = 0.25
@export var trigger_zone: Rect2 = Rect2(Vector2.ZERO, Vector2(80, 600))
@export var strikethrough_list: Array[Node]

@export var acorn: Node #0
@export var peanut: Node #1
@export var coconut: Node #2
@export var lockbox: Node #3
@export var safe: Node #4
@export var big_statue: Node #5

var clipboard_bullets: Array[String] = [
	"Acorn", "Peanut", "Coconut", "Lockbox", "Vault", "Acorn Statue"
]

var original_position: Vector2
var original_rotation: float
var hover_tween: Tween
var is_shown: bool = false

func _ready() -> void:
	bullet_text.text = ""
	original_position = visual.position
	original_rotation = visual.rotation
	
	connect_eaten(acorn, acorn_eaten, "acorn")
	connect_eaten(peanut, peanut_eaten, "peanut")
	connect_eaten(coconut, coconut_eaten, "coconut")
	connect_eaten(lockbox, lockbox_eaten, "lockbox")
	connect_eaten(safe, safe_eaten, "safe")
	connect_eaten(big_statue, big_statue_eaten, "big_statue")

func connect_eaten(node: Node, signal_func: Callable, label: String) -> void:
	node.interactable_eaten.connect(signal_func)


func _process(delta: float) -> void:
	var t = ""
	for i in range(len(clipboard_bullets)):
		if things_completed.has(i): strikethrough_list[i].show()
		else: strikethrough_list[i].hide()
		t += clipboard_bullets[i] + "\n"
	bullet_text.text = "[ul]" + t + "[/ul]"

	var mouse_pos = get_viewport().get_mouse_position()
	var in_zone = trigger_zone.has_point(mouse_pos)
	if in_zone != is_shown:
		is_shown = in_zone
		if is_shown:
			move_to(original_position + hover_position_offset, deg_to_rad(hover_rotation_deg))
		else:
			move_to(original_position, original_rotation)

func move_to(target_pos: Vector2, target_rot: float) -> void:
	if hover_tween: hover_tween.kill()
	hover_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	hover_tween.tween_property(visual, "position", target_pos, tween_duration)
	hover_tween.tween_property(visual, "rotation", target_rot, tween_duration)

func acorn_eaten() -> void:
	things_completed.append(0)

func peanut_eaten() -> void:
	things_completed.append(1)

func coconut_eaten() -> void:
	things_completed.append(2)

func lockbox_eaten() -> void:
	things_completed.append(3)

func safe_eaten() -> void:
	things_completed.append(4)

func big_statue_eaten() -> void:
	things_completed.append(5)
