// (c) Copyright 2019 , BRODA Ltd. All rights reserved.
// info@broda.co.uk 

/*
Specification:

	Successive calls to function
	int SobolSeq1024(long cnt, int ndim, double* SobolSeqVector);
	generate SobolSeqVector -  ndim- dimensional vector containing the Cartesian
	coordinates of the i-th point of the Sobol' sequence 
	uniformly distributed in the ndim-dimensional unit cube.
    Function returns 0 on success, else -1. 


   Input parameters:
     cnt    -   index of the point (cnt=[0,2**31-1]),
     ndim   -  dimension of the Sobol' sequence  ( 0 < ndim < 1025).
 
   Output parameter:
     SobolSeqVector -   pointer to a vector of double[ndim] containing the Cartesian
                   coordinates of the cnt-th point.
 
   Returns
     0 (success)
     1 (failure)

		Bibliography
   1. Sobol’, D. Asotsky, A. Kreinin, S. Kucherenko. Construction and Comparison of
	  High-Dimensional Sobol’ Generators, 2011, Wilmott Journal, Nov,
	  pp. 64-79 http://www.broda.co.uk/doc/HD_SobolGenerator.pdf
   2. http://www.broda.co.uk

*/

int SobolSeq1024(long cnt, int ndim, double *SobolSeqVector);