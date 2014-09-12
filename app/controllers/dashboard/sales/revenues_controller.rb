module Dashboard
  module Sales
    class RevenuesController < BaseController

      include Dashboard::ControllerHelpers::ByTime
      include Dashboard::ControllerHelpers::ByAmount

      def klass_to_call
        Order  
      end

      def compute(orders)
         orders.sum { |o| o.totals.nil? ? 0 : o.totals.total }.round(2)
         #.sum{|o| o.totals.total
      end

      def compute_amount(orders)
        orders.count
      end

      def by_sources
        @amount_data = Source.all
        @amount_data_table = @amount_data.clone
        amount_set_data_by(:cc_type)
        @amount_data_table = @amount_data_table
      end

    end
  end
end