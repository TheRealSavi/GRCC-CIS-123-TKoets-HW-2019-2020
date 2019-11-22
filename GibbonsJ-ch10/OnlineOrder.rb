class OnlineOrder < Order
  def initialize(args = {})
    super(args) #sends the rest of the args to the super class to initialize the Order
    @shippingMethod = args[:shippingMethod].to_s #sting
    @shippingCost = args[:shippingCost].to_f
  end

  def computeCost()
    return super() + @shippingCost
  end

  def displayOrder()
    display = super() + " Shipping Method : " + @shippingMethod      + "\n " +
                         "Shipping Cost : "   + @shippingCost.to_s   + "\n"
    return display
  end
end
