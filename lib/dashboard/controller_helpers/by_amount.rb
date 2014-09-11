module Dashboard
  module ControllerHelpers
    module ByAmount
      extend ActiveSupport::Concern
      
      included do
        before_action :amount_set_time
        before_action :amount_get_data
        before_action :amount_get_compare_data
      end  
      
      def klass_to_call
        # denifine where will be included
      end

      def by_status
        @data_table = @amount_data.clone
        @data_table = @amount_compare_data.clone unless @amount_compare_data.count == 0
        amount_set_data_by(:status)
        end

      def by_sources
        @data_table = @amount_data.clone
        @data_table = @amount_compare_data.clone unless @amount_compare_data.count == 0
        amount_set_data_by(:cc_type)
      end

=begin
      def index
        #TODO build generic
        @main_set = {}
        @compare_set = {}

        fill_data

        set_data
      end  

      def fill_data
        # this method define the way to fill info in index
      end

      def by_week_days  
        set_data_by(:wday)
      end
     
      def by_hours  
        set_data_by(:hour)
      end
=end
      
      private
    
        def compute_amount
          # Define in each class
        end  
    
        def amount_set_data_by(fun)
          @amount_main_set = amount_collect_by(@amount_data, fun)
          unless @amount_compare_data
            @amount_compare_set = amount_collect_by(@amount_compare_data, fun)
          end
          amount_set_data
        end

        def amount_set_data
          if @amount_compare_data
            @data = [{:name => "#{@amount_start_date} / #{@amount_end_date}", :data => @amount_main_set },
                     {:name => "#{@amount_compare_start_date} / #{@amount_compare_end_date}", :data => @amount_compare_set }]
          else
            @data = [{:name => "#{@amount_start_date} / #{@amount_end_date}", :data => @amount_main_set }]
          end

        end

         
        def amount_collect_by(collection, fun )
          collection.group_by{|o| o.send(fun)}.sort{|a,b| a[0]<=>b[0]}.collect do |c|
            case fun
              when :status then [c[0], compute_amount(c[1])]
              when :cc_type then [c[0], compute_amount(c[1])]
            end
          end  
        end

      def amount_get_params(start = Date.today, amount = 3.months, compare = Date.today - 3.months, compare_amount = 3.months )
        @amount_start_date =  start - amount
        @amount_end_date = start
        unless compare.nil?
          @amount_compare_start_date = compare - compare_amount
          @amount_compare_end_date = compare
        end
        #@diff = first_order.placed_on.to_time - first_order_compare.placed_on.to_time
      end
        
        def amount_get_data
          @amount_data = klass_to_call.placed_on_between(@start_date, @end_date)
        end
      
        def amount_get_compare_data
          @amount_compare_data = klass_to_call.placed_on_between(@compare_start_date, @compare_end_date)
        end

        def amount_set_time
          if params[:date_range]
            case params[:date_range]
              when 'today' then amount_get_params(Date.today, 0, nil, nil)
              when 'yesterday' then amount_get_params(Date.today, 1.days, nil, nil)
              when 'last_week' then amount_get_params(Date.today, 7.days, nil, nil)
              when 'last_month' then amount_get_params(Date.today, 1.months, nil, nil)
              else
                amount_get_params
            end
          else
            amount_get_params
          end
        end
     end 
  end
end
