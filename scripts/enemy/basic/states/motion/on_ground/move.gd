extends "on_ground.gd"

const SPEED = 50

func enter():
    speed = 0.0

func update(delta):
    print(owner.target)
    var velocity = owner.global_position.direction_to(owner.target.global_position)
    owner.velocity = velocity * SPEED * delta
    owner.move_and_slide()