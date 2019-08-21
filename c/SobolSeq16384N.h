// int SobolSeq16384N(long cnt, int ndim, double* SobolSeqVector);
// Inputs
//  cnt            -  idx of point (0<=cnt<=2**31-1)
//  ndim           -  dim of Sobol sequence  (0<ndim<=16384)
//  SobolSeqVector -  ptr to vector of double[ndim], containing Cartesian coordinates of cnt-th point
// Returns
//  0 (success)
//  1 (failure)

int SobolSeq16384N(long cnt, int ndim, double *SobolSeqVector);
