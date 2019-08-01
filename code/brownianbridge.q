// q version of BrownianBridge.cpp
/  Original reference: Copyright (C) 2002 "Monte Carlo Methods in Finance". All rights reserved.

\l ../code/bitshift.p
bitshift:.p.get[`bitshift;<]  / equivalent to bitshift operators (>>;<<)in C++/Python

// BrownianBridge
/* n  = number of steps
/* dt = delta T
bbridge:{[n;dt]
 if[0>=n;'`$"number of steps must be greater than 0"];
 d:`map`bidx`sigma`lweight`rweight`lidx`ridx!(7;n)#0.;
 d:i.initbb[n;dt]/[d;til n];
 first i.updbb[n;dt]/[(d;0);-1_1+til n]}

// buildPath
/ * bb = Brownian Bridge dict w/ `map`bidx`sigma`lweight`rweight`lidx`ridx, size:7xn
/ * gv = Gaussian Variates (list of floats) 
/ * path = list of floats
buildpath:{[n;bb;gv;path]
 if[(n<>count gv)&n<>count path;'`"inputs must have size equal to n"];
 path[n-1]:bb[`sigma;0]*gv 0;  / global step
 i.updpath[n;bb;gv]/[path;-1_1+til n]}

i.initbb:{[n;dt;d;i]
 d[`lweight;0]:d[`rweight;0]:d[`map;i]:0.;
 d[`map;n-1]:1.;         / first pt in construction is global step
 d[`bidx;0]:n-1.;        / global step constructed from first variate
 d[`sigma;0]:sqrt n*dt;  / variance of global step = n*dt
 d}
i.updbb:{[n;dt;dj;i]
 d:dj 0;j:dj 1;
 while[1=d[`map]j;j+:1];k:j;  / find next unpopulated entry
 while[0=d[`map]k;k+:1];      / find next populated entry
 m:l+$[0>l:j+bitshift[(k-1)-j;1;`right];n;0];  / l-1:next pt idx to be constructed
 d[`map;m]:`float$i;
 d[`bidx;i]:`float$l;         / i-th GV used to set pt l-1
 d[`lidx;i]:`float$j;
 d[`ridx;i]:`float$k;
 d[`lweight;i]:(k-l)%k+1.-j;
 d[`rweight;i]:(l+1.-j)%k+1.-j;
 d[`sigma;i]:sqrt(l+1.-j)*(k-l)*dt%k+1.-j;
 if[n<=j:k+1;j:0];
 (d;j)}
i.updpath:{[n;bb;gv;path;i]
 idx:i.updidx[n;bb;i]each`lidx`ridx`bidx;
 path[idx 2]:(bb[`rweight;i]*path idx 1)+(bb[`sigma;i]*gv i)+$[1=j:idx 0;bb[`lweight;i]*path j-1;0];
 path}
i.updidx:{[n;bb;i;c]$[0>a;n+;]a:`int$bb[c;i]}