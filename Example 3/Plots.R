
pdf( file = "Scenario1VirtualTrials1-3.pdf", width = 8.5, height = 11 )
par( mfrow =c( 3, 3), cex= 0.8)
#Source the files in the project
source( "SimulatePatientOutcome.R")
source( "SimulateTrial.R")
source( "AnalysisMethods.R")
source( "Functions.R")
source( "Randomizer.R")
source( "StoppingRules.R")

# possibly 333
# 777 is all bad
# Null case used starting seed of 123
# alt scen used 333 or 777
set.seed(123)
vSeed <- round( runif( 4, 0, 10000))

vSeed <- vSeed[ c(1,2,4,3)] # Swap the order of the virtual trials so that the 4 one is the one that stop early, only done for consistancy 
                            # in the book chapter
#Define the input variables.  Helpful to define variables so they can easily be modified without
# changing values in the program

nMaxQtyOfPats       <- 200      # The maximum quantity of patients to enrol in the study
nMinQtyOfPats       <- 30      # The minimum number of patients enrolled before the trail adapts or stops for futility/superiority
vQtyPatsPerMonth    <- c(10) #c( 1, 1.5, 2, 3, 5, 7, 10, 15, 22, 25 )  #Each element represents the expected # of patients recruited, then the recruitment stays 25/month

#Priors: Q_S ~ Beta( 0.2, 0.8 ); Q_E ~ Beta( 0.2, 0.8 )
dPriorAS     <- 0.3  
dPriorBS     <- 0.7

dPriorAE     <- 0.3  
dPriorBE     <- 0.7

# Parameters that impact the design of the study
dPU             <- 0.995     # Pr( Q_E > E_S | data ) > dPU
dMinRandProb    <- 0      # Minimum randomization probability to either arm during the adapting phase
dExponent       <- 0    # Exponent used to "tune" the randomization; dProbSGrtE = Prob S is "Better" than E
# Randomize to S with probability dRandProbTrtS = (dProbSGrtE)^dExponent/( (dProbSGrtE)^dExponent + (1 - dProbSGrtE)^dExponent )
# Randomize to E with probability dRandProbTrtE = 1 - dRandProbTrtS      


#Create the "true" parameter values for a scenario -  for this example we are simulating the null case, eg both treatments
#have the same true response rate.  
dTrueRespRateS  <- 0.3      # A true response rate of 0.2 for S
dTrueRespRateE  <- 0.3      # A true response rate of 0.2 for E

nQtyPatsBetweenUpdates <- 10 # Set to NA for always updating
####################################################################################################################################
#It is often best to simulate a single trial and look at the result many times, before launching a loop with many virtual trial
####################################################################################################################################
for( iTrial in 1:3 )
{
    set.seed( vSeed[ iTrial ])
    
    lSimulatedTrial <- SimulateSingleTrial( nMaxQtyOfPats,  nMinQtyOfPats, vQtyPatsPerMonth,  dPriorAS,  dPriorBS, dPriorAE, dPriorBE,  
                                            dPU, dMinRandProb, dExponent,  dTrueRespRateS, dTrueRespRateE, nQtyPatsBetweenUpdates  )
    
    #It is often very educational to simulate several trials and plot the randomization probabilities
    nQtyPatsEnrolled <- sum( lSimulatedTrial$vQtyPats )
    plot( 1:nQtyPatsEnrolled, lSimulatedTrial$vRandProbE, type='l', xlab="Patient", ylab="Randomization Probability E", 
           main= paste0( "Virtual Trial ", iTrial + 3), 
           ylim=c(-0.05,1), xlim=c(1,nMaxQtyOfPats+20), lwd=2 )
    if( dMinRandProb != 0 )
        abline( h=c(0.5, dMinRandProb, 1- dMinRandProb), v=20, lty=3)
    else
        abline( h=c(0.5), v=20, lty=3)
    vSS <- c(  30, 100, 150, 200 )
    for( i in 1:length( vSS) )
    {
        nE <-  sum(lSimulatedTrial$vTreat[1:vSS[i] ])
        nS <- vSS[i] - nE
        text( vSS[i], -0.05, paste0( "E:", nE, " S:", nS), adj = 0.5, cex =0.55)
    }
       
    
}





