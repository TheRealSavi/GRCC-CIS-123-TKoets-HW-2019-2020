require_relative 'Order.rb'
require_relative 'OnlineOrder.rb'

#Order 23403 for Jim Smith, who orders 5 products at $25.00 each.
order1 = Order.new(
  orderNumber: 23403,
  customerName: 'Jim Smith',
  unitsOrdered: 5,
  unitPrice: 25.00
)

#Online order 34823 for Louise Muller, who orders 8 products at $25.00 each, shipped Priority Mail for $25.00.
order2 = OnlineOrder.new(
  orderNumber: 34823,
  customerName: 'Louise Muller',
  unitsOrdered: 8,
  unitPrice: 25.00,
  shippingMethod: 'Priority Mail',
  shippingCost: 25.00
)

print(order1.displayOrder())

puts ''

print(order2.displayOrder())
