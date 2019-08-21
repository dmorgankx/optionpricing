\l bb.q
\l bs.q
\l mc.q

pd:`s`k`v`r`q`t!100 100 .2 .05 0 1
l:20
m:8+64*til 16
n:1000
bb:bbridge[n;1]

-1"Euro BS price ",string bseuro:bsEuroCall[pd];
st:.z.p;
{[bs;l;n;pd;bb;m]
  err_a:{sqrt avg x*x}bs-a:mcEuroCall[;n;`bb`sobol!(bb;1b);pd]each l#m;
  err_b:{sqrt avg x*x}bs-b:mcEuroCall[;n;`bb`sobol!(::;1b);pd]each l#m;
  err_c:{sqrt avg x*x}bs-c:mcEuroCall[;n;`bb`sobol!(bb;0b);pd]each l#m;
  0N!("f"$m;err_a;err_b;err_c;last c);
   }[bseuro;l;n;pd;bb]each m;
-1"Time taken = ",string .z.p-st;

-1"Asia BS price ",string bsasia:bsAsiaCall[n;pd];
st:.z.p;
{[bs;l;n;pd;bb;m]
  err_a:{sqrt avg x*x}bs-a:mcAsiaCall[;n;`bb`sobol!(bb;1b);pd]each l#m;
  err_b:{sqrt avg x*x}bs-b:mcAsiaCall[;n;`bb`sobol!(::;1b);pd]each l#m;
  err_c:{sqrt avg x*x}bs-c:mcAsiaCall[;n;`bb`sobol!(bb;0b);pd]each l#m;
  0N!("f"$m;err_a;err_b;err_c;last c);
   }[bsasia;l;n;pd;bb]each m;
-1"Time taken = ",string .z.p-st;
