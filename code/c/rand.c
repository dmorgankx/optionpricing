#include "SobolSeq1024.h"
#include "mt19937arcok.h"
#include "k.h"

#ifdef _WIN32
#define EXP __declspec(dllexport)
#else
#define EXP
#endif

EXP K sobolrand(K x, K y){
 if(xt!=-KJ || y->t!=-KJ)
  R krr("type");
 K r=ktn(KF,x->j);
 SobolSeq1024(y->j,x->j,kF(r));
 R r;
}

EXP K mtinit(K x){
 if(xt!=-KJ)
  R krr("type");
 init_genrand((unsigned long)x->j);
 R (K)0;
}

EXP K mtrand1(K x){
 if(xt!=-KJ)
  R krr("type");
 K r=ktn(KF,x->j);
 r->n=0;
 for(J j=0;j<x->j;++j){
  F gv=genrand_real1();
  r=ja(&r,&gv);
 }
 R r;
}

EXP K mtrand2(K x){
 if(xt!=-KJ)
  R krr("type");
 K r=ktn(KF,x->j);
 r->n=0;
 for(J j=0;j<x->j;++j){
  F gv=genrand_real2();
  r=ja(&r,&gv);
 }
 R r;
}

EXP K mtrand3(K x){
 if(xt!=-KJ)
  R krr("type");
 K r=ktn(KF,x->j);
 r->n=0;
 for(J j=0;j<x->j;++j){
  F gv=genrand_real3();
  r=ja(&r,&gv);
 }
 R r;
}
