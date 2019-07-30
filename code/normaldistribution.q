// q version of NormalDistribution_VC.cpp
/* x = double

// ErrorFunction - original references the gnu C library, copyright (C) 1993 by Sun Microsystems, Inc. All rights reserved.
// Main checks for the value of x are as follows:
/  1. is null/infinity
/  2. |x| < 0.84375 -- < 2**-28 -- < 1.6e-36
/  3. 0.84375 <= |x| < 1.25
/  4. 6 <= |x| < inf
/  5. 1.25 <= |x| < 2.857 or 2.857 <= |x| < 6
errfnc:{
 if[(x:`float$x)in -0w 0w 0n;$[x~0n;:x;x>0f;:1.;:-1.]];
 if[.84375>ax:abs x;
  if[ax<xexp[2;-28];
   if[ax<16*i.erfcoeff`dblmin;:.125*(8.*x)+x*i.erfcoeff`efx8];  / avoid underflow
    :x+x*i.erfcoeff`efx]; 
  R:i.erfcoeff[`pp;0]+i.updfnc[s:x*x;1b]1_i.erfcoeff`pp;
  S:1+i.updfnc[s;1b]i.erfcoeff`qq;
  :x+x*R%S];
 if[ax<1.25;
  P:i.erfcoeff[`pa;0]+i.updfnc[s:ax-1;1b]1_i.erfcoeff`pa;
  Q:1+i.updfnc[s;1b]i.erfcoeff`qa;
  $[x>=0;:i.erfcoeff[`erx]+P%Q;:neg i.erfcoeff[`erx]-P%Q]];
 if[ax>=6;:0f];  
 s:1%ax*ax;  / starts to lose accuracy when ax~5
 $[ax<1%.35; 
  [R:i.erfcoeff[`ra;0]+i.updfnc[s;1b]1_i.erfcoeff`ra;S:1+i.updfnc[s;1b]i.erfcoeff`sa];
  [R:i.erfcoeff[`rb;0]+i.updfnc[s;1b]1_i.erfcoeff`rb;S:1+i.updfnc[s;1b]i.erfcoeff`sb]];
 r:exp(R%S)+(neg[ax]*ax)-.5625;
 $[x>=0;:1-r%ax;:(r%ax)-1]}

// CumulativeNormal
cnorm:{
 $[0w~x;:1.;-0w~x;:0.;];
 d:`a`lsta`g`k`sm`r!(m;m:i.erfcoeff`dblmax;1.;1.;1.;.5*1+errfnc x*1%sqrt 2);
 if[i.erfcoeff[`dbleps]>=d`r;d:i.cnd i.cnormcalc[x]/[d]];
 d`r}

// InverseCumulativeNormal
invcnorm:{
 $[(0>=x)|1<=x:`float$x;'`$"use value between 0 and 1";0f~x;:0n;];
 u:$[x<lo:.02425;i.invnormcalc[`c;`d]sqrt neg 2.*log x;
    x<=1-lo;u*i.invnormcalc[`a;`b]u*u:x-.5;
    neg i.invnormcalc[`c;`d]sqrt neg 2.*log 1-x];
 u-r%1+.5*u*r:sqrt[2*acos -1]*exp[.5*u*u]*cnorm[u]-x}

// Normal
norm:{(1%sqrt 2*acos -1)*exp neg .5*x*x}

// Coefficients for approximation to  erf on [0,0.84375]
erx:.845062911510467529297
efx:.128379167095512586316
efx8:1.02703333676410069053
pp:.128379167095512558561 -.325042107247001499370 -.0284817495755985104766 -.00577027029648944159157 -.0000237630166566501626084
qq:.397917223959155352819 .0650222499887672944485 .00508130628187576562776 .000132494738004321644526 .00000396022827877536812320

// Coefficients for approximation to  erf  in [0.84375,1.25]
pa:-.00236211856075265944077 .414856118683748331666 -.372207876035701323847 .318346619901161753674 -.110894694282396677476 .0354783043256182359371 -.00216637559486879084300
qa:.106420880400844228286 .540397917702171048937 .0718286544141962662868 .126171219808761642112 .0136370839120290507362 .0119844998467991074170

// Coefficients for approximation to  erfc in [1.25,1/0.35]
ra:-.00986494403484714822705 -.693858572707181764372 -10.5586262253232909814 -62.3753324503260060396 -162.396669462573470355 -184.605092906711035994 -81.2874355063065934246 -9.81432934416914548592
sa:19.6512716674392571292 137.657754143519042600 434.565877475229228821 645.387271733267880336 429.008140027567833386 108.635005541779435134 6.57024977031928170135 -.0604244152148580987438

// Coefficients for approximation to  erfc in [1/.35,28]
rb:-.00986494292470009928597 -.799283237680523006574 -17.7579549177547519889 -160.636384855821916062 -637.566443368389627722 -1025.09513161107724954 -483.519191608651397019
sb:30.3380607434824582924 325.792512996573918826 1536.72958608443695994 3199.85821950859553908 2553.05040643316442583 474.528541206955367215 -22.4409524465858183362

// Coefficients for the rational approximation
a:-39.69683028665376 220.9460984245205 -275.9285104469687 138.3577518672690 -30.66479806614716 2.506628277459239
b:-54.47609879822406 161.5858368580409 -155.6989798598866 66.80131188771972 -13.28068155288572
c:-0.007784894002430293 -0.3223964580411365 -2.400758277161838 -2.549732539343734 4.374664141464968 2.938163982698783
d:0.007784695709041462 0.3224671290700398 2.445134137142996 3.754408661907416

i.updfnc:{{x*z+y}[x]/[0;$[y;reverse;]z]}
i.erfcoeff:`dbleps`dblmax`dblmin`erx`efx`efx8`pp`qq`pa`qa`ra`sa`rb`sb!
 (1e-9;1e37;1e-37;erx;efx;efx8;pp;qq;pa;qa;ra;sa;rb;sb)
i.radcoeff:`a`b`c`d!(a;b;c;d)
i.cnormcalc:{[x;d]
 d[`lsta]:d`a;
 i:(-3+4*d[`k])%x*x;
 j:(-1+4*i)*i%x*x;
 d[`sm]-:a:d[`g]*i-j;
 d[`g]*:j;
 d[`k]+:1;
 d[`a]:abs a;
 d}
i.cnd:{(x[`lsta]>x`a)&i.erfcoeff[`dbleps]<=x`a}
i.invnormcalc:{(i.radcoeff[x;5]+i.updfnc[z;0b]neg[1]_i.radcoeff x)%1+i.updfnc[z;0b]i.radcoeff y}
