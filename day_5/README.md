--- Day 5: Supply Stacks ---

The expedition can depart as soon as the final supplies have been unloaded from the ships. Supplies are stored in stacks of marked crates, but because the needed supplies are buried under many other crates, the crates need to be rearranged.

The ship has a giant cargo crane capable of moving crates between stacks. To ensure none of the crates get crushed or fall over, the crane operator will rearrange them in a series of carefully-planned steps. After the crates are rearranged, the desired crates will be at the top of each stack.

The Elves don't want to interrupt the crane operator during this delicate procedure, but they forgot to ask her which crate will end up where, and they want to be ready to unload them as soon as possible so they can embark.

They do, however, have a drawing of the starting stacks of crates and the rearrangement procedure (your puzzle input). For example:

```
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
```

In this example, there are three stacks of crates. Stack 1 contains two crates: crate Z is on the bottom, and crate N is on top. Stack 2 contains three crates; from bottom to top, they are crates M, C, and D. Finally, stack 3 contains a single crate, P.

Then, the rearrangement procedure is given. In each step of the procedure, a quantity of crates is moved from one stack to a different stack. In the first step of the above rearrangement procedure, one crate is moved from stack 2 to stack 1, resulting in this configuration:

```
[D]
[N] [C]
[Z] [M] [P]
 1   2   3
```

In the second step, three crates are moved from stack 1 to stack 3. Crates are moved one at a time, so the first crate to be moved (D) ends up below the second and third crates:

```
        [Z]
        [N]
    [C] [D]
    [M] [P]
 1   2   3
```

Then, both crates are moved from stack 2 to stack 1. Again, because crates are moved one at a time, crate C ends up below crate M:

```
        [Z]
        [N]
[M]     [D]
[C]     [P]
 1   2   3
 ```

Finally, one crate is moved from stack 1 to stack 2:

```
        [Z]
        [N]
        [D]
[C] [M] [P]
 1   2   3
```

The Elves just need to know which crate will end up on top of each stack; in this example, the top crates are C in stack 1, M in stack 2, and Z in stack 3, so you should combine these together and give the Elves the message CMZ.

After the rearrangement procedure completes, what crate ends up on top of each stack?

Answer: "QPJPLMNNR"

--- Part Two ---

As you watch the crane operator expertly rearrange the crates, you notice the process isn't following your prediction.

Some mud was covering the writing on the side of the crane, and you quickly wipe it away. The crane isn't a CrateMover 9000 - it's a CrateMover 9001.

The CrateMover 9001 is notable for many new and exciting features: air conditioning, leather seats, an extra cup holder, and the ability to pick up and move multiple crates at once.

Again considering the example above, the crates begin in the same configuration:

```
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 
 ```

Moving a single crate from stack 2 to stack 1 behaves the same as before:

```
[D]        
[N] [C]    
[Z] [M] [P]
 1   2   3 
 ```

However, the action of moving three crates from stack 1 to stack 3 means that those three moved crates stay in the same order, resulting in this new configuration:

```
        [D]
        [N]
    [C] [Z]
    [M] [P]
 1   2   3
 ```

Next, as both crates are moved from stack 2 to stack 1, they retain their order as well:

```
        [D]
        [N]
[C]     [Z]
[M]     [P]
 1   2   3
 ```

Finally, a single crate is still moved from stack 1 to stack 2, but now it's crate C that gets moved:

```
        [D]
        [N]
        [Z]
[M] [C] [P]
 1   2   3
 ```

In this example, the CrateMover 9001 has put the crates in a totally different order: MCD.

Before the rearrangement process finishes, update your simulation so that the Elves know where they should stand to be ready to unload the final supplies. After the rearrangement procedure completes, what crate ends up on top of each stack?

Answer: "BQDNWJPVJ"

## First iteration
This day's challenge was another tough one, maybe the the most challenging one yet. I think I realized
pretty early on, in this challenge, that there wouldn't be much "general purpose" code that I could use for this.
The solution to this felt very domain-specific, and so I didn't even really try to hard to make any general classes. Instead
I went in with the goal of making the code as readable as possible. In the first iteration, I *feel* like I could have made it a little
bit more readable, there's still some aspects of the code where I'm doing a lot of enumerating which kinda makes the code obscure, but
I think it's still "decent". Basically, the way that I approached this first part, I would use `File#readlines` to parse the file, I would
then take everything up until the first empty line, which would give me the "stacks", I would drop off the last element, which was the numbers
under the stack, as I didn't really need those. This was set as a `StackCollection` object. I then took the opposite approach with the rest 
of the file, taking everything after the blank line and setting it as a `MovementCollection`. Having this dynamic allowed me to iterate
over the collection of movements, manipulating the stacks and finally grabbing the list of letters that were at the top of each stack.
My fear going into part 2, is that all of my code was so specific to the first part that "scope creep" is almost certain to cause me major
headache. (-_-)

## Second iteration
Okay, so I was worried for nothing. The nuance introduced in part 2, wasn't that hard to handle. I simply just needed to reverse the order
of the boxes that were going back into a stack. To do this, I just allowed an `order` boolean to be passed in and if it was present and true,
then I would just make the order reverse. Simple as that. I still think the code itself can be greatly cleaned up, but I did not want to spend
too much time on this day. Hopefully, I'll get the time to loop back around to this one.
