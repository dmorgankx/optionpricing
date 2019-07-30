// q version of European_call.cpp

// bsCall - Black-Scholes call price
/* s = Asset at t=0
/* k = Strike
/* v = Volatility
/* r = Interest rate, if Asian > .1
/* q = Dividents
/* t = Expiry
bsprx:{[s;k;v;r;q;t]
 d1:(log[s%k]+t*(r-q)+.5*v*v)%v*sqrt t;
 (s*exp[neg q*t]*cndist d1)-k*exp[neg r*t]*cndist d1-v*sqrt t}

// option_price_discrete_asian_geometric_average_price_call - discrete
/* n = number of steps
asian_avgprx_discrete:{[n;s;k;v;r;q;t]
 mu:(.5*(n1:1.+1.%n)*r-v*v%2.)-r;
 adjsig2:(n1*v*v%3.)*1.+1.%2.*n;
 adjs:s*exp t*mu+adjsig2%2.;
 d1:(log[adjs%k]+(r-q)+.5*ta)%sqrt ta:t*adjsig2;
 (exp[neg q*t]*adjs*cndist d1)-exp[neg r*t]*k*cndist d1-sqrt ta}

// option_price_asian_geometric_average_price_call - continuous
/* sig = sigma
asian_avgprx:{[sig;s;k;r;q;t]
 adjdiv:.5*r+q+sig*sig;
 adjsig:sig%sqrt 3.;
 d1:(log[s%k]+t*(r-adjdiv)+.5*adjsig*adjsig)%adjsig*rt:sqrt t;
 (s*exp[neg adjdiv*t]*cndist d1)-k*exp[neg r*t]*cndist d1-adjsig*rt}

// sobolAssetPrice
/* bb = Brownian Bridge dict w/ `map`bidx`sigma`lweight`rweight`lidx`ridx, size:7xn
assetprx:{[n;bb;s;v;r;q;t]
 drift:(dt:t%n)*(r-q)-.5*v*v;
 prx:(),s*exp drift+bb[0]*vrtdt:v*sqrt dt;
 i.prxcalc[drift;vrtdt;bb]/[prx;-1_1+til n]}

// sobolEuropeanCall_mod and sobolAsianGeomCall
/* bs      = Black-Scholes call price, calculated using bsprx
/* param   = dictionary of parameters, w/ `s`k`v`r`q`t`mkt (`mkt =`asian/`european)
/* bools   = dictionary of booleans, `sobol`bbridge!11b
/* npath   = number of paths
/* ntrials = number of trials
geocall:{[bs;param;bools;npath;nsteps;ntrials]
 r:i.trialerr[bs;param;bools;nsteps;npath;bbridge[nsteps;1.]]/[(0.;0 0.);til ntrials];
 (r[0]%ntrials;sqrt(err:r 1)[1]%ntrials)}

i.prxcalc:{[d;v;bb;prx;i]prx,last[prx]*exp d+v*bb[i]-bb i-1}
i.trialerr:{[bs;param;bools;nsteps;npath;initbb;res;trial]
 vsum:i.sumpath[param;bools;nsteps;initbb]/[0.;til npath];
 op:exp[neg param[`r]*param`t]*vsum%npath;
 tot:res[0]+exp[neg param[`r]*param`t]*vsum%npath;
 err:(res[1;0];res[1;1]+a*a:bs-op);
 (tot;err)}
i.sumpath:{[param;bools;nsteps;initbb;vsum;i]
 bb:bbridge_options[nsteps;initbb;bools];
 AP:assetprx[nsteps;bb]. param`s`v`r`q`t;
 S:$[b:`asian~m:param`mkt;@[;1]i.scalc[nsteps;AP]/[0 1.;til nsteps];
     `european~m;AP[nsteps-1];'`$"please select asian or european"];
 vsum+max(S-param`k;0.)}
i.scalc:{[n;AP;l;j](AP j;l[1]*xexp[l 0;1.%n])}