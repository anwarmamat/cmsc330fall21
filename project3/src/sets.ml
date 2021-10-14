let rec elem x a =
  match a with
  | h::t -> (h = x) || (elem x t)
  | [] -> false

let rec insert x a =
  if not (elem x a) then x::a else a

let insert_all (xs : 'a list) (a : 'a list) : 'a list =
  List.fold_right insert xs a

let rec subset a b =
  match a with
  | h::t -> (elem h b) && (subset t b)
  | [] -> true

let rec eq a b = (subset a b) && (subset b a)

let rec remove x a =
  match a with
  | h::t -> if h = x then t else h::(remove x t)
  | [] -> []

(* Returns the set subtraction of b from a. *)
let rec minus (a : 'a list) (b : 'a list) : 'a list =
  match b with
  | [] -> a
  | x :: xt -> minus (remove x a) xt

let rec union a b =
  match a with
  | h::t -> insert h (union t b)
  | [] ->
    (match b with
     | h::t -> insert h (union [] t)
     | [] -> [])

let rec intersection a b =
  match a with
  | h::t -> if elem h b then insert h (intersection t b) else (intersection t b)
  | [] -> []

let rec product_help x b =
  match b with
  | h::t -> insert (x, h) (product_help x t)
  | [] -> []

let rec product a b =
  match a with
  | h::t -> union (product_help h b) (product t b)
  | [] -> []

let rec cat x a =
  match a with
  | [] -> []
  | h::t -> (x,h)::(cat x t)

let rec diff a b =  
  match b with
  | [] -> a
  | h::t -> diff (remove h a) t
