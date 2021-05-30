tst = lambda c . lambda t . lambda f . (c t f);

tru = lambda t . lambda f . t;

fls = lambda t . lambda f . f;

asbool = lambda b . b true false;

tst tru fls tru;

asbool (tst tru fls tru);

zero = lambda s . lambda z . z;
one = lambda s . lambda z . s z;
two = lambda s . lambda z . s (s z);

asnat = lambda c . c (lambda x. succ x) 0;

asnat zero;
asnat one;

ho = lambda x . x x;

ho ho;

scc = lambda n . (lambda s . lambda z. s (n s z));

asnat (scc two);

scc' = lambda n . (lambda s . lambda z. (n s (s z)));

asnat (scc' two);

three= scc two;

asnat three;

plus = lambda n . lambda m . n scc m;
plus' = lambda n . lambda m . (lambda s. lambda z. n s (m s z));
plus'' = lambda n . lambda m . (lambda s. lambda z. n s m);

asnat (scc (scc three));

asnat (plus two three);
asnat (plus' two three);
asnat (plus'' two three);

/* four = succ; */

four = scc three;

mystery = lambda n . lambda m . m n;

asnat (mystery two three);

asnat (mystery four four);
