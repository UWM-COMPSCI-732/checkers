/* Examples for testing */

 "hello";

unit;

lambda x:A. x;

let x=true in x;

timesfloat 2.0 3.14159;

{x=true, y=false}; 
{x=true, y=false}.x;
{true, false}; 
{true, false}.1; 


lambda x:Bool. x;
(lambda x:Bool->Bool. if x false then true else false) 
  (lambda x:Bool. if x then false else true); 

lambda x:Nat. succ x;
(lambda x:Nat. succ (succ x)) (succ 0); 

 
lambda x:<a:Bool,b:Bool>. x;


Hungry = Rec H . {} -> H;

Candy = {sugar : Nat};

SweetTooth = Rec S . Candy -> S;

feed = lambda h:Hungry . (unfold[Hungry] h) { protein = 4, fat = 2};

spoil = lambda h:SweetTooth . (unfold [SweetTooth] h) {sugar = 10};

baby = fix (lambda more:Hungry . fold[Hungry] (lambda food:{} . more));

brat = fix (lambda more:SweetTooth . 
          fold [SweetTooth] (lambda candy:Candy . more));

spoil brat;

feed baby;

spoil baby;

/* feed brat; Doesn't type check! */

Counter = Rec P. {get:Nat, inc:Unit->P}; 
p = 
let create = 
  fix 
    (lambda cr: {x:Nat}->Counter.
      lambda s: {x:Nat}.
        fold [Counter]
          {get = s.x,
           inc = lambda _:Unit. cr {x=succ(s.x)}})
in
  create {x=0};
p1 = (unfold [Counter] p).inc unit;
(unfold [Counter] p1).get;

doinc = lambda c:Counter . (unfold [Counter] c).inc unit;
doget = lambda c:Counter . (unfold [Counter] c).get;

p2 = doinc p;
doget p;
doget p1;
doget p2;


