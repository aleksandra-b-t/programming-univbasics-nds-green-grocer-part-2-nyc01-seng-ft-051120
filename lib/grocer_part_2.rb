require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |coupon|
  item_info = find_item_by_name_in_collection(coupon[:item], cart)
   item_w_coupon = find_item_by_name_in_collection(coupon[:item]+" W/COUPON", cart)
  if item_w_coupon and item_info[:count] >= coupon[:num]
	    item_w_coupon[:count] += coupon[:num]
	    item_info[:count] -= coupon[:num]
	  elsif item_info and item_info[:count] >= coupon[:num]
      cart << {
        :item => coupon[:item] + " W/COUPON",
        :price => (coupon[:cost]/coupon[:num]).round(2),
        :clearance => item_info[:clearance],
        :count => coupon[:num]
      }
      item_info[:count] -= coupon[:num]
    end 
  end 
  #cart.delete_if{|item_info| item_info[:count] <= 0}
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item_info|
    if item_info[:clearance]
  	      item_info[:price] *= 0.8
    end 
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consol_cart = consolidate_cart(cart)
  cart_w_coupons_applied = apply_coupons(consol_cart, coupons)
  final_cart = apply_clearance(cart_w_coupons_applied)

  total = 0
  final_cart.each do |item_info|
    total += item_info[:price]*item_info[:count]
  end #each

  if total > 100
    total *= 0.9
  end #if
  return total.round(2)
end
