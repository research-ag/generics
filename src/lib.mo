/// Workaround for async functions with parametric type.
///
/// Copyright: 2024 MR Research AG
/// Main author: Timo Hanke 

import Runtime "mo:core/Runtime";

module Generics {
  /// Buffer for a single return value of an async function.
  /// The type parameter `T` is the type of the return value.
  /// The return value is stored with the `set` function and later read with the `get` function.
  ///
  /// See the example in README.md for usage.
  public class Buf<T>() {
    var result_ : ?T = null;

    /// Function to set the return value.
    public func set(x : T) {
      switch (result_) {
        case (null) result_ := ?x;
        case (?_) Runtime.trap("old result still present");
      };
    };

    /// Function to read the return value.
    public func get() : T {
      switch (result_) {   
        case (?r) {
          result_ := null;
          r;
        };
        case (null) Runtime.trap("no result present");
      };
    };    
  };
};
