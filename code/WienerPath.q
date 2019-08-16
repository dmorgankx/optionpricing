\l ../code/LoadSobol.q
\l ../code/mtrand.q

/ * n  = number of steps
/ * bb = Brownian Bridge
/ * d  = dictionary of booleans, e.g. `sobol`bbridge!10b

wienerPath:{[n;bb;d]
 u:$[d`sobol;sobol[;1];mtrand3]n;
 z:invcnorm each u;
 $[d`bbridge;buildpath[n;bb;z;n#0.];i.stdw .(0;1)_z]}

i.stdw:{x,last[x]+y}/