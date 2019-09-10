pd:`s`k`v`r`q`t!100 100 .2 .05 0 1
l:20
m:8+64*til 16
n:1000
bb:bbridge[n;1]

d:`bb`sobol!
rmse:{sqrt avg x*x-:y}
rcol:"npaths, rmse_bb_sobol, rmse_std_sobol, rmse_std_rdm, prx_bb_sobol"

-1"Euro BS price ",string bseuro:bsEuroCall[pd];-1 rcol;st:.z.p;
{[bs;l;n;pd;bb;m]
  err_a:rmse[bs]a:mcEuroCall[;n;d(bb;1b);pd]each l#m;
  err_b:rmse[bs]b:mcEuroCall[;n;d(::;1b);pd]each l#m;
  err_c:rmse[bs]c:mcEuroCall[;n;d(bb;0b);pd]each l#m;
  0N!("f"$m;err_a;err_b;err_c;last c);
   }[bseuro;l;n;pd;bb]each m;
-1"Time taken = ",string .z.p-st;

-1"Asia BS price ",string bsasia:bsAsiaCall[n;pd];-1 rcol;st:.z.p;
{[bs;l;n;pd;bb;m]
  err_a:rmse[bs]a:mcAsiaCall[;n;d(bb;1b);pd]each l#m;
  err_b:rmse[bs]b:mcAsiaCall[;n;d(::;1b);pd]each l#m;
  err_c:rmse[bs]c:mcAsiaCall[;n;d(bb;0b);pd]each l#m;
  0N!("f"$m;err_a;err_b;err_c;last c);
   }[bsasia;l;n;pd;bb]each m;
-1"Time taken = ",string .z.p-st;