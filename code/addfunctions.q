// q version of AddFunctions.cpp

// cnDist -  numerical approximation to the cumulative normal distribution
/* x = float
cndist:{
 if[0f~x:`float$x;:.5];
 t:1%1+i.cnvals[`PP]*abs x;
 e:exp[neg[.5]*x*x]%i.cnvals`ROOT_2PI;
 n:i.updfnc[1%1+i.cnvals[`PP]*abs x;1b]value 5#i.cnvals;
 $[0f<x;1.-;]e*n}

i.cnvals:`B1`B2`B3`B4`B5`PP`ROOT_2PI!
 (0.31938153;-0.356563782;1.781477937;-1.821255978;1.330274429;0.2316419;2.506628274631)