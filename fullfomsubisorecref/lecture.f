Object = lambda M :: * => * .
         { Some R ,
           { state : R,
             methods : M R }};

CounterM =  lambda R.
            { get : R -> Nat,
              inc : R -> Unit };

Counter = Object CounterM;

CounterRep = { x : Ref Nat } ;

makeCounterMethods =
  lambda Rep <: CounterRep.
    { get = lambda rep : Rep . !(rep.x),
      inc = lambda rep : Rep . (rep.x) := succ (!(rep.x)) }
    as CounterM Rep;

counterMethods = makeCounterMethods[CounterRep];

makeCounter = lambda n : Nat .
  let rep = { x = ref n }
  in {*CounterRep, { state = rep,
                     methods = counterMethods } } as Counter;

sendget = lambda c:Counter .
  let {R,body} = c in
    body.methods.get (body.state);

sendinc = lambda c : Counter .
  let {R,body} = c in
    body.methods.inc (body.state);

c1 = makeCounter 13;
sendinc c1;
sendget c1;
         
SetCounterM = lambda R.
              { get : R -> Nat,
                inc : R -> Unit,
                set : R -> Nat -> Unit };

SetCounter = Object SetCounterM;

SetCounterRep = CounterRep;

makeSetCounterMethods =
  lambda Rep <: SetCounterRep .
    lambda self : Source (SetCounterM Rep) .
      let super = makeCounterMethods[Rep] in
        { get = super.get,
          inc = lambda rep:Rep . (!self).set rep (succ ((!self).get rep)),
          set = lambda rep:Rep . lambda n:Nat . (rep.x) := n }
        as SetCounterM Rep;

univFunc = lambda x:Top . error;

dummySetCounterMethods = {get = univFunc, inc = univFunc, set = univFunc }
   as SetCounterM SetCounterRep;

setCounterMethods = 
  let self = ref dummySetCounterMethods in
     ( self := makeSetCounterMethods [SetCounterRep] self;
       !self);

/* make set counter */

InstrSetCounterM = lambda R .
  { get : R -> Nat,
    set : R -> Nat -> Unit,
    inc : R -> Unit,
    acc : R -> Nat };

InstrSetCounterRep = { x : Ref Nat, a : Ref Nat };

makeInstrSetCounterMethods = 
  lambda Rep <: InstrSetCounterRep .
    lambda self : Source (InstrSetCounterM Rep) .
      let super = makeSetCounterMethods[Rep] self in
        { get = super.get,
          inc = super.inc,
          set = lambda rep:Rep . lambda n:Nat . 
                  ((super.set) rep n; 
                   (rep.a) := (succ (!(rep.a)))),
          acc = lambda rep:Rep . !(rep.a) }
        as InstrSetCounterM Rep;

CloneM = lambda R.
  { clone : R -> R };

sendclone = 
  lambda OM <: CloneM .
  lambda obj : Object OM .
    let {R,body} = obj in
      {*R, { state = body.methods.clone (body.state),
             methods = body.methods }} as Object OM;
