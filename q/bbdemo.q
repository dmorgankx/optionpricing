/ live demo
/ run with e.g. "q)\t 1000  q)bblive 8"
bblive:{[n]
 x:enlist[(n+1)#0b],1b,'enlist[n#0b],last flip(n-1).[util.initbb n]\(`bidx`ridx`lidx!3#n-1;((n-1)#0b),1b);
  bbd::"\n"vs .Q.s flip(`$"i",'string til count x)!x:flip(" X")x;}
.z.ts:{if[2<count bbd;-1 system"clear";-1@'3#bbd;bbd::(2#bbd),(3_bbd)];}

/ static demo - return steps in table
bbdemo:{[n]
 x:1b,'enlist[n#0b],last flip(n-1).[util.initbb n]\(`bidx`ridx`lidx!3#n-1;((n-1)#0b),1b);
 flip(`$"i",'string til count x)!x:flip(" X")x }