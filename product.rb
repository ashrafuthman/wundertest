class Checkout

  def initialize(promotional_rules)
    @basket = []
    @total = 0
  	@counter = 0
  	@promotional_rules = promotional_rules
  	@counter_discount = 0
  end

  def scan(item)
  	@basket << item
  end

  def total
  	@basket.each do |item|
      @total += item[:price]
    end
 
  	@promotional_rules.each do |rule|
  		eval(rule)
  	end	
    
    @total.ceil(2)  
  end
end
    
curry_sauce = { product_code: 001, name: 'Curry Sauce', price: 1.95 }
pizza = { product_code: 002, name: 'Pizza', price: 5.99 }
men_tshirt = { product_code: 003, name: 'Men T-Shirt', price: 25.00 }

rule_1 = '@counter = @basket.count do |item|
          	item[:name] == "Pizza"  
					end      
		    	if @counter >= 2
						@basket.each do |item|
	          	item[:price] = 3.99 if item[:name] == "Pizza"
	          	@counter_discount += item[:price]
	          	@total = @counter_discount  
	          end 
			    end
    '
rule_2 = '@total = @total * 0.9 if @total > 30'
					
promotional_rules = [rule_1, rule_2]

co = Checkout.new(promotional_rules)
co.scan(pizza)
co.scan(curry_sauce)
co.scan(pizza)
co.scan(men_tshirt)
p price = co.total
		    		
				
      		
  









