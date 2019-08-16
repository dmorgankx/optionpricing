\l ../code/NormalDistribution.q

/* n = number of timesteps
/* s = Asset at t=0
/* k = Strike
/* v = Volatility
/* r = Interest rate, if Asian > .1
/* q = Dividents
/* t = Expiry

bsEuroCall:{[s;k;v;r;q;t]
 d1:(log[s%k]+t*(r-q)+.5*v*v)%vrtt:v*sqrt t;
 (s*exp[neg q*t]*cnorm d1)-k*exp[neg r*t]*cnorm d1-vrtt}     / d2:d1-vrtt

bsAsiaCall:{[n;s;k;v;r;q;t]
 adjmu:.5*(r-.5*v2:v*v)*n1:1+1.%n;
 adjv2:(v2%3)*n1*1+.5%n;
 adjS :s*exp t*(hv2:.5*adjv2)+adjmu-r;
 d1:(log[adjS%k]+t*(r-q)+hv2)%rtv2:sqrt adjv2*t;
 (adjS*exp[neg q*t]*cnorm d1)-k*exp[neg r*t]*cnorm d1-rtv2}  / d2:d1-rtv2