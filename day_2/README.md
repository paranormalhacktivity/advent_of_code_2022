--- Day 2: Rock Paper Scissors ---

The Elves begin to set up camp on the beach. To decide whose tent gets to be closest to the snack storage, a giant Rock Paper Scissors tournament is already in progress.

Rock Paper Scissors is a game between two players. Each game contains many rounds; in each round, the players each simultaneously choose one of Rock, Paper, or Scissors using a hand shape. Then, a winner for that round is selected: Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock. If both players choose the same shape, the round instead ends in a draw.

Appreciative of your help yesterday, one Elf gives you an encrypted strategy guide (your puzzle input) that they say will be sure to help you win. "The first column is what your opponent is going to play: A for Rock, B for Paper, and C for Scissors. The second column--" Suddenly, the Elf is called away to help with someone's tent.

The second column, you reason, must be what you should play in response: X for Rock, Y for Paper, and Z for Scissors. Winning every time would be suspicious, so the responses must have been carefully chosen.

The winner of the whole tournament is the player with the highest score. Your total score is the sum of your scores for each round. The score for a single round is the score for the shape you selected (1 for Rock, 2 for Paper, and 3 for Scissors) plus the score for the outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won).

Since you can't be sure if the Elf is trying to help you or trick you, you should calculate the score you would get if you were to follow the strategy guide.

For example, suppose you were given the following strategy guide:

```
A Y
B X
C Z
```

This strategy guide predicts and recommends the following:

    In the first round, your opponent will choose Rock (A), and you should choose Paper (Y). This ends in a win for you with a score of 8 (2 because you chose Paper + 6 because you won).
    In the second round, your opponent will choose Paper (B), and you should choose Rock (X). This ends in a loss for you with a score of 1 (1 + 0).
    The third round is a draw with both players choosing Scissors, giving you a score of 3 + 3 = 6.

In this example, if you were to follow the strategy guide, you would get a total score of 15 (8 + 1 + 6).

What would your total score be if everything goes exactly according to your strategy guide?

Answer: 13052

--- Part Two ---

The Elf finishes helping with the tent and sneaks back over to you. "Anyway, the second column says how the round needs to end: X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win. Good luck!"

The total score is still calculated in the same way, but now you need to figure out what shape to choose so the round ends as indicated. The example above now goes like this:

    In the first round, your opponent will choose Rock (A), and you need the round to end in a draw (Y), so you also choose Rock. This gives you a score of 1 + 3 = 4.
    In the second round, your opponent will choose Paper (B), and you choose Rock so you lose (X) with a score of 1 + 0 = 1.
    In the third round, you will defeat your opponent's Scissors with Rock for a score of 1 + 6 = 7.

Now that you're correctly decrypting the ultra top secret strategy guide, you would get a total score of 12.

Following the Elf's instructions for the second column, what would your total score be if everything goes exactly according to your strategy guide?

Answer: 13693

# Solution

# First iteration
In the first iteration, I was pretty happy with the code that I had written. I felt that it was pretty clean and 
had a couple parts that could be adopted for reuse. The reuse value on this challenge felt pretty low, there was
a lot more domain and application logic than in the first one, and made for all around less "useful" code. The parts
that were there, I made sure to identify and write in a way that allow me to use again should I need to. To solve this
challenge, originally, I used the same mindset that I did with my `day_1` refactor, I knew that I would need to parse a
file of input data, and so I create another "`File`-esque" class, only difference with this and the `day_1` file class,
is this class would parse a file and translate the lines into how I wanted them. I call this `TranslatedFile` and it has
a `readlines` method on it that accepts a translator object that it uses to translate the file lines. I wanted to use this
class to translate all of the letters into the numbers(points) for a given shape. I figured that having them already translated
for me off the get-go, would be extremely beneficial. I was then able to use the translated file array and iterate over each line
taking the translated line and passing them into a new object that I called, `RoundScore`, which would calculate the score for
that round. In this class, I ultimately landed on using a matrix to determine the points for a round(It did not start off that
way and I'll speak on that). Then once I had an array of my points for each given round, I obviously used the `Array#sum` method
to get the total score.

This challenge took me a long time to figure out, not because it was difficult, which was the extremely frustrating
part about how long it ended up taking me. Upon first glance, my code appeared as if it should be working, all my tests 
were passing, even when I ran the code against the test data that was provided from Advent. I was perplexed and spent a 
lot of time and effort trying to debug, it finally took me asking one of my colleagues at work, if they would mind putting 
a second pair of eyes on my code on the code that I had written. And of course, I was overlooking one thing, that was 
allowing  it to pass the test data, but not work on the real data set. I wasn't ensuring that rock beat scissors in my conditional...
\*facepalm\* Oh well, we all need a little help sometimes and I am not above asking for help. I just had to hide my pride
when he told me. Plus that led me down a path of figuring out how to get rid of a nasty conditional, which I was ultimately
able to do with a matrix.

# Second iteration
Second iteration didn't change much from the first. I realized that with the scope creep introduced in
part 2, that I could still solve the challenge using a matrix, I just needed to be able to use a different matrix
than in part 1. I first approached this by introducing a new "RoundScore" class, that could be used as a strategy
but quickly found out that there were many similarities and that my class two strategy classes felt like they could
benefit from a base class to hold the common logic. I abonded this shortly after, as it appeared that the only thing
changing was the matrix. I decided that the matrix would have to live outside of my class and be passed in. I started
considering, definining a method for each parts matrix and adding some logic to call the correct method at runtime, however,
I was not fond was this idea, as I began to ask myself, what would happen if my Game class needed to support a new point
strategy. I decided that the best move would be to inject the matrix needed and default to part one's matrix. This abided by
the "open for extension, closed for modification" principle. Now I could just define a matrix elsewhere and pass it in and
my class doesn't bat an eye. Plus something about removing the matrix from the "RoundScore" class, made me realize, that I
didn't think that class was real useful and decided to scrap it. Which, I'm glad I was able to because I really hated the name
"RoundScore", it made me think of "rounding" the score and I didn't like that. Overall, I didn't have to change much. It's a
good feeling when you don't have to change much, because it means that you wrote clean and SOLID code! :)
