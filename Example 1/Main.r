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
source( "Functions.R")
source( "Randomizer.R")


#Define the input variables.  Helpful to define variables so they can easily be modified without
# changing values in the program

nMaxQtyOfPats       <- 200      # The maximum quantitiy of patients to enroll in the study
dQtyPatsPerMonth    <- 7.5      # Number of patients that will be enrolled each month, expectation is 7.5 patients per month

#Priors: Q_S ~ Beta( 0.2, 0.8 ); Q_E ~ Beta( 0.2, 0.8 )
dPriorAS     <- 0.2  
dPriorBS     <- 0.8

dPriorAE     <- 0.2  
dPriorBE     <- 0.8

# Decision criteria  At the end of the study E will be selected if
# Pr( Q_E > E_S | data ) > dPU
dPU             <- 0.90   


#Create the "true" paramter values for a scenario
dTrueRespRateS  <- 0.2      # A true response rate of 0.2 for S
dTrueRespRateE  <- 0.2      # A true response rate of 0.4 for E

nQtyReps        <- 10     # The number of virtual trials to simulate

#It is often best to simulate a single trial and look at the result many times, before launching a loop with many virtual trial
lSimulatedTrial <- SimulateSingleTrial( nMaxQtyOfPats,  dQtyPatsPerMonth,  dPriorAS,  dPriorBS, dPriorAE, dPriorBE,  
                                        dPU, dTrueRespRateS, dTrueRespRateE  )


vResults <- rep( NA, nQtyReps )
mQtyPats <- matrix( NA, ncol=2, nrow = nQtyReps)

i<-1
for( i in 1:nQtyReps )
{
    
    lSimulatedTrial <- SimulateSingleTrial( nMaxQtyOfPats,  dQtyPatsPerMonth,  dPriorAS,  dPriorBS, dPriorAE, dPriorBE,  
                                            dPU, dTrueRespRateS, dTrueRespRateE  )
   
    vResults[ i ]   <- lSimulatedTrial$nDecision
    mQtyPats[ i, ]  <- lSimulatedTrial$vQtyPats
}


#Create simple summaries

print( paste( "The probability the trial will select no treatment is ", length( vResults[ vResults == 1])/ nQtyReps))
print( paste( "The probability the trial will select S is ", length( vResults[ vResults == 2])/ nQtyReps))
print( paste( "The probability the trial will select E is ", length( vResults[ vResults == 3])/ nQtyReps))

vAveQtyPats <- apply( mQtyPats, 2, mean)
print( paste("The average number of patient on S is ", vAveQtyPats[1]))
print( paste("The average number of patient on E is ", vAveQtyPats[2]))
