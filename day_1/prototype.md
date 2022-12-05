Here was my initial code, before my refactor:
```ruby
 class CalorieTracker
   def initialize(calorie_queue)
     @calorie_queue = calorie_queue
     @max = 0
   end

   def determine_max
     while @calorie_queue.elves_in_line? do
       num = @calorie_queue.next_in_line_total_calories
       @max = num if num > @max
     end
     @max
   end
 end

 class ElfCalorieQueue
   def initialize(data_set)
     @data_set = data_set
   end

   def elves_in_line?
     !@data_set.join.empty?
   end

   def next_in_line_total_calories
     next_in_line_as_integers.sum
   end

   def next_in_line_as_integers
     next_in_line_calorie_array.map(&:to_i)
   end

   def next_in_line_calorie_array
     @data_set.shift(@data_set.index("") + 1).reject(&:empty?)
   end
 end

 queue = ElfCalorieQueue.new(File.readlines("day_1/input_data.txt", chomp: true))
 puts CalorieTracker.new(queue).determine_max
```

It still works and is fairly clean but I think you might agree with me that the final product turned out way cleaner and more useful
