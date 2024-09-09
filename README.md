# Workaround for async function with parametric type in Motoko

## Overview

### Links

The package is published on [MOPS](https://mops.one/generics and [GitHub](https://github.com/research-ag/generics).

The API documentation can be found [here](https://mops.one/generics/docs).

For updates, help, questions, feedback and other requests related to this package join us on:

* [OpenChat group](https://oc.app/2zyqk-iqaaa-aaaar-anmra-cai)
* [Twitter](https://twitter.com/mr_research_ag)
* [Dfinity forum](https://forum.dfinity.org/)

### Motivation

Asynchronous functions, i.e. those whose return type starts with `async` or `async*` cannot have a type parameter in their return type.
This package provides a workaround.

### Build and test

We need `mops` installed.

```
mops test
```

## Example

The following code is desired but not allowed:

```
module M {
  public func f<T>(x : T) : async* [T] { 
    // some code here
    [x, x] 
  };
};

let f = M.f<Nat>;

await* f(0); // => [0, 0]
```

Instead, we have to do this:

```
import Generics "mo:generics";

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

await* f(0); // => [0, 0]
```

### Install with mops

You need `mops` installed. In your project directory run:
```
mops add generics
```

In the Motoko source file import the package as:
```
import Generics "mo:generics";
```

## Copyright

MR Research AG, 2024
## Authors

Main author: Timo Hanke
## License 

Apache-2.0
