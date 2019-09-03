/ Initialize matplotlib
plt:.p.import`matplotlib.pyplot

/ Subplot number genertor outputs and distributions
subplot:{[x;y;tx;ty]
 sub:plt[`:subplots]. 1 2;
 fig:sub[@;0];axs:sub[@;1];
 ax0:axs[@;0];ax1:axs[@;1];
 fig[`:set_figheight;7];
 fig[`:set_figwidth;15];
 ax0[`:scatter]. x;
 ax0[`:set_title]tx;
 ax1[`:scatter]. y;
 ax1[`:set_title]ty;
 plt[`:show][];}

/ Compare RMSE for BS and MC prices for Asian and European Markets
rmseplot:{[r]
 sub:plt[`:subplots]. 1 2;
 fig:sub[@;0];axs:sub[@;1];
 ax0:axs[@;0];ax1:axs[@;1];
 fig[`:set_figheight;7];
 fig[`:set_figwidth;15];
 {[a;m]
  t:select from r where mkt=m;
  e:`rmse_bb_sobol`rmse_std_sobol`rmse_std_rdm;
  {x[`:plot][y`npaths;y z;`label pykw z];}[a;t]each e;
  a[`:set_title]string[m]," RMSE";
  a[`:legend][`loc pykw"upper right"];
  }'[(ax0;ax1);`euro`asia];
 plt[`:show][];}

/ Find right command for os - used for Brownian bridge demo
syscmd:$[string[.z.o]like"w*";"cls";"clear"]