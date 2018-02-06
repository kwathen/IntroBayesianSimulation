# IntroBayesianSimulation
This repository is an introduction to Bayesian Clinical Trial simulation. 

Often when adaptive designs are used in clinical trials, simulations are utilized to better understand how the adaptation will impact the operating characteristics of the design and probability of a successful trial.  It is in the best interest of the clinical development team and the company developing the trial to consider a wide range of design options, ranging from a traditional approach to the completely adaptive approach and compare various aspects of the trial via simulation.   

This repository provides the examples discussed in Chapter XX of "BOOK TITLE".  The goal of this repository and chapter are to focus on how to develop the necessary R code simulate a Bayesian outcome adaptive randomization where randomization probabilities are altered prior to each patient enrolling and allow for the possibility of early stopping for superiority or futility.   The goal of this chapter is not to promote any one methodology or design approach, but rather to focus on the necessary steps and skills required to develop a custom simulation package.  Through a series of three examples, where each example builds on the previous, the R code necessary for simulation of the desired adaptive design is developed in a stepwise fashion.  As such, each example in this repository is a self-contained R project to simulate a design.  

Example 1: Simulate a fixed sample design that only conducts the analysis at the end of the study.

Example 2: Incorporate the adaptive randomization feature and make the time to observe the patients' outcome random.

Example 3: Extend the previous examples to include early stopping and a ramp up in accrual.  