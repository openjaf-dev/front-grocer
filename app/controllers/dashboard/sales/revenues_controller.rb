module Dashboard
  module Sales
    class RevenuesController < BaseController
      before_action :set_time

      include Dashboard::ControllerHelpers::ByTime
      include Dashboard::ControllerHelpers::ByAmount


      def klass_to_call
        Order  
      end

      def index
        @main_set = {}

        @data.each do |o|
          @main_set[o.placed_on.to_time.to_s] = o.totals.total if o.totals
        end

        if @compare_data
          @compare_set = {}

          first_data = @data.sort{ |a,b| a.placed_on <=> b.placed_on }.first
          first_compare_data = @compare_data.sort{ |a,b| a.placed_on <=> b.placed_on }.first
          diff = first_data.placed_on.to_time - first_compare_data.placed_on.to_time

          @compare_data.each do |o|
            @compare_set[ (o.placed_on.to_time + diff).to_s ] = o.totals.total if o.totals
          end
        end

        set_data
      end

      def compute(orders)
         orders.sum { |o| o.totals.nil? ? 0 : o.totals.total }.round(2)
      end

      def compute_amount(orders)
        orders.count
      end

      def by_sources
        @amount_data = Source.all
        amount_set_data_by(:cc_type)
      end

    end
  end
end