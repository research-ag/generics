import Generics "../src";

module M {  
  public class f_<T>() {
    let buf : Generics.Buf<[T]> = Generics.Buf<[T]>();
    public func call(x : T) : async* () {
      // some code here
      buf.set([x, x]);
    };
    public func result() : [T] = buf.get();
  };
};

let f_ = M.f_<Nat>();
func f(x : Nat) : async* [Nat] {
  await* f_.call(x);
  f_.result();
};

assert (await* f(0)) == [0, 0];
