########################################################################
#   This is the main file for conducting the simulate.  
########################################################################

# The next line will remove the contents of the work space.  This is done to 
# reduce the likelihood of bugs or inadvertently using a variable in the global 
# environment rather than a local function due to a typo
remove( list=ls() )

#Source the files in the project
source( "SimulatePatientOutcome.R")
source( "SimulateTrial.R")
source( "AnalysisMethods.R")
source( "Functions.R")
source( "Randomizer.R")


#Define the input variables.  Helpful to define variables so they can easily be modified without
# changing values in the program

nMaxQtyOfPats       <- 200      # The maximum quantity of patients to enrol in the study
nMinQtyOfPats       <- 20       # The minimum number of patients enrolled before the trail adapts or stops for futility/superiority
dQtyPatsPerMonth    <- 7.5      # Number of patients that will be enrolled each month, expectation is 7.5 patients per month

#Priors: Q_S ~ Beta( 0.2, 0.8 ); Q_E ~ Beta( 0.2, 0.8 )
dPriorAS     <- 0.2  
dPriorBS     <- 0.8

dPriorAE     <- 0.2  
dPriorBE     <- 0.8

# Decision criteria  At the end of the study E will be selected if
# Pr( Q_E > E_S | data ) > dPU
dPU             <- 0.90   


#Create the "true" parameter values for a scenario -  for this example we are simulating the null case, eg both treatments
#have the same true response rate.  
dTrueRespRateS  <- 0.2      # A true response rate of 0.2 for S
dTrueRespRateE  <- 0.2      # A true response rate of 0.2 for E

nQtyReps        <- 1000     # The number of virtual trials to simulate

#It is often best to simulate a single trial and look at the result many times, before launching a loop with many virtual trial
lSimulatedTrial <- SimulateSingleTrial( nMaxQtyOfPats,  nMinQtyOfPats, dQtyPatsPerMonth,  dPriorAS,  dPriorBS, dPriorAE, dPriorBE,  
                                        dPU, dTrueRespRateS, dTrueRespRateE  )

#It is often very educational to simulate several trial and plot the randomization probabilities
pwWindowslot( 1:nMaxQtyOfPats, lSimulatedTrial$vRandProbE, type='l', xlab="Patient", ylab="Randomization Probability E", ylim=c(0,1), lwd=2, main =vMain[nSeed] )
abline( h=0.5, v=20, lty=3)


vResults <- rep( NA, nQtyReps )
mQtyPats <- matrix( NA, ncol=2, nrow = nQtyReps)

i<-1
for( i in 1:nQtyReps )
{
    #It is often nice to provide feedback to users what stage of the simulation we are on.
    nNotify <- round( nQtyReps*0.1,0)
    if( i %% nNotify == 0 )
        print( paste( "Simulating virtual trial ", i, " of ", nQtyReps, " virtual trials."))
        
    lSimulatedTrial <- SimulateSingleTrial( nMaxQtyOfPats,  nMinQtyOfPats, dQtyPatsPerMonth,  dPriorAS,  dPriorBS, dPriorAE, dPriorBE,  
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
