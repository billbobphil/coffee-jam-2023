extends CanvasLayer


func showDialog(customersServed, totalRevenue):
	self.visible = true;
	get_node("CustomersServedText").text = str(customersServed);
	get_node("TotalRevenueText").text = "$" + str(totalRevenue);



func _on_play_again_button_pressed():
	$ButtonClickEffect.play()
	get_tree().reload_current_scene();


func _on_menu_button_pressed():
	$ButtonClickEffect.play()
	get_tree().change_scene_to_file("res://scenes/mainMenu.tscn");


func _on_play_again_button_mouse_entered():
	$ButtonHoverEffect.play();


func _on_menu_button_mouse_entered():
	$ButtonHoverEffect.play();
