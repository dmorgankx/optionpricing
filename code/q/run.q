/ Parameters
pd:`s`k`v`r`q`t!100 100 .2 .05 0 1  / Parameter dictionary
l:20                                / Number of trials
m:"j"$xexp[2;3+til 8]               / Number of paths
n:1024                              / Number of steps
bb:bbridge[n;1]                     / Inital Brownian bridge

/ Run all techniques for option pricing
runall:{[bb;pd;l;n;m]
 st:.z.p;0N!i.rcol;e:i.run[`euro;bsEuroCall pd;bb;pd;l;n]each m;
 -1"European: time taken = ",string[.z.p-st],"\n";
 st:.z.p;0N!i.rcol;a:i.run[`asia;bsAsiaCall[n;pd];bb;pd;l;n]each m;
 -1"Asian: time taken = ",string .z.p-st;
 e,a}

/ Show individual results tables
rt:{[t;m]show delete mkt from select from t where mkt=m}

i.d:`bb`sobol!
i.rcol:`mkt`npaths`rmse_bb_sobol`rmse_std_sobol`rmse_std_rdm`prx_bb_sobol`prx_std_sobol`prx_std_rdm`prx_bs
i.rmse:{sqrt avg x*x-:y}
i.run :{[mkt;bs;bb;pd;l;n;m]
 mc:$[mkt~`asia;mcAsiaCall;mcEuroCall][;n;;pd];
 ea:i.rmse[bs]a:mc[;i.d(bb;1b)]peach sob:numgen[sobolrand n;l;m;n];
 eb:i.rmse[bs]b:mc[;i.d(::;1b)]peach sob;
 ec:i.rmse[bs]c:mc[;i.d(bb;0b)]peach numgen[mtrand3;l;m;n];
 i.rcol!0N!(mkt;m;ea;eb;ec;last a;last b;last c;bs)}

r:runall[bb;pd;l;n;m]