set.seed(333)
vSeed <- round( runif( 4, 0, 10000))

vSeed <- vSeed[ c(1,2,4,3)] # Swap the order of the virtual trials so that the 4 one is the one that stop early, only done for consistancy 
# in the book chapter
#Define the input variables.  Helpful to define variables so they can easily be modified without
# changing values in the program

nMaxQtyOfPats       <- 200      # The maximum quantity of patients to enrol in the study
nMinQtyOfPats       <- 30      # The minimum number of patients enrolled before the trail adapts or stops for futility/superiority
vQtyPatsPerMonth    <- c(10) #c( 1, 1.5, 2, 3, 5, 7, 10, 15, 22, 25 )  #Each element represents the expected # of patients recruited, then the recruitment stays 25/month

#Priors: Q_S ~ Beta( 0.2, 0.8 ); Q_E ~ Beta( 0.2, 0.8 )
dPriorAS     <- 0.3  
dPriorBS     <- 0.7

dPriorAE     <- 0.3  
dPriorBE     <- 0.7

# Parameters that impact the design of the study
dPU             <- 0.995     # Pr( Q_E > E_S | data ) > dPU
dMinRandProb    <- 0      # Minimum randomization probability to either arm during the adapting phase
dExponent       <- 1    # Exponent used to "tune" the randomization; dProbSGrtE = Prob S is "Better" than E
# Randomize to S with probability dRandProbTrtS = (dProbSGrtE)^dExponent/( (dProbSGrtE)^dExponent + (1 - dProbSGrtE)^dExponent )
# Randomize to E with probability dRandProbTrtE = 1 - dRandProbTrtS      


#Create the "true" parameter values for a scenario -  for this example we are simulating the null case, eg both treatments
#have the same true response rate.  
dTrueRespRateS  <- 0.3      # A true response rate of 0.2 for S
dTrueRespRateE  <- 0.3      # A true response rate of 0.2 for E

nQtyPatsBetweenUpdates <- 10 # Set to NA for always updating
####################################################################################################################################
#It is often best to simulate a single trial and look at the result many times, before launching a loop with many virtual trial
####################################################################################################################################
for( iTrial in 1:3 )
{
    set.seed( vSeed[ iTrial ])
    
    lSimulatedTrial <- SimulateSingleTrial( nMaxQtyOfPats,  nMinQtyOfPats, vQtyPatsPerMonth,  dPriorAS,  dPriorBS, dPriorAE, dPriorBE,  
                                            dPU, dMinRandProb, dExponent,  dTrueRespRateS, dTrueRespRateE, nQtyPatsBetweenUpdates  )
    
    #It is often very educational to simulate several trials and plot the randomization probabilities
    nQtyPatsEnrolled <- sum( lSimulatedTrial$vQtyPats )
    plot( 1:nQtyPatsEnrolled, lSimulatedTrial$vRandProbE, type='l', xlab="Patient", ylab="Randomization Probability E", 
          main= paste0( "Virtual Trial ", iTrial + 3), 
          ylim=c(-0.05,1), xlim=c(1,nMaxQtyOfPats+20), lwd=2 )
    if( dMinRandProb != 0 )
        abline( h=c(0.5, dMinRandProb, 1- dMinRandProb), v=20, lty=3)
    else
        abline( h=c(0.5), v=20, lty=3)
    vSS <- c(  30, 100, 150, 200 )
    for( i in 1:length( vSS) )
    {
        nE <-  sum(lSimulatedTrial$vTreat[1:vSS[i] ])
        nS <- vSS[i] - nE
        text( vSS[i], -0.05, paste0( "E:", nE, " S:", nS), adj = 0.5, cex =0.55)
    }
    
    
}




