
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
source( "StoppingRules.R")


#Define the input variables.  Helpful to define variables so they can easily be modified without
# changing values in the program

nMaxQtyOfPats       <- 200      # The maximum quantity of patients to enrol in the study
nMinQtyOfPats       <- 20       # The minimum number of patients enrolled before the trail adapts or stops for futility/superiority
vQtyPatsPerMonth    <- c( 1, 1.5, 2, 3, 5, 7, 10, 15, 22, 25 )  #Each element represents the expected # of patients recruited, then the recruitment stays 25/month

#Priors: Q_S ~ Beta( 0.2, 0.8 ); Q_E ~ Beta( 0.2, 0.8 )
dPriorAS     <- 0.2  
dPriorBS     <- 0.8

dPriorAE     <- 0.2  
dPriorBE     <- 0.8

# Parameters that impact the design of the study
dPU             <- 1.0     # Pr( Q_E > E_S | data ) > dPU
dMinRandProb    <- 0.0      # Minimum randomization probability to either arm during the adapting phase
dExponent       <- 1.0      # Exponent used to "tune" the randomization; dProbSGrtE = Prob S is "Better" than E
# Randomize to S with probability dRandProbTrtS = (dProbSGrtE)^dExponent/( (dProbSGrtE)^dExponent + (1 - dProbSGrtE)^dExponent )
# Randomize to E with probability dRandProbTrtE = 1 - dRandProbTrtS      


#Create the "true" parameter values for a scenario -  for this example we are simulating the null case, eg both treatments
#have the same true response rate.  
dTrueRespRateS  <- 0.2      # A true response rate of 0.2 for S
dTrueRespRateE  <- 0.2      # A true response rate of 0.2 for E

nQtyReps        <- 1000     # The number of virtual trials to simulate

####################################################################################################################################
#It is often best to simulate a single trial and look at the result many times, before launching a loop with many virtual trial
####################################################################################################################################
)
par( mfrow=c(2,2))
vLabMain <- c("A","B","C","D" )
for( i in 1:4 )
{
    lSimulatedTrial <- SimulateSingleTrial( nMaxQtyOfPats,  nMinQtyOfPats, vQtyPatsPerMonth,  dPriorAS,  dPriorBS, dPriorAE, dPriorBE,  
                                            dPU, dMinRandProb, dExponent,  dTrueRespRateS, dTrueRespRateE  )
    
    #It is often very educational to simulate several trials and plot the randomization probabilities
    nQtyPatsEnrolled <- sum( lSimulatedTrial$vQtyPats )
    plot( 1:nQtyPatsEnrolled, lSimulatedTrial$vRandProbE, type='l', xlab="Patient", ylab="Randomization Probability E", ylim=c(0,1), xlim=c(1,nMaxQtyOfPats), lwd=2, main= vLabMain[i], cex=1.5 )
    abline( h=c(0.5, dMinRandProb, 1- dMinRandProb), v=nMinQtyOfPats, lty=3)
}
