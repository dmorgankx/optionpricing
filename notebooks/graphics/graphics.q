/ Initialize matplotlib
plt:.p.import`matplotlib.pyplot

/ Subplot number genertor outputs and distributions
subplot:{[d;t;n;p]
 sub:plt[`:subplots].(1;n);
 fig:sub[@;0];axs:sub[@;1];
 ax:{x[@;y]}[axs]each tn:til n;
 fig[`:set_figheight;7];
 fig[`:set_figwidth;15];
 {[d;t;p;a;n]
  x:d n;
  a[hsym p]. $[`hist~p;(x;10);x];
  a[`:set_title]t n;
  }[d;t]'[p;ax;tn];
 plt[`:show][];}

/ Compare prx, rmse or log rmse for BS/MC/QMC prices for Asian/European Markets

prxerrplot:{[r;t]
 sub:plt[`:subplots]. 1 2;
 fig:sub[@;0];axs:sub[@;1];
 ax0:axs[@;0];ax1:axs[@;1];
 fig[`:set_figheight;7];
 fig[`:set_figwidth;15];
 {[r;t;a;m]
  r:select from r where mkt=m;
  if[b:`prx~t;a[`:plot][;;"k--";`label pykw`prx_bs]. r`npaths`prx_bs];
  {[t;a;r;l;ls]
   xy:$[lg:t~`log;log;]r`npaths,l;
   if[lg;ln:`m`b!2#i.lnreg[;]. xy;
      a[`:plot][xy 0;ln[`b]+xy[0]*ln`m;ls;`label pykw "Trendline ",string[l]," - 1/N^",1_5#string ln`m]];
   a[`:plot][;;`label pykw l]. xy;
   }[t;a;r]'[tt:$[b;i.p;i.e];("k--";"k-.";"k:")]; 
  a[`:set_title]"_"sv(string[m];t:string[t],$[`log~t;"_rmse";()]);
  a[`:legend][`loc pykw"lower left"];
  a[`:set_xlabel]"npaths";
  a[`:set_ylabel]t;
  }[r;t]'[(ax0;ax1);`euro`asia];
 plt[`:show][];}

i.lnreg:.p.import[`scipy.stats][`:linregress;<];
i.p:`prx_bb_sobol`prx_std_sobol`prx_std_rdm;
i.e:`rmse_bb_sobol`rmse_std_sobol`rmse_std_rdm;

/ Find right command for os - used for Brownian bridge demo
syscmd:$[string[.z.o]like"w*";"cls";"clear"]