/ Initialize matplotlib
plt:.p.import`matplotlib.pyplot

/ Plotting function 
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