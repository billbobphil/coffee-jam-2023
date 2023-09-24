extends CanvasLayer


func showDialog(customersServed, totalRevenue):
	self.visible = true;
	get_node("CustomersServedText").text = str(customersServed);
	get_node("TotalRevenueText").text = "$" + str(totalRevenue);
