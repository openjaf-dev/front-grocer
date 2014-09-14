module Dashboard
  module Sales
    class ItemsController < ApplicationController
      include Dashboard::ControllerHelpers::ByTime
      
      def klass_to_call
        Order  
      end
      
      def compute(orders)
        orders.sum(&:items)
      end  
    end
  end  
end