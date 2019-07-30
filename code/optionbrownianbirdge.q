// q version of OptionBrownianBridge.cpp
/  brownian bridge approximation

/ * n  = number of steps
/ * bb = Brownian Bridge
/ * d  = dictionary of booleans, e.g. `sobol`bbridge!11b
bbridge_options:{[n;bb;d]
 z:invcnorm each svec:$[d`sobol;sobol[n;1];n?1.];
 $[d`bbridge;buildpath[n;bb;z;n#0.];i.wienerpath[sqrt 1;z]/[();til n]]}

i.wienerpath:{[dt;z;w;j]w,:$[0=j;;last[w]+]dt*z j;w}