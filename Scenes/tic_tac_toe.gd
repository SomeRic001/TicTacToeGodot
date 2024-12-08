extends Node2D

var player : int 
var grid_data :Array
var grid_pos: Vector2i
var board_size_x : int
var board_size_y: int
var cell_size:int
func _ready():
	board_size_x = $Gameplay.texture.get_width()
	print (board_size_x)
	board_size_y = $Gameplay.texture.get_height()
	print (board_size_y)
	cell_size = board_size_x/3
	game()
	
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index ==MOUSE_BUTTON_LEFT and event.pressed:
			if event.position.x < board_size_x+100 and event.position.x >= 330 and event.position.y < board_size_y-130 and event.position.y >=100:
				#convert mouse to grid
				grid_pos = Vector2i(event.position/cell_size)
				if grid_data [grid_pos.x-1][grid_pos.y] == 0:
					grid_data [grid_pos.x-1][grid_pos.y] = player
					player+=1
					print(grid_data)

func game():
	player = 1
	grid_data =[
			[0,0,0]
			,[0,0,0]
			,[0,0,0]
			]
	
