class Order
  def initialize(args = {})
    @orderNumber = args[:orderNumber].to_i #int
    @customerName = args[:customerName].to_s #string
    @unitsOrdered = args[:unitsOrdered].to_i #int
    @unitPrice = args[:unitPrice].to_f #float
  end

  def computeCost() #returns a float
    return @unitPrice * @unitsOrdered
  end

  def displayOrder() #returns a string
    display = "Customer Name : " + @customerName      + "\n " +
              "Order Number : "  + @orderNumber.to_s  + "\n " +
              "Units Ordered : " + @unitsOrdered.to_s + "\n " +
              "Cose Per Unit : " + @unitPrice .to_s   + "\n " +
              "Total Cost : "    + computeCost().to_s + "\n"
    return display
  end
end
