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
        @data_table = @data.clone
        @data_table += @compare_data.clone unless @compare_data.count == 0

        set_data_by(:wday)
      end
     
      def by_hours
        @data_table = @data
        @data_table += @compare_data unless @compare_data.count == 0

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
            if params[:filter_type]
              @data = [{:name => "Filtered by #{params[:filter_type]}", :data => @main_set }]
            else
              @data = [{:name => "#{@start_date} / #{@end_date}", :data => @main_set }]
            end

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
          if start.nil? && amount.nil? && compare.nil? && compare_amount.nil?
            @start_date = @end_date = @compare_start_date = @compare_end_date = nil
            return
          end

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
          @data=@data
        end
      
        def get_compare_data
          if @compare_start_date
            @compare_data = klass_to_call.placed_on_between(@compare_start_date, @compare_end_date)
          end
        end

      def set_time
        puts params.inspect
        if params[:filter_type]

          get_params(nil,nil,nil,nil)
          return
        end

        if params[:date_range]
          case params[:date_range]
            when 'today' then
              get_params(Date.today, 0, Date.today, 1.days)
            when 'yesterday' then
              get_params(Date.today, 1.days, Date.today - 1.days, 2.days)
            when 'last_week' then
              get_params(Date.today, 7.days, Date.today - 7.days, 7.days)
            when 'last_month' then
              get_params(Date.today, 1.months, Date.today - 1.months, 1.months)
            when 'previous_year' then
              get_params(Date.today, 1.years, Date.today - 1.years, 1.years)
            when 'year_to_date' then
              today = Date.today
              get_params(today , today.yday.days , today - 1.years, today.yday.days)
            else
              get_params
          end
        elsif params[:from_time] && params[:to_time]
          from = params[:from_time].to_date
            from = Date.strptime(params[:from_time], '%m/%d/%Y') 
          to = params[:to_time].to_date

          if params[:compare_from_time] && params[:compare_to_time]
            compare_from = params[:compare_from_time].to_date
            compare_to = params[:compare_to_time].to_date
            get_params(to , to - from, compare_to, compare_to - compare_from)
          else
            get_params(to , to - from, nil, nil)
          end


        else
          get_params
        end
      end
     end 
  end
end
