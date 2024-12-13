extends Node2D

@export var circle_scn: PackedScene
@export var cross_scn:PackedScene
 
var animation_complete = false 
var moves:int
var player : int 
var player_panel_pos:Vector2i
var grid_data :Array
var grid_pos: Vector2i
var board_size_x : int
var board_size_y: int
var cell_size:int
var r_sum: int
var c_sum:int
var d1_sum:int
var d2_sum: int
func _ready():
	board_size_x = $Gameplay.texture.get_width()
	print (board_size_x)
	board_size_y = $Gameplay.texture.get_height()
	print (board_size_y)
	cell_size = board_size_x/3
	player_panel_pos = $UI/Turn.get_position()
	print(player_panel_pos)
	game()
	get_tree().paused = false
	$UI/panelcross.hide()
	$UI/panelcir.show()
	
func _process(_delta):
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index ==MOUSE_BUTTON_LEFT and event.pressed:
			print(event.position)
			if event.position.x <board_size_x and event.position.y < board_size_y :
				#convert mouse to grid
				grid_pos = Vector2i(event.position/cell_size)
				print(grid_pos)
				if grid_data [grid_pos.x][grid_pos.y] == 0:
					moves+=1
					grid_data [grid_pos.x][grid_pos.y] = player
					var marker_pos = (grid_pos*cell_size)+ Vector2i(cell_size/2,cell_size/2)-Vector2i(20,2)
					marker(player,marker_pos)
					player*=-1
					await get_tree().create_timer(2.27).timeout
					if check_win()==1:
						$GameOver.get_node("MarginContainer/VBoxContainer/Label").text = "Player 1 Wins!"
						$GameOver.show()
						get_tree().paused = true
						$UI/panelcross.hide()
						$UI/panelcir.hide()
					elif check_win()==-1:
						$GameOver.get_node("MarginContainer/VBoxContainer/Label").text = "Player 2 Wins!"
						$GameOver.show()
						get_tree().paused = true
						$UI/panelcross.hide()
						$UI/panelcir.hide()
					elif moves==9:
						$GameOver.get_node("MarginContainer/VBoxContainer/Label").text = "Its a Draw!"
						$GameOver.show()
						get_tree().paused = true
						$UI/panelcross.hide()
						$UI/panelcir.hide()
					print(grid_data)

func game():
	$GameOver.hide()
	player = 1
	moves = 0
	grid_data =[
			[0,0,0]
			,[0,0,0]
			,[0,0,0]
			]
	marker(player,player_panel_pos + Vector2i(cell_size/2, cell_size/2))
	
func marker(player,position):
	#create marker as a child
	if player==1:
		var circle = circle_scn.instantiate()
		circle.position =position
		circle.play()
		circle.scale=Vector2(0.06,0.06)
		add_child(circle)
		$UI/panelcross.show()
		$UI/panelcir.hide()
	else:
		var cross = cross_scn.instantiate()
		cross.position = position
		cross.play()
		cross.scale = Vector2(0.07,0.07)
		add_child(cross)
		$UI/panelcross.hide()
		$UI/panelcir.show()
func check_win():
	for i in len(grid_data):
		r_sum = grid_data[i][0] + grid_data[i][1]+grid_data[i][2]
		c_sum = grid_data[0][i] + grid_data[1][i]+grid_data[2][i]
		d1_sum = grid_data[0][0]+grid_data[1][1]+grid_data[2][2]
		d2_sum = grid_data[2][0]+grid_data[1][1]+grid_data[0][2]
		if r_sum ==3 or c_sum==3 or d1_sum ==3 or d2_sum ==3:
			return 1
		elif r_sum ==-3 or c_sum==-3 or d1_sum==-3 or d2_sum==-3:
			return -1
