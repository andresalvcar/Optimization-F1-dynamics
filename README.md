# Optimization-F1-dynamics

Everyday, in motorsport ambit, engineers, mathematicians and physicists study how
to improve the performance of a competition car. In this report we will study, from a mathematical point of view, the minimum time vehicle manoeuvring problem.

With the aim of solving this problem, we start by defining an optimal control problem, which will provide us the optimal speeds and accelerations over a fixed path. The calculus of the optimal speed for a given path is implemented in Matlab and numerical results will be seen for different circuits. Once we computed the optimal speeds,
we will note about the importance of updating the path for improving the fast lap.

In this repository we find the different packages and Matlab scripts needed to compute the optimal speed, the lateral forces and the best lap time. 

# Results

## Example Circuit

<img src="https://user-images.githubusercontent.com/91897666/198269731-adbbce0c-52c4-4501-8273-ce2752ccb288.png" width = "300" height="250">

For this example, we will use the clockwise circuit above this text. This track has different sections, such as straights, chicanes and open turns. The different parts of this circuit are colorized, so it will be easier to distinguish to visualize the different sections: Green for the straights, red for right turns, black for left turns and cyan for the right open turn.

The track is discretized for making this problem computationally feasible.

<img src="https://user-images.githubusercontent.com/91897666/198272116-6afa4662-6efe-40a7-97f9-98c60ca13c77.png" width = "300" height="250">

## Friction Circle

Once the layout and the car dynamics are modelled and the code is executed, we obtain our desired results. The first metric obtained is the optimal [friction circle](https://www.caranddriver.com/features/a15129563/how-to-read-a-friction-circle/). 

<img src="https://user-images.githubusercontent.com/91897666/198276476-5adaebaf-0057-4500-85ea-7f1c24a5fbc0.png" width = "300" height="225">

The green points (straights) minimize the lateral forces and maximize the longitudinal forces (acceleration and breaking). Some of this points cannot been seen because they are superimposed between themselves. On the other hand, the points of the curves maximize the lateral forces and minimize the longitudinal forces. This means that, if the car accelerates in the middle of the turn, it will lose the control. 

## Acceleration, breaking and direction graphs

These 2 graphics show us the evolution of the longitudinal and lateral forces of the car along the circuit. These forces were optimized by our Matlab programs. 

<img src="https://user-images.githubusercontent.com/91897666/198279315-5f35e875-9c6a-40a7-9d6a-f24416055886.png" width = "350" height="250">

The first image represents the state of the driver's accelerator and breaking pedals. If the value is 7.5 it means that our fiction driver is pressing the accelerator pedal at its maximum point. On the other hand, when the graph reach the -10 value, the breaking pedal is totally pressed. 

We can appreciate that, when the car is in a straight (green) the car is accelerating as much as it cans. When the driver is approaching the curve, he begins to take his foot off the throttle and starts to press the breaking pedal with the aim to enter smoothly into the turn.

The second graph corresponds to the steering wheel state. If the car is along the straights the steering wheel is in the neutral position but, when the driver is on a curve, then the steering wheel is moved to the desired direction. The value is positive for left turns (black) and negative for right turns (red and cyan). 

## Velocity graphs

<img src="https://user-images.githubusercontent.com/91897666/198284952-21991f96-c4a7-4ffd-8b58-360984c00aef.png" width = "350" height="250">

The upper graphs show us the tangencial velocity, the tangencial acceleration and the normal acceleration. We are not talking about the last two of them because they correspond to the longitudinal and lateral forces that we mencioned before. 

We decided that our car has to begin the lap in a repose state, so it will be easier to appreciate the velocity evolution along the circuit. As we can assume, the car reaches the maximum velocities in the straights and it slow down in the curves. As we mentioned before, the cyan curve has a bigger radius than the black and red curves. Having a bigger radius means that the curvature is lower, so we can deduct that the driver can go faster in this kind of curve. The graphic affirms our suspicions and we can see that the car goes faster in the cyan section than the red and black sections. 

## Optimal paths along the circuit

To conclude, we are going to show 4 different paths along our circuit and check which one is the best of them. All the pictures has a number above them. This number represents the lap time, so we want to reach the path that provides the fastest time. 

<img src="https://user-images.githubusercontent.com/91897666/198293117-3c4bc5a1-c1c9-4a30-8dcc-64c2af68ad5d.png" width = "350" height="300">

The path that goes through the outside of the circuit is clearly the slowest of all of them. A priori, we can think that the path that goes through the inside of the layout could be the faster, because in this way the car travels less distance. The problem with this path is that it forces the car to take all the curve from the inside, so the driver has to break the most of the time. Finally, we have a layout that makes a combination of movements along the circuit, taking the curves as much open as it can. This path provide us the optimal time for our F1 car. 



