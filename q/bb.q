// q version of BrownianBridge.cpp
// Original reference: Copyright (C) 2002 "Monte Carlo Methods in Finance". All rights reserved.

bbridge:{[n;dt]
 bb:first flip(n-1).[i.initbb n]\(`bidx`ridx`lidx!3#n-1;((n-1)#0b),1b);
 bb:update lwt:bidx-lidx,rwt:ridx-bidx,sigma:ridx-lidx from bb;
 bb:update lwt%sigma,rwt%sigma,sigma:sqrt dt*lwt*rwt%sigma from bb;
 i.buildpath .[bb;(0;`sigma);:;sqrt n*dt]}

i.initbb:{[n;d;m]
 if[n<=j:1+d`ridx;j:0];
 d:`bidx`ridx`lidx!(l:j+(k-j+1)div 2;k:j+first where j _m;-1+j+:first where not j _m);
 (d;@[m;l;:;1b])}

i.buildpath:{[bb;z]if[count[z]<>n:count bb;'`length];
 {[x;bb;z]@[x;bb`bidx;:;z+(x[bb`ridx]*bb`rwt)+$[0>l:bb`lidx;0;x[l]*bb`lwt]]
  }/[((n-1)#0.),z 0;1_bb;1_z*:bb`sigma]}
