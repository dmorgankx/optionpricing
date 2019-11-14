wpath:{[u;d]$[(::)~d`bb;sums;d`bb]invcnorm u}
spath:{[u;n;d;pd]pd[`s]*exp(wpath[u;d]*pd[`v]*sqrt dt)+(1+til n)*dr:(pd[`r]-pd[`q]+.5*v*v:pd`v)*dt:pd[`t]%n}

mcEuroCall:{[u;n;d;pd]exp[neg pd[`r]*pd`t]*avg 0|(last each spath[;n;d;pd]each u)-pd`k}
mcAsiaCall:{[u;n;d;pd]exp[neg pd[`r]*pd`t]*avg 0|((*/)each xexp[;1%n]spath[;n;d;pd]each u)-pd`k}

numgen:{[ng;l;m;n]ng@''$[ng~mtrand3;(l;first m)#n;(0N;m)#1+til l*m]}