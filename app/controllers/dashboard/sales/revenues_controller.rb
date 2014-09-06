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
        check_filters

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

      private

      def check_filters
        by_years = @data.group_by{|r| r.placed_on.year}

        case params[:filter_type]
          when 'weeks' then
            filter_by_weeks
          when 'months' then
            filter_by_months
          when 'years' then
            filter_by_years
          else
            return
        end
      end

      def filter_by_weeks
        by_years = @data.group_by{|r| r.placed_on.year}
        @data = []
        by_years.each do |y|
          by_month = y[1].group_by{|r| r.placed_on.month}
          by_month.each do |m|
            by_week = m[1].group_by{|r| r.placed_on.to_date.cweek}
            by_week.each do |w|
              monday = w[1].first.placed_on.monday
              o = Order.new
              o.placed_on = monday
              o.totals = OrderTotal.new
              o.totals.total = w[1].sum{ |e| e.totals.total}.round(2)
              @data << o
            end
          end
        end
      end

      def filter_by_months
        by_years = @data.group_by{|r| r.placed_on.year}
        @data = []
        by_years.each do |y|
          by_month = y[1].group_by{|r| r.placed_on.month}
          by_month.each do |m|
            o = Order.new
            o.placed_on = Date.new(y[0], m[0], 1)
            o.totals = OrderTotal.new
            o.totals.total = m[1].sum{ |e| e.totals.total}
            @data << o
          end
        end
      end

      def filter_by_years
        by_years = @data.group_by{|r| r.placed_on.year}
        @data = []
        by_years.each do |x|
          o = Order.new
          o.placed_on = Date.new(x[0])
          o.totals = OrderTotal.new
          o.totals.total = x[1].sum{ |e| e.totals.total}
          @data << o
        end
      end

    end
  end
end