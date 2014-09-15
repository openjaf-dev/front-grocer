module Dashboard
  module Sales
    class SourcesController <  ApplicationController
      #TODO change by_time to By_staus or similar
      include Dashboard::ControllerHelpers::ByTime
      
      def klass_to_call
        Order  
      end
      
      def compute(value)
        value.count
      end  
    end
  end
end