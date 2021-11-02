(*
Property based tests for Regular expression and NFA 
*)
open QCheck
open P3.Nfa
open P3.Regexp
open TestUtils

let epsilon _x = Empty_String
let symbol x = Char x
let union x y = Union (x,y)
let concat x y = if x = Empty_String then y
                 else if y = Empty_String then x
                 else Concat (x,y)             
let star x  = Star x                                  

(* Generate a regex on dept n *)

let rec regex_gen n =
  let open Gen in 
  match n with
    0 ->frequency [(1,map epsilon char);(9, map symbol (char_range 'a' 'z'))]
   |_ -> oneof [
             map2 union (regex_gen (n-1)) (regex_gen (n-1));
             map2 concat (regex_gen (n-1)) (regex_gen (n-1));
             map star (regex_gen (n-1))
           ]

(* generate a string that the given regex recognizes *)

let rec string_gen regex =
  let rec dup s n = if n <= 0 then s else s ^ (dup s (n-1)) in
  let open Gen in 
  match regex with
    Empty_String -> return ""
   |Char x-> return (String.make 1 x)
   |Union (a,b)-> (oneof [string_gen a;string_gen b])
   |Concat (a,b)-> (string_gen a) >>= fun x->
                   (string_gen b) >>= fun y ->
                   return (x^y)
   |Star s -> (int_range 1 5) >>= fun n ->
              (string_gen s)  >>= fun str -> 
              return (dup str n)
                                                                           

let arb_regex_string=
  make (
      let open Gen in 
      (regex_gen 5) >>= fun regex ->
      let str = string_gen regex in
      (*let () = Printf.printf "Regex: %s\n String: %s\n" (re_to_str regex) (generate1 str) in *)
      pair (return regex) str
    )

let print (a,b) = "Regex:" ^re_to_str a ^ "\nString:" ^ b
(*let shrink (a,b) =   Iter.pair (Iter.return a) (Shrink.string b)*)

let arb_regex_string = set_print print arb_regex_string
(*let arb_regex_string = set_shrink shrink arb_regex_string*)

let  test_regex_to_nfa_accept_pbt =
  Test.make
    ~name:"regex_to_nfa_accept"
    ~count:100 (* number of tests *)
    (arb_regex_string)    (* a regex and string the regex recognizes *)
    (fun (regex, str) ->
      let nfa = regexp_to_nfa regex in
      let dfa = nfa_to_dfa nfa in 
      accept dfa str
    )
;;

QCheck_runner.run_tests 
  ~verbose:true
  (*?debug_shrink:(Some (Some Stdlib.stdout))*)
  [
    test_regex_to_nfa_accept_pbt
  ]
