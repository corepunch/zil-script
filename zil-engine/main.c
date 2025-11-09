#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

typedef enum {
  N_EXPR,      // <...>
  N_LIST,      // (...)
  N_STRING,    // "..."
  N_IDENT,     // identifier
  N_NUMBER,    // 123
  N_SYMBOL,     // ,FOO or other symbols
  N_COMMENT,
} NodeType;

typedef struct Node {
  NodeType type;
  char *val;
  struct Node **kids;
  int n;
} Node;

Node *mk(NodeType t, char *v) {
  Node *n = malloc(sizeof(Node));
  n->type = t;
  n->val = v ? strdup(v) : NULL;
  n->kids = NULL;
  n->n = 0;
  return n;
}

void del(Node *p) {
  for (int i = 0; i < p->n; i++) {
    del(p->kids[i]);
  }
  if(p->val)free(p->val);
  if(p->kids)free(p->kids);
  free(p);
}

void add(Node *p, Node *c) {
  if (c->type == N_COMMENT) {
    del(c);
  } else {
    p->kids = realloc(p->kids, (p->n + 1) * sizeof(Node*));
    p->kids[p->n++] = c;
  }
}

int ws(int c) { return isspace(c); }

Node *parse(FILE *f) {
  int c;
  while ((c = fgetc(f)) != EOF && ws(c));
  if (c == EOF) return NULL;

  if (c == ';') {
    Node *n = parse(f);
    n->type = N_COMMENT;
    return n;
  }
  
  if (c == '\f' || c == '\\') {
    int next = fgetc(f);
    if (c == '\\' && next == '\f') {
      // Skip \^L sequence
      return parse(f);
    }
    if (c == '\f') {
      return parse(f);
    }
    ungetc(next, f);
    if (c == '\\') {
      // Not a form feed escape, continue parsing
    } else {
      return parse(f);
    }
  }
  
  if (c == '<') {
    Node *n = NULL; //mk(N_EXPR, NULL);
    while (1) {
      while ((c = fgetc(f)) != EOF && ws(c));
      if (c == EOF || c == '>') break;
      ungetc(c, f);
      Node *ch = parse(f);
      if (ch) {
        if (n) {
          add(n, ch);
        } else {
          n = ch;
          n->type = N_EXPR;
        }
      }
    }
    return n?n:mk(N_EXPR, NULL);
  }
  
  if (c == '(') {
    Node *n = mk(N_LIST, NULL);
    while (1) {
      while ((c = fgetc(f)) != EOF && ws(c));
      if (c == EOF || c == ')' || c == '>') break;
      ungetc(c, f);
      Node *ch = parse(f);
      if (ch) add(n, ch);
    }
    if (c != ')') ungetc(c, f);
    return n;
  }
  
  if (c == '>' || c == ')') return NULL;
  
  if (c == '"') {
    char buf[4096], *p = buf;
    while ((c = fgetc(f)) != EOF && c != '"') {
      *p++ = c;
      if (c == '\\') { c = fgetc(f); if (c != EOF) *p++ = c; }
    }
    *p = 0;
    return mk(N_STRING, buf);
  }
  
  char buf[256], *p = buf;
  *p++ = c;
  while ((c = fgetc(f)) != EOF && !ws(c) && c != '<' && c != '>' && c != '"' && c != '(' && c != ')')
    *p++ = c;
  *p = 0;
  if (c != EOF) ungetc(c, f);
  
  // Determine type
  NodeType t = N_IDENT;
  if (buf[0] == ',' || buf[0] == '?' || buf[0] == '.')
    t = N_SYMBOL;
  else if (isdigit(buf[0]) || (buf[0] == '-' && isdigit(buf[1])))
    t = N_NUMBER;
  
  return mk(t, buf);
}

const char *type_str(NodeType t) {
  switch(t) {
    case N_EXPR: return "EXPR";
    case N_LIST: return "LIST";
    case N_STRING: return "STR";
    case N_IDENT: return "ID";
    case N_NUMBER: return "NUM";
    case N_SYMBOL: return "SYM";
    default: return "?";
  }
}

void print(Node *n, int d) {
  if (!n) return;
  for (int i = 0; i < d; i++) printf("  ");
  
  if (n->type == N_EXPR) {
    printf("<%s\n", n->val);
    for (int i = 0; i < n->n; i++) print(n->kids[i], d + 1);
    for (int i = 0; i < d; i++) printf("  ");
    printf(">\n");
  } else if (n->type == N_LIST) {
    printf("(\n");
    for (int i = 0; i < n->n; i++) print(n->kids[i], d + 1);
    for (int i = 0; i < d; i++) printf("  ");
    printf(")\n");
  } else {
    printf("[%s] %s\n", type_str(n->type), n->val);
  }
}

int main(void) {
  FILE *fp = fopen("/Users/igor/Developer/zork1-main/actions.zil", "r");
  if (!fp) return 1;
  
  Node *root = mk(N_LIST, NULL);  // Changed to LIST to avoid wrapper <
  Node *n;
  while ((n = parse(fp))) add(root, n);
  
  for (int i = 0; i < root->n; i++) print(root->kids[i], 0);  // Print children directly
  
  fclose(fp);
  return 0;
}
