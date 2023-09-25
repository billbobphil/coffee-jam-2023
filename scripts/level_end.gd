extends CanvasLayer


func showDialog(customersServed, totalRevenue):
	self.visible = true;
	get_node("CustomersServedText").text = str(customersServed);
	get_node("TotalRevenueText").text = "$" + str(totalRevenue);



func _on_play_again_button_pressed():
	get_tree().reload_current_scene();


func _on_menu_button_pressed():
	#TODO: take player to main menu
	pass
