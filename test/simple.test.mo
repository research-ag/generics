import Generics "../src";

module M {
  public class f_<T>() {
    let buf = Generics.Buf<[T]>();
    public func call(x : T) : async* () {
      // some code here
      buf.set([x, x]);
    };
    public func result() : [T] = buf.get();
  };
};

let f = M.f_<Nat>() |> (
  func(x : Nat) : async* [Nat] {
    await* _.call(x);
    _.result();
  }
);

assert (await* f(0)) == [0, 0];
