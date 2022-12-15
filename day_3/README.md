--- Day 3: Rucksack Reorganization ---

One Elf has the important job of loading all of the rucksacks with supplies for the jungle journey. Unfortunately, that Elf didn't quite follow the packing instructions, and so a few items now need to be rearranged.

Each rucksack has two large compartments. All items of a given type are meant to go into exactly one of the two compartments. The Elf that did the packing failed to follow this rule for exactly one item type per rucksack.

The Elves have made a list of all of the items currently in each rucksack (your puzzle input), but they need your help finding the errors. Every item type is identified by a single lowercase or uppercase letter (that is, a and A refer to different types of items).

The list of items for each rucksack is given as characters all on a single line. A given rucksack always has the same number of items in each of its two compartments, so the first half of the characters represent items in the first compartment, while the second half of the characters represent items in the second compartment.

For example, suppose you have the following list of contents from six rucksacks:

```
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
```

    The first rucksack contains the items vJrwpWtwJgWrhcsFMMfFFhFp, which means its first compartment contains the items vJrwpWtwJgWr, while the second compartment contains the items hcsFMMfFFhFp. The only item type that appears in both compartments is lowercase p.
    The second rucksack's compartments contain jqHRNqRjqzjGDLGL and rsFMfFZSrLrFZsSL. The only item type that appears in both compartments is uppercase L.
    The third rucksack's compartments contain PmmdzqPrV and vPwwTWBwg; the only common item type is uppercase P.
    The fourth rucksack's compartments only share item type v.
    The fifth rucksack's compartments only share item type t.
    The sixth rucksack's compartments only share item type s.

To help prioritize item rearrangement, every item type can be converted to a priority:

    Lowercase item types a through z have priorities 1 through 26.
    Uppercase item types A through Z have priorities 27 through 52.

In the above example, the priority of the item type that appears in both compartments of each rucksack is 16 (p), 38 (L), 42 (P), 22 (v), 20 (t), and 19 (s); the sum of these is 157.

Find the item type that appears in both compartments of each rucksack. What is the sum of the priorities of those item types?

Answer: 8139

--- Part Two ---

As you finish identifying the misplaced items, the Elves come to you with another issue.

For safety, the Elves are divided into groups of three. Every Elf carries a badge that identifies their group. For efficiency, within each group of three Elves, the badge is the only item type carried by all three Elves. That is, if a group's badge is item type B, then all three Elves will have item type B somewhere in their rucksack, and at most two of the Elves will be carrying any other item type.

The problem is that someone forgot to put this year's updated authenticity sticker on the badges. All of the badges need to be pulled out of the rucksacks so the new authenticity stickers can be attached.

Additionally, nobody wrote down which item type corresponds to each group's badges. The only way to tell which item type is the right one is by finding the one item type that is common between all three Elves in each group.

Every set of three lines in your list corresponds to a single group, but each group can have a different badge item type. So, in the above example, the first group's rucksacks are the first three lines:

vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg

And the second group's rucksacks are the next three lines:

wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw

In the first group, the only item type that appears in all three rucksacks is lowercase r; this must be their badges. In the second group, their badge item type must be Z.

Priorities for these items must still be found to organize the sticker attachment efforts: here, they are 18 (r) for the first group and 52 (Z) for the second group. The sum of these is 70.

Find the item type that corresponds to the badges of each three-Elf group. What is the sum of the priorities of those item types?

Answer: 2668

# First iteration