set.seed(333)
vSeed <- round( runif( 4, 0, 10000))

vSeed <- vSeed[ c(1,2,4,3)] # Swap the order of the virtual trials so that the 4 one is the one that stop early, only done for consistancy 
# in the book chapter
#Define the input variables.  Helpful to define variables so they can easily be modified without
# changing values in the program

nMaxQtyOfPats       <- 200      # The maximum quantity of patients to enrol in the study
nMinQtyOfPats       <- 30      # The minimum number of patients enrolled before the trail adapts or stops for futility/superiority
vQtyPatsPerMonth    <- c(10) #c( 1, 1.5, 2, 3, 5, 7, 10, 15, 22, 25 )  #Each element represents the expected # of patients recruited, then the recruitment stays 25/month

#Priors: Q_S ~ Beta( 0.2, 0.8 ); Q_E ~ Beta( 0.2, 0.8 )
dPriorAS     <- 0.3  
dPriorBS     <- 0.7

dPriorAE     <- 0.3  
dPriorBE     <- 0.7

# Parameters that impact the design of the study
dPU             <- 0.995     # Pr( Q_E > E_S | data ) > dPU
dMinRandProb    <- 0.1      # Minimum randomization probability to either arm during the adapting phase
dExponent       <- 1    # Exponent used to "tune" the randomization; dProbSGrtE = Prob S is "Better" than E
# Randomize to S with probability dRandProbTrtS = (dProbSGrtE)^dExponent/( (dProbSGrtE)^dExponent + (1 - dProbSGrtE)^dExponent )
# Randomize to E with probability dRandProbTrtE = 1 - dRandProbTrtS      


#Create the "true" parameter values for a scenario -  for this example we are simulating the null case, eg both treatments
#have the same true response rate.  
dTrueRespRateS  <- 0.3      # A true response rate of 0.2 for S
dTrueRespRateE  <- 0.3      # A true response rate of 0.2 for E

nQtyPatsBetweenUpdates <- 10 # Set to NA for always updating
####################################################################################################################################
#It is often best to simulate a single trial and look at the result many times, before launching a loop with many virtual trial
####################################################################################################################################
for( iTrial in 1:3 )
{
    set.seed( vSeed[ iTrial ])
    
    lSimulatedTrial <- SimulateSingleTrial( nMaxQtyOfPats,  nMinQtyOfPats, vQtyPatsPerMonth,  dPriorAS,  dPriorBS, dPriorAE, dPriorBE,  
                                            dPU, dMinRandProb, dExponent,  dTrueRespRateS, dTrueRespRateE, nQtyPatsBetweenUpdates  )
    
    #It is often very educational to simulate several trials and plot the randomization probabilities
    nQtyPatsEnrolled <- sum( lSimulatedTrial$vQtyPats )
    plot( 1:nQtyPatsEnrolled, lSimulatedTrial$vRandProbE, type='l', xlab="Patient", ylab="Randomization Probability E", 
          main= paste0( "Virtual Trial ", iTrial + 3), 
          ylim=c(-0.05,1), xlim=c(1,nMaxQtyOfPats+20), lwd=2 )
    if( dMinRandProb != 0 )
        abline( h=c(0.5, dMinRandProb, 1- dMinRandProb), v=20, lty=3)
    else
        abline( h=c(0.5), v=20, lty=3)
    vSS <- c(  30, 100, 150, 200 )
    for( i in 1:length( vSS) )
    {
        nE <-  sum(lSimulatedTrial$vTreat[1:vSS[i] ])
        nS <- vSS[i] - nE
        text( vSS[i], -0.05, paste0( "E:", nE, " S:", nS), adj = 0.5, cex=0.55)
    }
    
    
}




dev.off()



