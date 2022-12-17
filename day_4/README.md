# Challenge

## --- Day 4: Camp Cleanup ---

Space needs to be cleared before the last supplies can be unloaded from the ships, and so several Elves have been assigned the job of cleaning up sections of the camp. Every section has a unique ID number, and each Elf is assigned a range of section IDs.

However, as some of the Elves compare their section assignments with each other, they've noticed that many of the assignments overlap. To try to quickly find overlaps and reduce duplicated effort, the Elves pair up and make a big list of the section assignments for each pair (your puzzle input).

For example, consider the following list of section assignment pairs:

```
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
```

For the first few pairs, this list means:

    Within the first pair of Elves, the first Elf was assigned sections 2-4 (sections 2, 3, and 4), while the second Elf was assigned sections 6-8 (sections 6, 7, 8).
    The Elves in the second pair were each assigned two sections.
    The Elves in the third pair were each assigned three sections: one got sections 5, 6, and 7, while the other also got 7, plus 8 and 9.

This example list uses single-digit section IDs to make it easier to draw; your actual list might contain larger numbers. Visually, these pairs of section assignments look like this:

```
.234.....  2-4
.....678.  6-8

.23......  2-3
...45....  4-5

....567..  5-7
......789  7-9

.2345678.  2-8
..34567..  3-7

.....6...  6-6
...456...  4-6

.23456...  2-6
...45678.  4-8
```

Some of the pairs have noticed that one of their assignments fully contains the other. For example, 2-8 fully contains 3-7, and 6-6 is fully contained by 4-6. In pairs where one assignment fully contains the other, one Elf in the pair would be exclusively cleaning sections their partner will already be cleaning, so these seem like the most in need of reconsideration. In this example, there are 2 such pairs.

In how many assignment pairs does one range fully contain the other?

Answer: 413

--- Part Two ---

It seems like there is still quite a bit of duplicate work planned. Instead, the Elves would like to know the number of pairs that overlap at all.

In the above example, the first two pairs (2-4,6-8 and 2-3,4-5) don't overlap, while the remaining four pairs (5-7,7-9, 2-8,3-7, 6-6,4-6, and 2-6,4-8) do overlap:

    5-7,7-9 overlaps in a single section, 7.
    2-8,3-7 overlaps all of the sections 3 through 7.
    6-6,4-6 overlaps in a single section, 6.
    2-6,4-8 overlaps in sections 4, 5, and 6.

So, in this example, the number of overlapping assignment pairs is 4.

In how many assignment pairs do the ranges overlap?

Answer: 806

# Solution

## First iteration
This challenge was extremely simple in comparison to the previous days! Right off the bat, I realized
that the file that I needed to parse was comma-separated and realized that I could leverage the csv class
from the Ruby standard library. I then thought, "let's continue using my file object pattern" and came up with
`DecoratedCSV`, similar to the `DecoratedFile` class that I used in the prototype for day 1. Knowing that `CSV` was
gonna return an array with each "range string", I decided that I would create an `ArrayDecorator` that would overwrite
the `[]` method, and have it decorate the returned string element of the array, using a `StringDecorator`. In the `StringDecorator`
class, I added a method that I named `to_range` that would take the "range string" and convert it to a `Range` object. This again,
allowed me to leverage a Ruby standard library that would have convenient methods, that would be useful for the task at hand. Now, 
all I had to do was to iterate over the "decorated" csv, convert each element, of each subarray, to a `Range` object, and use the 
handy `Range#cover?` method to see if one range completely covered the other or vice versa. It was that simple!

## Second iteration
I *really* didn't have to change much from my first iteration. I simply renamed my first iteration's method, to be more explicit
in letting whoever needed to make use of it, that it was checking for complete overlaps. Then I just added a new method that would check
for any overlap, and I did this by doing an `intersection` of the ranges, rather than checking `cover?`. I think I would have liked my 
solution more if my `ArrayDecorator` wasn't dependent on my `StringDecorator`, but at the same time, it doesn't really bother me. These
decorators are very specific to this application's needs, and that's fine. All in all, I was extremely pleased with my approach for 
this day's challenge. :)
