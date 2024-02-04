# Physics-inspired-optimization-algorithms
Developing and improving different population based metaheuristic optimization algorithms inspired by various physics phenomneon such as water evaporation, big bang theory, elastic collisions, electrostatic and couloumbic forces and so on. The algotithms are tested on a raNge of objective functions, from simple parobolics to egg crate function.

## General algorithm template 
 
1. Initializing: 
   Sets the number of design variables (nV) , and defines the lower (Lb) and upper (Ub) bounds of the design variables.
   Defines parameters specific to the particular algorithm, including the number of particles which represents a solution each (nP), maximum number of objective function    evaluations (maxNFEs), and other control parameters (beta, alpha)

2. Starting solution: Initializes a population of solutions (P) randomly within the defined bounds.
3. Evaluating initial population: Calculates the fitness of each solution in the initial population using a predefined objective function (fobj).
4. Identification of best initial solution: Determines the best solution from the initial population based on the objective function.
5. Reiterative algorithm body: Initializes counters for the number of objective function evaluations (NFEs) and algorithm iterations (NITs).
6. In each iteration, performs the following: Generates a new population (newP). Visualizes the objective function and the new population on a 3D plot. Evaluates the fitness      of the new population. Updates the best solution if a better one is found. Outputs iteration information and saves results for post-processing.
7. Visualising results: Plots performance metrics (like minimum, maximum, and mean penalized objective function) across iterations.

## Big Bang Big Crunch 
Just like particles in the universe move from being well-ordered to chaotic in the Big Bang, we try to replicate the reverse in our algorithm. The algorithm starts by exploring a wide range of solutions. Then, the Big Crunch where things come together, the algorithm narrows down to the best solution.

Evaluative functions used: 
- Center of Mass: calulated in the Big Crunch phase, and influenced by the current best Pfit value. higher weightage to better fit 
- New solution set: generated in the Big Bang phase, also influenced by alpha and beta which are parameters we set to influence how chaotic we want the dispersal to be and how strongly the convergence to be respectively 

## Charged System Search
In the Charged System Search (CSS) algorithm, each solution is treated as a charged particle. The strength of its charge depends on how good the solution is, similar to how particles with different charges interact in nature, the ones with highest charge have the strongest attraction forces. Solutions then attract or repel each other, guiding the algorithm towards the best solution based on their 'fitness' and distance apart.

Evaluative functions used: 
- The function denotes random charges to each particle in the beginning and then updates them based on their respective fitness functions and quality. It does this by determining the charge of magnitude (q) vector, the separation distance (r) matrix, and the resultant electrical force (f) matrix of charged particles based on the Coulomb and the Gaussian laws. 
- Attraction probability function, a matrix which holds the value of probability of attraction for each charged particle depending on its pfit value
- Newtonian laws: Determine the new positions of the charged particles and updates the velocity vector.
- Harmony: Corrects the positioning of the particles if they leave the defined boundaries using a search and correcting process.
- Memory: Updates the charge particles memory matrix which stores the equivalent values of electrostatic potential pf charged particles, which is their pfit values. The pfit vaues dictate how much potential each charge has. Also updates the vectors of objective function memory (Fit_M) and penalized objective function memory (PFit_M) 

## Colliding Bodies optimization
The Collision-Based Optimization (CBO) algorithm demonstrates how interaction leads to equilibrium. Each solution is seen as a solid body in motion. Like objects colliding in the physical world, these solutions 'collide' with each other in the search space, aiming to reduce their energy level to a minimum, which is meant to happen at the optimal solution.

Evaluative functions used: 
- Collision: Calculates the velocity of bodies after collision. Here COR represents the Coefficient of Restitution, VMB is the vector that stores the velocity of the bodies before collision and the stepsize vector stores the velocity of the bodies after collision.
- Mass vector: the solutions are given certain mass and that value is uodated over iterations to govern how important or effective each solution is. Since the netwon formulas naturally operate on finding equilibrium favoured to objects of higher mass, this denotion of mass gives importance to solutions with lower Pfit values. 


