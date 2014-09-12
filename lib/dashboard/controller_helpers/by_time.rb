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
        @data_table = @data.clone
        
        @filter = params[:filter] ||= 'week'   
        @main_set = filter_by(@filter, @data)
        @compare_set = filter_by(@filter, @compare_data)

        first_data = @main_set.sort{ |a,b| a[0] <=> b[0] }.first[0]
        first_compare_data = @compare_set.sort{ |a,b| a[0] <=> b[0] }.first[0]
        diff = first_data - first_compare_data
        temp = {}
        @compare_set.each { |x| temp[ x[0] + diff ] = x[1] }
        @compare_set = temp
        
        set_data  
      end
    
      def by_week_days
        set_data_by(:wday)
      end
     
      def by_hours
        set_data_by(:hour)
      end 
      
      def method_missing(method_name, *args, &block)
        return super unless /^by_/ =~ method_name
        by = case method_name
        when :by_week_days then :wday
        when 'by_hours' then :hour 
        end  
        set_data_by(by)
      end
      
      private
    
        def compute
          # abstrack method for define in each class
        end  
    
        def filter_by(filter, collection)
          collection.group_by { |o| o.placed_on.send("beginning_of_#{filter}" )}.map { |k, v| [k,compute(v)] } 
        end  
        
        def set_data_by(fun)
          @main_set = collect_by(@data, fun)
          @compare_set = collect_by(@compare_data, fun) if @compare_data
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
      
        def get_params(options = {})
          options[:start] ||= Date.today
          options[:amount] ||= 3.months
          options[:compare] ||= Date.today - 3.months
          options[:compare_amount] ||= 3.months 

          @start_date =  options[:start] - options[:amount]
          @end_date = options[:start]

          @compare_start_date = options[:compare] - options[:compare_amount]
          @compare_end_date = options[:compare]
        end
        
        def get_data
          @data = klass_to_call.placed_on_between(@start_date, @end_date)
          @data_table = @data.clone
        end
      
        def get_compare_data   
          @compare_data = klass_to_call.placed_on_between(@compare_start_date, @compare_end_date) if @compare_start_date
        end

        def set_time
          puts params.inspect
          
          d = Date.today

          if params[:date_range]
            case params[:date_range]
              when 'today' 
                get_params(amount: 0, compare: d, compare_amount: 1.days )
              when 'yesterday' 
                get_params(amount: 1.days, compare: d - 1.days, compare_amount: 2.days)
              when 'last_week' 
                get_params(amount: 7.days, compare: d - 7.days, compare_amount: 7.days)
              when 'last_month'
                get_params(amount: 1.months, compare: d - 1.months, compare_amount: 1.months)
              when 'previous_year'
                get_params( amount: 1.years, compare: d - 1.years, compare_amount: 1.years)
              when 'year_to_date' 
                get_params(amount: d.yday.day, compare: d - 1.years, compare_amount: d.yday.days)
            end
          
          elsif params[:from_time] && params[:to_time]
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
