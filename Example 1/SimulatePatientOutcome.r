########################################################################
#   This file contains functions for simulating the patient data.
########################################################################
SimulatePatientOutcome <- function( nTreat, dTrueRespRateS, dTrueRespRateE )
{
    nOutcome <- NA
    if( nTreat == 0 )  # Patient received S
        nOutcome <- rbinom(1, 1, dTrueRespRateS )
    else if( nTreat == 1 )# Patient received E
        nOutcome <- rbinom(1, 1, dTrueRespRateE )
    else #There was an error in the input
        stop( paste( "Error: In function SimulatePatientOutcome an invalid nTeat = ", nTeat, " was sent into the function.  nTreat must be 0 or 1.") )
    
    return( nOutcome )
}
