# Tailobatics
A multibody simulation of inertial reorientation with a tail, including trajectory optimization. Used to investigate the arboreal acrobatics of geckos. Implemented in Matlab using Simscape Multibody.

The simulink model is **TailFlip2DOF.mdl**
**TailobaticVariables.m** contains all of the constants used by **TailFlip2DOF.mdl**, and must be run first. The external springs acting on the body are turned on/off in this script.

**ProcessTailobatics.m**  processes the simulink data

Run **OptimiseTailobatics.m** to search for a tail trajectory

**simulateFlip.m** is the objective function used in the optimisation procedure

**PlotTailobatics.m** plots the final output of the optimisation.
