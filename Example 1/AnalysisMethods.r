########################################################################
#   This file contains all analysis methods.
########################################################################



#####################################################################################################################################
#    Name:  Inequality Calculator – Compare distributions of various types, Beta 
#    Location:  Analysis/BayesianComparePosteriors/InequalityCalculator.R
#    Keywords:  Inequality calculator, compare posteriors, posterior probability
#    Description:   Suppose you have q1 ~ Beta(a, b), q2 ~ Beta( c, d) and you want to calculate Pr( q1 > q2 ).  The inequality calculator can be used to compute this.  
#    Author Name:  J. Kyle Wathen
#####################################################################################################################################

# Compare 2 Beta distributions
# calculate the probability that one beta dist. is greater than another
IneqCalcBeta <- function(dA1,dB1,dA2,dB2) 
{
    ## 
    
    res <- integrate(fBetaIneqCalc,0,1, dA1 = dA1, dB1 = dB1, dA2 = dA2, dB2 = dB2)
    res$value
}

#Helper functions 
fBetaIneqCalc <- function(x, dA1, dB1, dA2, dB2){x**(dA1-1) * (1-x)**(dB1-1) * pbeta(x,dA2,dB2) / beta(dA1,dB1)}
