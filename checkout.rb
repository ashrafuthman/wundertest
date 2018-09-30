class Checkout

  def initialize(promotional_rules)
    @basket = []
    @total = 0
  	@promotional_rules = promotional_rules
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