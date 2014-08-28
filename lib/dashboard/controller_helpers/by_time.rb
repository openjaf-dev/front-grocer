module Dashboard
  module ControllerHelpers
    module ByTime
      extend ActiveSupport::Concern
      
      included do
        before_action :set_time
        before_action :get_data
        before_action :get_compare_data
      end  
      
      def klass_to_call
        # denifine where will be included
      end  
    
      def index
        #TODO build generic
        @main_data = {}
        @compare_data = {}  
        set_data
      end  
    
      def by_week_days  
        set_data_by(:wday)
      end
     
      def by_hours  
        set_data_by(:hour)
      end 
      
      private
    
        def compute
          # Define in each class
        end  
    
        def set_data_by(fun)
          @main_set = collect_by(@data, fun)
          if @compare_data
            @compare_set = collect_by(@compare_data, fun)
          end
          set_data 
        end 
       
        def set_data
          if @compare_data
            @data = [{:name => "#{@start_date} / #{@end_date}", :data => @main_set },
                     {:name => "#{@compare_start_date} / #{@compare_end_date}", :data => @compare_set }]
          else
            @data = [{:name => "#{@start_date} / #{@end_date}", :data => @main_set }]
          end

        end
         
        def collect_by(collection, fun )
          collection.group_by{|o| o.placed_on.send(fun)}.sort{|a,b| a[0]<=>b[0]}.collect do |c|
            case fun
            when :hour then [hours[c[0]], compute(c[1])]
            when :wday then [days[c[0]], compute(c[1])] 
            end
          end  
        end
      
        def get_params(start = Date.today, amount = 3.months, compare = Date.today - 3.months, compare_amount = 3.months )
          @start_date =  start - amount
          @end_date = start
          unless compare.nil?
            @compare_start_date = compare - compare_amount
            @compare_end_date = compare
          end
          #@diff = first_order.placed_on.to_time - first_order_compare.placed_on.to_time
        end
        
        def get_data
          @data = klass_to_call.placed_on_between(@start_date, @end_date)
        end
      
        def get_compare_data
          if @compare_start_date
            @compare_data = klass_to_call.placed_on_between(@compare_start_date, @compare_end_date)
            puts @compare_data.count
            @compare_data = @compare_data
          end
        end

        def set_time
          if params[:date_range]
            case params[:date_range]
              when 'today' then get_params(Date.today, 0, nil, nil)
              when 'yesterday' then get_params(Date.today, 1.days, nil, nil)
              when 'last_week' then get_params(Date.today, 7.days, nil, nil)
              when 'last_month' then get_params(Date.today, 1.months, nil, nil)
              else
                get_params
            end
          else
            get_params
          end
        end
     end 
  end
end
