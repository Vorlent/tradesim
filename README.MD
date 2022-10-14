# A simple introduction to trade via barter and money

# Chapter 1: Barter and Say's Law

In classical economics, Say's law is the idea that people produce because
they expect to either consume the product for themselves
or that they want to trade their product for another product that suits their needs better.

In the first chapter, we will show a simple animation or puzzle game.
A graph of people is randomly generated or predefined.
Each person has a single consumption need and a single production skill.
Each person can only consume one commodity and produce one commodity.
For each person a commodity is randomly chosen and another person is randomly picked to be the producer.
Not every person is directly connected to another person that has the commodity they need.

Puzzle game: Show a very easy puzzle but constrain the order of transaction so that the player isn't able to win.

Simulation: A computer tries to solve the puzzle automatically through random choices.
The simulation may be deterministic for the sake of presentation.

Trading only has a very simple rule.

The the usefulness or utility of the product that is being given away must be below the utility of the product obtained through the trade.
People prefer the product they want to consume the most.
However, they will also prefer products that let them trade the product they want to consume.
If person A wants a banana but has an apple and person B has a banana but wants a pear and person C has a pear but wants an apple,
then it is rational for person A to obtain the pear because it can be traded for a banana.
In this three way exchange the ranking of the banana is #1, it has the highest utility, the pear which buys
the banana has the second highest utility and rank #2, the apple buys the pear and therefore has the third highest utility and rank #3.

In this scenario we are taking for granted that everyone knows what to produce.
Unsold inventory will not happen due to a consumption or prodution mismatch .

Yet strangely enough, even this basic setup is problematic.
Not everyone will have their needs satisfied even though
it is entirely possible to do so and unsold inventory remains
in the simulation if the order of transactions is suboptimal!

Everyone produces because someone else has a product they want to consume
and the counterparty produces because you or someone else has a product that
they want. Everyone should be happy, right?

It is not that easy. Barter has friction. If you can only barter with your neighbours,
then the order of transactions actually starts to matter.

This is because once a person has satisfied their own needs, they have no
further reason to engage in trading. They effectively drop out of the graph
and are replaced with a hole and since the old edges connecting the people
are now pointing at a hole, there is no need to keep them in the visualization.

However, the absolute positions of the remaining people stay the same.
Unless we somehow form a direct connection between distant people,
it is difficult for them to trade.

Trading and therefore barter involves friction.

Now, is it possible to optimize the order of transactions and
complete the barter game?

Puzzle game:

The player is allowed to choose who trades in what order.

Simulation:

The computer automatically determines an optimal transaction order.