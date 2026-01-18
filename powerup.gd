extends Area2D

enum AbilityType {DASH, DOUBLE_JUMP, WALL_JUMP}

@export var ability: AbilityType = AbilityType.DASH
@export var pickup_sprite: Texture2D

func _ready():
	if has_node("Sprite2D") and pickup_sprite:
		var sprite = get_node("Sprite2D")
		sprite.texture = pickup_sprite

func _process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.has_method("unlock_ability"):
			var ability_name = AbilityType.keys()[ability].to_lower()
			body.unlock_ability(ability_name)
			queue_free()
			return
