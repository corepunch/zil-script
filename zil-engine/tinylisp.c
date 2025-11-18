/* tinylisp.c with NaN boxing by Robert A. van Engelen 2022 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define I unsigned
#define L double
#define T(x) *(unsigned long long*)&(x)>>48
#define A (char*)cell
#define N 1024
FILE *fin; // input file pointer
enum {ATOM=0x7ff8,PRIM=0x7ff9,CONS=0x7ffa,CLOS=0x7ffb,NIL=0x7ffc,STRING=0x7ffd,LOCAL=0x7ffe,GLOBAL=0x7fff};
I hp=0,sp=N;
L cell[N],nil,tru,err,env;
L box(I t,I i) { L x; *(unsigned long long*)&x=(unsigned long long)t<<48|i; return x; }
I ord(L x) { return *(unsigned long long*)&x; }
L num(L n) { return n; }
I equ(L x,L y) { return *(unsigned long long*)&x==*(unsigned long long*)&y; }
// L atom(const char *s) {
//   I i=0; while (i < hp && strcmp(A+i,s)) i+=strlen(A+i)+1;
//   if (i==hp && (hp+=strlen(strcpy(A+i,s))+1) > sp<<3) abort();
//   return box(ATOM,i);
// }
// Modify the atom function to handle prefixes
L atom_with_prefix(const char *s, I prefix_type) {
  I i = 0;
  while (i < hp && strcmp(A+i, s)) i += strlen(A+i)+1;
  if (i == hp && (hp += strlen(strcpy(A+i, s))+1) > sp<<3) abort();
  return box(prefix_type, i);
}
#define atom(s) atom_with_prefix(s, ATOM)
L cons(L x,L y) { cell[--sp]=x; cell[--sp]=y; if (hp > sp<<3) abort(); return box(CONS,sp); }
L car(L p) { return (T(p)&~(CONS^CLOS))==CONS?cell[ord(p)+1]:err; }
L cdr(L p) { return (T(p)&~(CONS^CLOS))==CONS?cell[ord(p)]:err; }
L pair(L v,L x,L e) { return cons(cons(v,x),e); }
L closure(L v,L x,L e) { return box(CLOS,ord(pair(car(cdr(v)),x,equ(e,env)?nil:e))); }
L assoc(L v,L e) { while (T(e)==CONS && !equ(v,car(car(e)))) e=cdr(e); return T(e)==CONS?cdr(car(e)):err; }
I not(L x) { return T(x)==NIL; }
I let(L x) { return !not(x) && !not(cdr(x)); }
L eval(L,L),parse();
// L evlis(L t,L e) { return T(t)==CONS?cons(eval(car(t),e),evlis(cdr(t),e)):T(t)==ATOM?assoc(t,e):nil; }
L evlis(L t,L e) { return T(t)==CONS?cons(eval(car(t),e),evlis(cdr(t),e)):nil; }
L f_eval(L t,L e) { return eval(car(evlis(t,e)),e); }
L f_quote(L t,L _) { return car(t); }
L f_cons(L t,L e) { return t=evlis(t,e),cons(car(t),car(cdr(t))); }
L f_car(L t,L e) { return car(car(evlis(t,e))); }
L f_cdr(L t,L e) { return cdr(car(evlis(t,e))); }
L f_add(L t,L e) { L n=car(t=evlis(t,e)); while (!not(t=cdr(t))) n+=car(t); return num(n); }
L f_sub(L t,L e) { L n=car(t=evlis(t,e)); while (!not(t=cdr(t))) n-=car(t); return num(n); }
L f_mul(L t,L e) { L n=car(t=evlis(t,e)); while (!not(t=cdr(t))) n*=car(t); return num(n); }
L f_div(L t,L e) { L n=car(t=evlis(t,e)); while (!not(t=cdr(t))) n/=car(t); return num(n); }
L f_int(L t,L e) { L n=car(evlis(t,e)); return n<1e16 && n>-1e16?(long long)n:n; }
L f_lt(L t,L e) { return t=evlis(t,e),car(t) - car(cdr(t)) < 0?tru:nil; }
L f_eq(L t,L e) { return t=evlis(t,e),equ(car(t),car(cdr(t)))?tru:nil; }
L f_pair(L t,L e) { L x=car(evlis(t,e)); return T(x)==CONS?tru:nil; }
L f_or(L t,L e) { L x=nil; while (!not(t) && not(x=eval(car(t),e))) t=cdr(t); return x; }
L f_and(L t,L e) { L x=tru; while (!not(t) && !not(x=eval(car(t),e))) t=cdr(t); return x; }
L f_not(L t,L e) { return not(car(evlis(t,e)))?tru:nil; }
// L f_cond(L t,L e) { while (not(eval(car(car(t)),e))) t=cdr(t); return eval(car(cdr(car(t))),e); }
L f_if(L t,L e) { return eval(car(cdr(not(eval(car(t),e))?cdr(t):t)),e); }
// L f_leta(L t,L e) { for (;let(t); t=cdr(t)) e=pair(car(car(t)),eval(car(cdr(car(t))),e),e); return eval(car(t),e); }
L f_leta(L t,L e) {for (;let(t);t=cdr(t)){
  L unquote = car(t);
  e=pair(car(car(unquote)),eval(car(cdr(car(unquote))),e),e);
  printf("%llx\n",car(car(unquote)));
} return eval(car(t),e); }
L f_FUNCTION(L t,L e) { return closure(f_quote(t,e),car(cdr(t)),e); }
L f_GLOBAL(L t,L e) { env=pair(car(t),eval(car(cdr(t)),e),env); return car(t); }

// ZIL additionals
L f_TELL(L t,L e) { L x=nil;while(T(t)==CONS){x=eval(car(t),e);if(T(x)==ATOM||T(x)==STRING)printf("%s",A+ord(x));else printf("%.10lg",x);t=cdr(t);}return nil; }
L f_COND(L t,L e) { return T(t)!=CONS?nil:!not(eval(car(car(t)),e))?eval(car(cdr(car(t))),e):f_COND(cdr(t),e); }
L f_ELSE(L t,L e) { return tru; }
// L f_DEFINE(L t,L e) { env=pair(car(t),closure(car(cdr(t)),car(cdr(cdr(t))),e),env);return car(t); }
L f_SETG(L t,L e) { env=pair(eval(car(t),e),eval(car(cdr(t)),e),env); return car(t); }
L f_SET(L t,L e) {
  L v=eval(car(t),e),val=eval(car(cdr(t)), e);
  for (L env_iter=e;T(env_iter)==CONS;env_iter=cdr(env_iter)) { // Search through local environment e...
    if (equ(v,car(car(env_iter)))) { // ...to update existing binding
      cell[ord(env_iter)+1]=cons(v,val); // Found it - update the value
      return v;
    }
  }
  return err; // Not found in local, return error
}
L f_DEFINE(L t,L e) {
  L p=car(cdr(t)),b=cdr(cdr(t)),x,s=nil;
  for (;!not(b);s=cons(car(b),s),b=cdr(b));
  x=car(s),s=cdr(s);
  for (;!not(s);x=cons(box(GLOBAL,ord(atom("if"))),cons(car(s),cons(x,cons(x,nil)))),s=cdr(s));
  env=pair(car(t),closure(p,x,e), env);
  return car(t);
}
L f_MAPF(L t,L e) {
  L apply(L f,L t,L e);
  L fn=car(cdr(t=evlis(t,e))),s=car(cdr(cdr(t))),r=nil,*p=&r;
  for(;T(s)==CONS;s=cdr(s),p=&cell[ord(*p)]) *p=cons(apply(fn,cons(car(s),nil),e),nil);
  return r;
}
L string(const char *s) {
  I i=0; while (i < hp && strcmp(A+i,s)) i+=strlen(A+i)+1;
  if (i==hp && (hp+=strlen(strcpy(A+i,s))+1) > sp<<3) abort();
  return box(STRING,i);
}
struct { const char *s; L (*f)(L,L); } prim[]={
  {"eval", f_eval },
  {"car", f_car},
  {"-",f_sub},
  {"<",  f_lt },
  {"or", f_or },
  {"cond",f_COND},
  {"FUNCTION",f_FUNCTION},
  {"quote",f_quote},
  {"cdr", f_cdr},
  {"*",f_mul},
  {"int",f_int},
  {"and",f_and},
  {"if",  f_if  },
  {"GLOBAL",f_GLOBAL},
  {"cons", f_cons },
  {"+",   f_add},
  {"/",f_div},
  {"eq?",f_eq },
  {"not",f_not},
  {"let*",f_leta},
  {"pair?", f_pair  },
  {"ELSE", f_ELSE },
  {"TELL",f_TELL},
  {"DEFINE",f_DEFINE},
  {"SETG",f_SETG},
  {"SET",f_SET},
  {"MAPF",f_MAPF},
  {0}
};
L bind(L v,L t,L e) { return not(v)?e:T(v)==CONS?bind(cdr(v),cdr(t),pair(car(v),car(t),e)):pair(v,t,e); }
L reduce(L f,L t,L e) { return eval(cdr(car(f)),bind(car(car(f)),evlis(t,e),not(cdr(f))?env:cdr(f))); }
L apply(L f,L t,L e) { return T(f)==PRIM?prim[ord(f)].f(t,e):T(f)==CLOS?reduce(f,t,e):err; }
L eval(L x, L e) {
  switch (T(x)) {
    case LOCAL: return assoc(box(ATOM,ord(x)),e);
    case GLOBAL: return assoc(box(ATOM,ord(x)),env);
    case CONS: return apply(eval(car(x),e),cdr(x),e);
    default: return x;
  }
}
char buf[256],see=' ';
void look() { int c=fgetc(fin); see=c; if (c==EOF) exit(0); }
I seeing(char c) { return c==' '?see > 0 && see<=c:see==c; }
char get() { char c=see; look(); return c; }
char scan() {
  int i=0;
  while (seeing(' ')) look();
  if (seeing('(') || seeing(')') || seeing('\'') || seeing('<') || seeing('>')) buf[i++]=get();
  else if (seeing('"')) {
    get(); // skip opening quote
    while (!seeing('"') && i < sizeof(buf)-2) {
      if (seeing('\\')) { // Handle escape sequences
        char c=get(), get(); // skip backslash
        buf[i++]=c=='n'?'\n':c=='t'?'\t':c=='\\'?'\\':c=='"'?'"':c;
      } else {
        buf[i++]=get();
      }
    }
    get(); // skip closing quote
    buf[i]=0;
    buf[sizeof(buf)-1]='"'; // mark as string
    if (!strcmp(buf, "TUPLE")) {
      memset(buf, 0, sizeof(buf));
      buf[0]='.';
    }
    return '"';
  }
  else do buf[i++]=get(); while (i < 39 && !seeing('(') && !seeing(')') && !seeing('<') && !seeing('>') && !seeing(' '));
  return buf[i]=0,*buf;
}
L Read() { return scan(),parse(); }
L list() { L x; return scan()==')'?nil:!strcmp(buf, ".")?(x=Read(),scan(),x):(x=parse(),cons(x,list())); }
L zillist() { L x; return scan()=='>'?nil:!strcmp(buf, ".")?(x=Read(),scan(),x):(x=parse(),cons(x,zillist())); }
L quote(L x) { return cons(atom_with_prefix("quote",GLOBAL),cons(x,nil)); }
// L atomic() { L n; int i; return sscanf(buf,"%lg%n",&n,&i) > 0 && !buf[i]?n:atom(buf); }
L atomic() {
  L n; int i;
  if (buf[sizeof(buf)-1]=='"') return buf[sizeof(buf)-1]=0,string(buf);
  else if (*buf=='.') return atom_with_prefix(buf+1,LOCAL);
  else if (*buf==',') return atom_with_prefix(buf+1,GLOBAL);
  else return sscanf(buf,"%lg%n",&n,&i)>0&&!buf[i]?n:atom(buf);
}

L parse() {
  if (*buf=='(') return quote(list());
  if (*buf=='<') {
    L opcode = Read(); // Read first element as GLOBAL
    return cons(T(opcode)==ATOM?box(GLOBAL,ord(opcode)):opcode,zillist());
  }
  if (*buf=='\'') return quote(Read());
  return atomic();
}
void print(L);
void printlist(L t) {
  for (putchar('(');; putchar(' ')) {
    print(car(t));
    if (not(t=cdr(t))) break;
    if (T(t)!=CONS) { printf(" . "); print(t); break; }
  }
  putchar(')');
}
void print(L x) {
  if (T(x)==NIL) printf("()");
  else if (T(x)==ATOM) printf("%s",A+ord(x));
  else if (T(x)==PRIM) printf("<%s>",prim[ord(x)].s);
  else if (T(x)==CONS) printlist(x);
  else if (T(x)==CLOS) printf("{%u}",ord(x));
  else if (T(x)==STRING) printf("\"%s\"",A+ord(x));
  else if (T(x)==LOCAL) printf(".%s",A+ord(x));
  else if (T(x)==GLOBAL) printf(",%s",A+ord(x));
  else printf("%.10lg",x);
}
void gc() { sp=ord(env); }
int main(int argc, char *argv[]) {
  if (argc < 2) { fprintf(stderr,"Usage: %s file.zil\n", argv[0]); return 1; }
  fin=fopen(argv[1],"r");
  if (!fin) { perror("fopen"); fprintf(stderr, "Can't open file %s", argv[1]); return 1; }
  I i; printf("tinylisp");
  nil=box(NIL,0); err=atom("ERR"); tru=atom("#t"); env=pair(tru,tru,nil);
  // Add CR constant
  env=pair(atom("CR"), string("\n"), env);
  for (i=0; prim[i].s; ++i) env=pair(atom(prim[i].s),box(PRIM,i),env);
  while (1) { printf("\n%u>",sp-hp/8); print(eval(Read(),env)); gc(); }
  fclose(fin);
}
