//=======================================================================
// Numerical approximation to the cumulative normal distribution
// See Abramowitz & Stegun 26.2.17  |error| < 7.5e-8 
//=======================================================================
// Inverse cumulative normal distribution function
// by Peter J. Acklam, University of Oslo, Statistics Division.
// http://www.math.uio.no/~jacklam/notes/invnorm
//=======================================================================
 
#include "ndist.h"
#include <math.h>

#define ONE_OVER_SQRT_TWO_PI  0.3989422804014326779399460599343818684758586311649
#define SQRT_TWO_PI           2.506628274631000502415765284811045253006986740610
#define A1 -3.969683028665376e+01
#define A2  2.209460984245205e+02
#define A3 -2.759285104469687e+02
#define A4  1.383577518672690e+02
#define A5 -3.066479806614716e+01
#define A6  2.506628277459239e+00
#define B1 -5.447609879822406e+01
#define B2  1.615858368580409e+02
#define B3 -1.556989798598866e+02
#define B4  6.680131188771972e+01
#define B5 -1.328068155288572e+01
#define C1 -7.784894002430293e-03
#define C2 -3.223964580411365e-01
#define C3 -2.400758277161838e+00
#define C4 -2.549732539343734e+00
#define C5  4.374664141464968e+00
#define C6  2.938163982698783e+00
#define D1  7.784695709041462e-03
#define D2  3.224671290700398e-01
#define D3  2.445134137142996e+00
#define D4  3.754408661907416e+00
#define E1  0.31938153
#define E2 -0.356563782
#define E3  1.781477937
#define E4 -1.821255978
#define E5  1.330274429
#define PP  0.2316419
#define LO  0.02425
#define HI  0.97575
 
double cnorm(double d){
 if(d==0.0)return 0.5;
 double t=1.0/(1.0+PP*fabs(d));
 double e= exp(-0.5*d*d)*ONE_OVER_SQRT_TWO_PI;
 double n=((((E5*t + E4)*t + E3)*t + E2)*t + E1)*t;
 return (d>0.0)? 1.0-e*n : e*n;
}

double invcnorm(double u){
 // outside need to check ( 0 < u && u < 1 );
 register double z,r;
 if(u<LO){
   z=sqrt(-2.0*log(u));
   z=(((((C1*z+C2)*z+C3)*z+C4)*z+C5)*z+C6) / ((((D1*z+D2)*z+D3)*z+D4)*z+1.0);
 }
 else if(u<=HI){
   z=u-0.5;
   r=z*z;
   z=(((((A1*r+A2)*r+A3)*r+A4)*r+A5)*r+A6)*z / (((((B1*r+B2)*r+B3)*r+B4)*r+B5)*r+1.0);
 }
 else{
   z=sqrt(-2.0*log(1.0-u));
   z=-(((((C1*z+C2)*z+C3)*z+C4)*z+C5)*z+C6) / ((((D1*z+D2)*z+D3)*z+D4)*z+1.0);
 }
 r=(cnorm(z)-u)*SQRT_TWO_PI*exp(0.5*z*z);
 z-=r/(1+0.5*z*r);
 return z;
}