Oof! This one was a doozy for some reason. With me trying to challenge myself to write clean, possibly reusable code for these 
simple challenges, I astronauted the solution which is really what caused most of my pain. The problem itself was fairly simple
and my approach to Part 1 in my first iteration felt pretty good. I thought for sure that I had written it in a way
that might be pretty close to the final iteration. Boy, was I wrong but I'll talk about that when I get to explaining
the thought process behind the second iteration. For the first iteration, I realized pretty quickly that this was another
parsing issue, which I assume all the others probably are as well, and I continued down my pattern of creating a "File object" to
use in place of the standard `File` class. Reference the previous two days for more understanding of this pattern. For this
day's problem, I wanted my file output to be returned in a way that made it easy to check if the two compartments in a rucksack
contained a common letter. Based on the prompt, the rucksacks, being each half of a line in the file, I thought it would be 
great for my "file object" to split the lines in half and give me a nested array where each sub array, would contain the two
halves of the line making it easy to compare. Now, because I was trying to think forward into the future and what scope creep might
be introduced in day 2, I decided that I didn't want my "file object" to just split a line in half, I felt it would be more useful if my
file object could handle splitting a line into many different equal parts, if need be. That way if part 2 were to say that a rucksack had 
four compartments, then I might be able to handle that. After pondering it a bit more, I started to think, well,
I don't know that my file object should even care about splitting lines, what if instead I created a `StringDecorater` that would mimic the
`Enumerable#each_slice` method, but on a string instead, and maybe my file class could be called `DecoratedFile` and would allow for a decorator to
be passed as an argument and that decorator could then add behavior to each line that you wouldn't normally get when dealing with a 
regular string. Great! This felt extremely good, both my decorator class and file class felt super useful. I was then able to decorate
each line in the file, thus giving me the ability to iterate over the file lines and call the `each_slice` on a given line, which allowed me
to break the line into two equal parts, then instantiate a `Set` with the characters of these parts, and finally run an intersection of the two
sets to see which characters were common. I could then take the intersection of common characters and iterate over them, passing them to my
`Translator` class, which was a class reused from `day_2`. This translator, would then translate the common letters between the sets to their 
priority numbers, which I could later add up to get a sum of the total priorities. Job well done! Or so I thought(-_-)...

# Second iteration
Part two completely broke down what I initially had. I could no longer rely on needing the common items within the compartments(halves) in a single
rucksack(line), I now needed to be able to compare across multiple rucksacks(lines). Which was not at all what I anticipated. Which is why they call
it "scope creep" I guess. Anyway, now I had to rethink a good portion of my solution, which just so happened to be the parsing aspect. So I now needed
a way of "grouping" lines in a file, that way I could compare items across several elves rucksacks, while also remaining backwards compatible with part 1,
comparing items across compartments. I spent waaaaaaaaay more time on coming up with a solution on this than I should have. I came up with many solutions
that came close, but none of them got the job done, and many of them felt quite messy. At this point, I still felt like the "slicing" behavior of `each_slice`
was useful and necessary. I decided that instead of using a `DecoratedFile` class, I would use a `SliceFile` class. This class would, again, similar to the
other "file object" classes that I had created, behave similarly to the `File` class, using a `readlines` method that would allow for parse the file and returning
the lines grouped in slices. I reasoned, that by doing this, I would be able to group the lines in a way that would solve for part 2, and also I could just pass
1 as the `slice_by` option for when part 1 only called for a single rucksack(line) to be compared. This felt like a step in the right direction, the problem now,
was "how do I go about handling when I need to compare across compartments(half of line) for a single elf?", as detailed in part 1. I started off my approach with a
"let's just get a basic conditional out there and see if any patterns emerge" mindset. Now that I had my file data in a format that felt easy to work with, I realized
that there actually was quite a good deal of code that could be stolen from part one, as my array of file data didn't really change. For a single elf, when compartments
needed to be compared, I would still iterate over my array, and decorate the string elements with my `StringDecorator` and use it to split the line in half, into a subarray
with each half as elements to the subarray, then pass the subarray of two get an intersection of every character, of every element in the subarray, and pass the common ones
to my translator to get the priority of the common items and later add them up. The conditional, for part 2 when there wasn't compartments was more or less the same, the
only difference was that when I was dealing with a single elf, that line needed to be split, in order to get a subarray that could then be passed to my `intersection` method,
but for when there were more elves than one, I had no need to do this, because I already had a subarray, from my "slicing" of the file, therefore bypassing the need for the
decorator. Once I realized this, and realized that the rest of the *shape* was the same, I decided to abstract out a method called `decorate_slice` and just always pass the slice
to that method and return the slice back if the `@compartments` boolean was `false`. This allowed me to get rid of my giant conditional, in favor of a much smaller, cleaner conditional.
Plus the cool thing about the code that I ended up with, is that it would support not only comparing across many elf rucksacks, but also allowing for a more granular search of "what
items are common to ALL the compartments for ALL the elves. Ultimateley, I feel pretty satisfied with what I ended up with, there were definitely many times throughout this where
I did not.

