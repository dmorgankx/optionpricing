\l rand.q
\l norm.q

wpath:{[n;d;bb]$[(::)~bb;sums;bb]invcnorm$[d`sobol;sobolrand;mtrand3]n}
spath:{[n;d;pd]pd[`s]*exp(wpath[n;d;d`bb]*pd[`v]*sqrt dt)+(1+til n)*dr:(pd[`r]-pd[`q]+.5*v*v:pd`v)*dt:pd[`t]%n}

mcEuroCall:{[m;n;d;pd]exp[neg pd[`r]*pd`t]*avg 0|(last each spath[;d;pd]each m#n)-pd`k}
mcAsiaCall:{[m;n;d;pd]exp[neg pd[`r]*pd`t]*avg 0|(last each prds each xexp[;1%n]spath[;d;pd]each m#n)-pd`k}