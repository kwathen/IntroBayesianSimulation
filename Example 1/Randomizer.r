
#####################################################################################
#   Function to get the treatment for a patient.
#   dProbTrt1 = probability that patients receive treatment 1 (in this case E)
#####################################################################################
GetTreatment <- function( dProbTrt1 )
{
    nTrt <- rbinom( 1, 1, dProbTrt1 )
    return( nTrt )
}