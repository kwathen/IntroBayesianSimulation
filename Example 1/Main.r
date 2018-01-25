########################################################################
#   This is the main file for conducting the simulate.  
########################################################################

# The next line will remove the contents of the work space.  This is done to 
# reduce the likelyhood of bugs or inadvertnetly using a variable in the global 
# enrironment rather than a local function due to a typo
remove( list=ls() )

#Source the files in the project
source( "SimulatePatientOutcome.R")
source( "SimulateTrial.R")
source( "AnalysisMethods.R")


#Define the input variables.  Helpful to define variables so they can easily be modified without
# changing values in the program

nMaxQtyOfPats       <- 200      # The maximum quantitiy of patients to enroll in the study
dQtyPatsPerMonth    <- 7        # Number of patients that will be enrolled each month

#Priors: Q_S ~ Beta( 0.2, 0.8 ); Q_E ~ Beta( 0.2, 0.8 )
dAS     <- 0.2  
dBS     <- 0.8

dAE     <- 0.2  
dBE     <- 0.8

# Decision criteria  At the end of the study E will be selected if
# Pr( Q_E > E_S | data ) > dPU

dPU     <- 0.9                  