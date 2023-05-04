extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func killItself():
	queue_free()


func _on_health_enemy_lost_all_hp():
	killItself() 


func _on_enemy_enemy_lost_all_hp():
	killItself()  
