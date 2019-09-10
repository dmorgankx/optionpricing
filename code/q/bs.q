bsEuroCall:{[pd]
 d1:(log[pd[`s]%pd`k]+t*(pd[`r]-pd`q)+.5*v*v)%vrtt:(v:pd`v)*sqrt t:pd`t;
 (pd[`s]*exp[neg t*pd`q]*cnorm1 d1)-pd[`k]*exp[neg t*pd`r]*cnorm1 d1-vrtt}

bsAsiaCall:{[n;pd]
 adjmu:.5*((r:pd`r)-.5*v2:v*v:pd`v)*n1:1+1.%n;
 adjv2:(v2%3)*n1*1+.5%n;
 adjS :pd[`s]*exp(t:pd`t)*(hv2:.5*adjv2)+adjmu-r;
 d1:(log[adjS%k:pd`k]+t*(r-q:pd`q)+hv2)%rtv2:sqrt adjv2*t;
 (adjS*exp[neg q*t]*cnorm1 d1)-k*exp[neg r*t]*cnorm1 d1-rtv2}