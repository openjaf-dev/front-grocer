module Dashboard
  module ControllerHelpers
    module ByTime
      extend ActiveSupport::Concern
      
      included do
        before_action :set_time
        before_action :get_data
      end  
      
      def klass_to_call
        # denifine where will be included
      end  
    
      def index        
        @filter = params[:filter] ||= 'week'   
        @main_set = filter_by(@filter, @main_data).sort
        @compare_set = filter_by(@filter, @compare_data).sort

        diff = @main_set.first[0] - @compare_set.first[0]
        temp = {}
        @compare_set.each { |x| temp[ x[0] + diff ] = x[1] }
        @compare_set = temp
        
        set_data  
      end
      
      %w(wday hour).each do |meth|
        define_method("by_#{meth}") { set_data_by(meth)}
      end
      
      private
      
        def set_data_by(fun)
          @main_set = collect_by(@main_data, fun)
          @compare_set = collect_by(@compare_data, fun) if @compare_data
          set_data 
        end 
        
        def wday
          %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
        end
        
        def hour
          %w(12am 1am 2am 3am 4am 5am 6am 7am 8am 9am 10am 11am 12m 1pm 2pm 3pm 4pm 5pm 6pm 7pm 8pm 9pm 10pm 11pm)
        end
    
        def compute
          # abstrack method for define in each class
        end  
    
        def filter_by(filter, collection)
          collection.group_by { |o| o.placed_on.send("beginning_of_#{filter}" )}.map { |k, v| [k,compute(v)] } 
        end  
       
        def set_data
          @data = [{:name => "#{@start_date} / #{@end_date}", :data => @main_set }]
          @data << {:name => "#{@compare_start_date} / #{@compare_end_date}", :data => @compare_set } if @compare_set
        end

        def get_data
          @main_data = klass_to_call.placed_on_between(@start_date, @end_date)
          @compare_data = klass_to_call.placed_on_between(@compare_start_date, @compare_end_date) if @compare_start_date
        end
         
        def collect_by(collection, fun )
          collection.group_by{|o| o.placed_on.send(fun)}.sort.map { |c| [self.send(fun)[c[0]], compute(c[1])] }
        end

        def set_time          
          d = Date.today
          opt = {}
          time_opt = {  'today' => 0.days, 
                        'yesterday' => 1.days,
                        'last_week' => 1.weeks, 
                        'last_month' => 1.months,
                        'previous_year' => 1.years,
                        'year_to_date' => d.yday.day,
                     }
          
          if params[:date_range]
            t_opt = time_opt[params[:date_range]]
            opt = {start: d, amount: t_opt, compare: d - t_opt, compare_amount: t_opt}
            
          elsif params[:from_time] && params[:to_time]
            opt[:start] = params[:to_time].to_date
            opt[:amount] = params[:to_time].to_date - params[:from_time].to_date
            
            if params[:compare_from_time] && params[:compare_to_time]
              opt[:compare] = params[:compare_to_time].to_date
              opt[:compare_amount] = params[:compare_to_time].to_date - params[:compare_from_time].to_date
            end
          end
          
          get_params opt
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
        
     end 
  end
end
