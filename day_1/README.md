# Challenge

## --- Day 1: Calorie Counting ---

Santa's reindeer typically eat regular reindeer food, but they need a lot of magical energy to deliver presents on Christmas. For that, their favorite snack is a special type of star fruit that only grows deep in the jungle. The Elves have brought you on their annual expedition to the grove where the fruit grows.

To supply enough magical energy, the expedition needs to retrieve a minimum of fifty stars by December 25th. Although the Elves assure you that the grove has plenty of fruit, you decide to grab any fruit you see along the way, just in case.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

The jungle must be too overgrown and difficult to navigate in vehicles or access from the air; the Elves' expedition traditionally goes on foot. As your boats approach land, the Elves begin taking inventory of their supplies. One important consideration is food - in particular, the number of Calories each Elf is carrying (your puzzle input).

The Elves take turns writing down the number of Calories contained by the various meals, snacks, rations, etc. that they've brought with them, one item per line. Each Elf separates their own inventory from the previous Elf's inventory (if any) by a blank line.

For example, suppose the Elves finish writing their items' Calories and end up with the following list:

```
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
```

This list represents the Calories of the food carried by five Elves:

    The first Elf is carrying food with 1000, 2000, and 3000 Calories, a total of 6000 Calories.
    The second Elf is carrying one food item with 4000 Calories.
    The third Elf is carrying food with 5000 and 6000 Calories, a total of 11000 Calories.
    The fourth Elf is carrying food with 7000, 8000, and 9000 Calories, a total of 24000 Calories.
    The fifth Elf is carrying one food item with 10000 Calories.

In case the Elves get hungry and need extra snacks, they need to know which Elf to ask: they'd like to know how many Calories are being carried by the Elf carrying the most Calories. In the example above, this is 24000 (carried by the fourth Elf).

Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?

Answer: 66306

## --- Part Two ---

By the time you calculate the answer to the Elves' question, they've already realized that the Elf carrying the most Calories of food might eventually run out of snacks.

To avoid this unacceptable situation, the Elves would instead like to know the total Calories carried by the top three Elves carrying the most Calories. That way, even if one of those Elves runs out of snacks, they still have two backups.

In the example above, the top three Elves are the fourth Elf (with 24000 Calories), then the third Elf (with 11000 Calories), then the fifth Elf (with 10000 Calories). The sum of the Calories carried by these three elves is 45000.

Find the top three Elves carrying the most Calories. How many Calories are those Elves carrying in total?

Answer: 195292

# Solution

## First iteration
My first attempt at a solution to this challenge, was very specific to the challenge itself. It involved creating a `ElfCalorieQueue` that
would essentially accept an array of data, because my array of data was coming from a `File.readlines`, it ended up being an array
of strings with newline characters. I felt that the newline character, would only cause unnecessary logic and I was able to preemptively
combat that, by passing `readlines` the `chomp: true` option. This left me with an array of string integers and empty strings, where the
line breaks were. I was fine with that, but in hindsight, it set me up to design my class in a way, I now believe, had too much "external"
knowledge. I also had another class, in which served as the "main" application. It would be instantiated with a "calorie_queue", which meant
that this class was now dependent on a very specific and uncommon protocol. This main class would use the `ElfCalorieQueue` object to "cycle"
through the "elves" in line and get a sum of each individual elves total calories, and then checking on each iteration to see if there was a
new max, and saving the new max, and finally returning it at the end of the process. Now mind you, this solution worked just fine, I was able
to get my gold star, and I could have continued building it out for **Part two**, but I felt like I could make my classes a little more 
general purpose and I wanted to explore that in a refactor before moving on to the second part of the challenge.

## Second iteration
After completing the first part of the challenge, I took a break and some time to collect my thoughts and reflect on the code that
I had written. The challenge's problem that I was trying to solve for felt very generic. The input data was simply a file, with lines
of numbers and the occasional empty line. This seemed like a likely scenario that one might encounter in a real world application, so
I began thinking, it would be more useful to have a generic file parsing class that would read over a file of numbers and convert them
into an array of integers, where empty lines were returned as `nil`. My first instinct, was to check the Ruby `File` class to make sure
that there wasn't already an option or method that could be used to accomplish this type of behavior. Upon looking, I didn't come across anything
that looked viable, so I decided, that I would make a new type of file class called `IntegerListFile`. I originally thought to have this new
file class inherit from `File` and to overwrite the `readlines` method with the type of behavior that I desired. I backed off of this pretty
quickly, as I decided that I didn't have any immediate use for any other `File` methods, except for the `readlines` method, so I instead opted for
using the "proxy" pattern, or at least a variation of it, to accomplish my goal. Although probably not a true implementation of a proxy, since
I did not mirror the `File` interface in it's entirety, I was at least able to create an object with a common `File` method, whose behavior and 
return type were pretty similar to that of the original `File.readlines`. Plus, if I later found that there were more methods related to a file 
that could be beneficial, I could always add them to my class as needed, or eventually consider the inheritance route. Overall, this class felt 
pretty powerful, as I thought of all of the different scenarios in which one might wish to use it in place of the regular `File` class.

With the `IntegerListFile` class in place, I was now able to parse over a file of integers and get an array of integers back. Now that I had this array,
I began to consider what I had done in the previous iteration, when I had gotten to this very same step. In the previous iteration, I had come to this
very same step in the programming process, I decided that a good step would be to iterate over the array, and create subarrays when met with a `nil` value.
I still found this to be a reasonable solution but also thought that it could be put into a more general purpose class. I felt like the class should be
able to accept an array and and delimiter and "split" the array into subarrays based on the delimiter, in the case of this specific application, that would
be `nil`, but for sake of the class, I wanted to make it *open* to any delimiters. Knowing the behavior and how to accomplish it, was only a fraction of the
battle, the hard part was really deciding the language to help conceptualize and convey the behavior. At first I began to think that it would be appropriate
to think of it as "array categorization", but then I felt that this wasn't quite right. I wasn't categorizing these array values by any sort of condition, I
was actually moreso mimicking the behavior of the `String#split` method, but on an array. Now, if there were ever an appropriate time to monkey patch, I
could see this being argued as a time to do so. You could simply monkeypatch the `Array` class to define a `split` method that accepts a delimiter as an
argument and performs that behavior that we want it to on the array. However, me being me, and having the coding experiences that I've had up until this
point in my career, I am not a fan of monkey patching. Monkey patching, in my experience, can lead to some very confusing code and annoying debugging
experience if one is not familiar with the monkey patching decision, and even though this is not really a place that is at risk of either of things being a
problem, I have made it a part of my coding principles, to stay away from decisions like that, by default. So instead, I went for a slightly different approach,
I would create a "decorator", that would decorate an array with the splitting behavior. The `split` logic in this case was actually reappropriated from 
an `ActiveSupport` library, so shout out to the original developer who came up with that.

From here, I can map over the array and sum each of the nested sub arrays. Then finally, I can use the `Array#max` and receive the max number of calories, or
`Array#max` accepts an integer(n) and will return the top n maxes, which allows me to solve for both part 1 and part 2!

Earlier, I mentioned that I wanted to refactor this to be more general purpose. Now I'm not ignorant in knowing that in each application, there is usually *some*
application nuance, and this application is no different. I just knew that for the most part I could clean up the code that I had and possibly create classes that
had the potential to be used in other applications should I ever need them, and I like the idea of that. So that means that I still have a main "client" class, that
essentially orchestrates the calling of my general purpose classes and uses them in a way that is relevant to the purpose of this specific application.
