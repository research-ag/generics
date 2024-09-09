/// Workaround for async functions with parametric type.
///
/// Copyright: 2024 MR Research AG
/// Main author: Timo Hanke 
/// Contributors: 

import Debug "mo:base/Debug";

module Generics {
  public class Buf<T>() {
    var result_ : ?T = null;
    public func set(x : T) {
      switch (result_) {
        case (null) result_ := ?x;
        case (?_) Debug.trap("old result still present");
      };
    };
    public func get() : T {
      switch (result_) {   
        case (?r) {
          result_ := null;
          r;
        };
        case (null) Debug.trap("no result present");
      };
    };    
  };
};
