\l ../code/BrownianBridge.q
\l ../code/WienerPath.q

mcAssetPrice:{[n;bb;s;v;r;q;t]
 drift:(dt:t%n)*(r-q)-.5*v*v;
 price:s*exp drift+(vrtdt:v*sqrt dt)*bb 0;
 i.prxCalc[drift;vrtdt;bb]/[price;1+til n]}

mcCall:{[bd;pd;nsteps;npaths;ntrials]
 bb:bbridge[nsteps;1.];
 r:i.AssetPath[nsteps;bb;bd;pd]/[0.;til npaths];
 exp[neg pd[`r]*pd`t]*r%npaths}

mcTrials:{[bd;pd;nsteps;npaths;ntrials]
 r:();do[ntrials;r,:mcCall[bd;pd;nsteps;npaths;ntrials]];r}

mcComparison:{[bs;mc]
 err:sum e*e:bs-prx:sums mc;
 (last[prx]%n;sqrt err%n:count mc)}

i.AssetPath:{[n;bb;bd;pd;r;i]
 w:wienerPath[n;bb;bd];
 s:mcAssetPrice[n;w]. pd`s`v`r`q`t;
 s:$[`asian~pd`mkt;(*/)xexp[;1%n]each s;last s];
 r+max 0.,s-pd`k}
i.prxCalc:{[d;v;b;p;i]p,last[p]*exp d+v*b[i]-b i-1}

/
mcEuroCall:{[bd;pd;npaths;nsteps;ntrials]
 bb:bbridge[nsteps;1.];
 r:i.euroAssetPath[nsteps;bb;bd;pd]/[0.;til npaths];
  exp[neg pd[`r]*pd`t]*r%npaths}
mcAsiaCall:{[bd;pd;npaths;nsteps;ntrials]
 bb:bbridge[nsteps;1.];
 r:i.asiaAssetPath[nsteps;bb;bd;pd]/[0.;npaths];
 exp[neg pd[`r]*pd`t]*r%npaths}
i.euroAssetPath:{[n;bb;bd;pd;r;i]
 w:wienerPath[n;bb;bd];
 s:mcAssetPrice[n;w]. pd`s`v`r`q`t;
 r+max 0.,last[s]-pd`k}
i.asiaAssetPath:{[n;bb;bd;pd;r;i]
 w:wienerPath[n;bb;bd];
 s:mcAssetPrice[n;w]. pd`s`v`r`q`t;
 savg:(*/)xexp[;1%n]each s;
 r+max 0.,savg-pd`k}
\