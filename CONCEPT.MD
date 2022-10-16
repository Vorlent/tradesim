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

Dagger Fall

Life Scale Cities instead of simplications

Build an economic simulation game like nend.io

Shores of Hazeron


Simpler Idea:

Build a simple economics agent modeling program based on transaction ordering.
There is a list of products.
There are economic agents who can produce exactly one product and demand exactly one product.
A producer and consumer are randomly chosen, they produce and consume a product of a random type.
Repeat this until every agent is a producer and consumer.
There is a transaction graph that connects economic agents with their neighbors.
Simulate a barter transaction sequence that can satisfy as many needs as possible.
Simulate a money transaction sequence that can satisfy as many needs as possible.

I need visualisation software for this. A zoomable and pannable view is necessary.


Complicated economic simulation:

https://docs.particubes.com/

Game Idea:

Omnifactory industry + Prosperous Universe style economy in a village/city simulation game.

Cities:

Players can found their own cities.

Cities consist of plots that can be bought by players.

The plots are arranged in a grid to make AI path finding easier.

Plots:

Players can build a company building on their plots. Equivalent to a base in Minecraft or Prosperous Universe.

For starters there will be player-buildable machines and workplaces.

A carpenter workbench can be used to produce wooden goods. A table saw can be used to cut wood etc.

Labor points:

Each day you get 800 labor points. Labor points limit the amount of work that can be done in a single real life day.

E.g. placing a block costs 4 labor points. Removing it costs 2 labor points.

Using the table saw costs 20 labor points. Meaning you can only saw 40 wooden panels per day.

Employees:

Instead of doing all work yourself you can hire villagers from Minecraft. Each villager provides 800 labor points per day.

Villagers are paid a salary per day. They can be assigned to jobs.

Skills:

Each specialization involves a primary skill.

Farming and mining are different skills. New players can learn their first skill much faster than old players.

Learning a new skill is possible but will be much harder than e.g. hiring a villager with the right skill.

The specialization skill gives a boost to productivity of workers that have the same specialization.

There can only be 3 specialization skills active at one time.

Buildings:

There will be different types of buildings.

Commercial buildings can be manufacturing buildings or shops that sell to villagers.

Company buildings for players

Residential buildings for villagers. These buildings can be owned by players who rent the house out.

Transportation:

Villagers will use pathfinding to walk from their home to work.
They will also use pathfinding to deliver products from one building to another.
Cars can be used to increase cargo capacity and speed up transport.
Cars will require asphalt roads to be constructed.
Pedestrians will need sidewalks next to asphalt roads or they will share the road with cars and slow them down.

Market mechanism:

Each company will have the ability to put a mini shop in their company building. That mini shop will buy raw resources and sell finished goods.
Each mini shop will be listed on a commodity exchange. Similar to Star Sonata's item price lookup feature.
That mini shop has to be staffed by a villager.



Terrain generation:

I honestly don't care. I want it to look good and I want resource deposits to be positioned in a way that encourages small boom towns,
that are dependent on a single resource.

Path finding will be a challenge with arbitrary terrain.

The world might need to be restricted in its maximum size. We don't want players to run away from each other.
It shouldn't take more than 30 min of walking to reach the end from the center.


OpenTTD

Daggerfall Inspiration:

Daggerfall has a large scale world and each town actually is life scale, this means a town actually consists of thousands of houses and thousands of NPCs living in them.

Economic Agent simulation:

A big problem with the economic simulation is to provide realistic economic agent behavior.

Economic agents have well defined physical needs according to their body but also subjective needs that are randomly determined.
Even among basic necessities like food there is variation. A person may need food which means human_food must be a tag on consumer goods meant for human consumption,
however

Commodities:

Services:

Abilities:

Research:

Knowledge:

Production:

Consumption:

Employment:

Trade:

Land:

Resources:

Space:

Military:

Investment:

Company forms:

Laws:

Regulations:

Transportation:

Communication:

Housing:

Storage:

Energy:

Banking:

Human Centric:

Sustenance:

Aging:

Disease:

Genes:

Entertainment:

Reproduction:

Education:

Healthcare:

Emotion:

Hygene:

Relationships:

Self preservation instinct:
s