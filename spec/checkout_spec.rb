require_relative "../checkout.rb"

describe Checkout do

  context "no promotional rules" do
  	before do
		  @curry_sauce = { product_code: 001, name: 'Curry Sauce', price: 1.95 }
			@pizza = { product_code: 002, name: 'Pizza', price: 5.99 }
			@men_tshirt = { product_code: 003, name: 'Men T-Shirt', price: 25.00 }
			@checkout = Checkout.new([])
  	end

	  it "Total should be 0 if there are no products" do
	    expect( @checkout.total ).to eq(0)
	  end

	  it "Give no discounts on pizza if there are no promotional rules (Curry Sauce, Pizza, Pizza)" do
	  	@checkout.scan(@pizza)
	  	@checkout.scan(@curry_sauce)
	  	@checkout.scan(@pizza)
	  	expect((@checkout.total)).to eq(13.93)
  	end

  	it "Give no discount if the price exceeds 30 (Curry Sauce, Pizza, Men T-Shirt)" do
 			@checkout.scan(@pizza)
 			@checkout.scan(@curry_sauce)
 			@checkout.scan(@men_tshirt)
 			expect((@checkout.total)).to eq(32.94)
    end

    it "Give no discount if the price exceeds 30 and the quantity of pizza is above two (Curry Sauce, Pizza, Men T-Shirt, Pizza)" do
 			@checkout.scan(@pizza)
 			@checkout.scan(@curry_sauce)
 			@checkout.scan(@men_tshirt)
 			@checkout.scan(@pizza)
 			expect((@checkout.total)).to eq(38.93)
    end

  end

  context "With promotional rules" do
	  before do 
	  	# 1. Create new promotional rule by assigning it to a variable
	  	rule_1 = '@counter = 0
	          @counter_discount = 0
	          @counter = @basket.count do |item|
	          	item[:name] == "Pizza"  
						end      
			    	if @counter >= 2
							@basket.each do |item|
		          	item[:price] = 3.99 if item[:name] == "Pizza"
		          	@counter_discount += item[:price]
		          	@total = @counter_discount  
		          end 
				    end'
			rule_2 = '@total = @total * 0.9 if @total > 30'
			# 2. Add it to the array so it will be part of the iteration
	  	promotional_rules = [rule_1, rule_2]

	  	@curry_sauce = { product_code: 001, name: 'Curry Sauce', price: 1.95 }
			@pizza = { product_code: 002, name: 'Pizza', price: 5.99 }
			@men_tshirt = { product_code: 003, name: 'Men T-Shirt', price: 25.00 }
			@checkout = Checkout.new(promotional_rules)
	  end
    it "Give discounts on pizza if there are promotional rules (Curry Sauce, Pizza, Pizza)" do
	  	@checkout.scan(@pizza)
	  	@checkout.scan(@curry_sauce)
	  	@checkout.scan(@pizza)
	  	expect((@checkout.total)).to eq(9.93)
		end

		it "Give 10% discount if the price exceeds 30 (Curry Sauce, Pizza, Men T-Shirt)" do
 			@checkout.scan(@pizza)
 			@checkout.scan(@curry_sauce)
 			@checkout.scan(@men_tshirt)
 			expect((@checkout.total)).to eq(29.65)
    end
	  
	  it "Give the correct discounts if the price exceeds 30 and the quantity of pizza is above two (Curry Sauce, Pizza, Men T-Shirt, Pizza)" do
 			@checkout.scan(@pizza)
 			@checkout.scan(@curry_sauce)
 			@checkout.scan(@men_tshirt)
 			@checkout.scan(@pizza)
 			expect((@checkout.total)).to eq(31.44)
    end
	end

end