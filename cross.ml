module type COMP = sig
    type t
    val compare : t -> t -> int
    val string_of_elt : t -> string
end

module MySet (Elt : COMP) = struct
    module EltSet = Set.Make(Elt)

    module ListSet = Set.Make
    (
        struct
            type t = Elt.t list
            let compare l1 l2 =
                if (List.length l1) > (List.length l2) then 1
                else if (List.length l1) < (List.length l2) then -1
                else
                    let rec comp l1 l2 =
                        match l1, l2 with
                          [], [] -> 0
                        | h1 :: t1, h2 :: t2 ->
                               if Elt.compare h1 h2 = 1 then 1
                               else if Elt.compare h1 h2 = -1 then -1
                               else (comp t1 t2)
                        | _ -> failwith "unequal lengths not expected!"
                    in
                    comp l1 l2
        end
    )

    let string_of_list l =
        match l with
          [] -> "[]"    
        | h :: t ->
            let sl = List.map Elt.string_of_elt l in
                "[" ^ (List.hd sl) ^
                (List.fold_left (fun x y -> x ^ ", " ^ y) "" (List.tl sl)) ^ "]"

    let string_of_set s =
        string_of_list (EltSet.elements s)

    let string_of_listset ilset =
        if ListSet.is_empty ilset then "{ }"
        else
            let illist = ListSet.elements ilset in
            let splist = List.map string_of_list illist in
            "{\n  " ^ (List.hd splist) ^
            (List.fold_left (fun x y -> x ^ ",\n  " ^ y) "" (List.tl splist)) ^
            "\n}"
end

module CrossProduct (Elt : COMP) = struct
    include MySet(Elt)

    (* To each list in the set s, add the value i *)
    let add_to_list_set i s =
        ListSet.map (fun l -> i :: l) s

    (* Foreach element e in set s, add e to all lists in cp *)
    let add_set_to_cross_product (s : EltSet.t) (cp : ListSet.t) =
            EltSet.fold
                (fun i cp' -> ListSet.union (add_to_list_set i cp) cp')
                s
                (ListSet.empty)

    (* cross product is just add all elements of head is to all lists in 
       the cross product of tail islist *)
    let rec cross_product (islist : EltSet.t list) =
        match islist with
          [] -> ListSet.singleton []
        | is :: islist' -> add_set_to_cross_product is (cross_product islist')
end

module Counter = struct
    (* generate a list containing n repetitions of d *) 
    let rec repeat d n = if n = 0 then [] else d :: (repeat d (n - 1))

    (* generate a list containing n repetitions of 0 *)
    let zero b = repeat 0 (List.length b)

    (* the maximum number representable with a base b *)
    let max b = List.fold_left ( * ) 1 b

    let add_1_digit d b0 = if d < b0 - 1 then (d + 1, 0) else (0, 1)

    (*
       Assuming l to be the current number, inc returns the next number
       assuming b to the list of bases of the number system.
    *)
    let rec inc l b =
        match l, b with
          [], [] -> []
        | h :: t, b0 :: b' -> let (h', c) = add_1_digit h b0 in
            if c = 0 then h' :: t
            else h' :: (inc t b')
        | _ -> failwith "Error inc : unequal lengths of l and b"

    (*
        Assuming b to be the bases, count_all return the list of all the numbers
        in the number system represented by b.
    *)
    let count_all b =
        let z = zero b
        and m = max b in
        let rec iter n ns c =
          if c = m then ns
          else let n' = (inc n b) in iter n' (n' :: ns) (c + 1) 
        in iter z [] 0

    (*
      let illist be a list of list of elements. elements returns
      a list of elements, one picked from element list in illist
      Let i be the jth element of indices.
      elements returns the list of elements such that each is the
      ith element of the jth list of illist for all j 0 ... length(illist).

      Requires: length(illist) = length(indices)

      Example(1):
          let illist = [[1;2;3]; [4;5]; [6; 7; 8; 9]]
          indices = [1; 0; 3]
          then
          elements illist indices = [2; 4; 9]
    *)
    let rec elements illist indices =
        match illist, indices with
          [], [] -> []
        | (ilist :: illist'), (i :: indices') ->
            (List.nth ilist i) :: (elements illist' indices')
        | _ -> 
            failwith "cross_product -> unequal lengths of illlist and indices"
end

module CrossProductCounter (Elt : COMP) = struct
    include MySet(Elt)
    let cross_product (islist : EltSet.t list) =
        (* convert all sets into lists *)
        let illist = List.map EltSet.elements islist in

        (* compute the bases *)
        let bases = List.map (List.length) illist in

        (* compute all possible index combinations *)
        let all_indices = Counter.count_all bases in

        (* extract the number corresponding to each index combination *)
        ListSet.of_list (List.map (Counter.elements illist) all_indices)
end

module Int : (COMP with type t = int) = struct
  type t = int
  let compare = compare
  let string_of_elt = string_of_int
end

module IntCrossProduct = CrossProduct(Int)

module MyString : (COMP with type t = string) = struct
  type t = string
  let compare = compare
  let string_of_elt s = s
end

module MyStringCrossProduct = CrossProduct(MyString)

module ICP = IntCrossProduct
let t1 () =
        let a = ICP.EltSet.(empty |> add 1 |> add 2 |> add 3)
        and b = ICP.EltSet.(empty |> add 4 |> add 5)
        and c = ICP.EltSet.(empty |> add 6 |> add 7 |> add 8 |> add 9) in
        [a; b; c]
            |> ICP.cross_product
            |> ICP.string_of_listset
            |> print_endline

module SCP = MyStringCrossProduct
let t2 () =
        let a = SCP.EltSet.(empty |> add "one" |> add "two" |> add "three")
        and b = SCP.EltSet.(empty |> add "four" |> add "five")
        and c = SCP.EltSet.(empty |> add "six" |> add "seven" 
                    |> add "eight" |> add "nine") in
        [a; b; c]
            |> SCP.cross_product
            |> SCP.string_of_listset
            |> print_endline

module ICPC = CrossProductCounter(Int)
let t3 () =
        let a = ICPC.EltSet.(empty |> add 1 |> add 2 |> add 3)
        and b = ICPC.EltSet.(empty |> add 4 |> add 5)
        and c = ICPC.EltSet.(empty |> add 6 |> add 7 |> add 8 |> add 9) in
        [a; b; c]
            |> ICPC.cross_product
            |> ICPC.string_of_listset
            |> print_endline

module SCPC = CrossProductCounter(MyString)
let t4 () =
        let a = SCPC.EltSet.(empty |> add "one" |> add "two" |> add "three")
        and b = SCPC.EltSet.(empty |> add "four" |> add "five")
        and c = SCPC.EltSet.(empty |> add "six" |> add "seven"
                    |> add "eight" |> add "nine") in
        [a; b; c]
            |> SCPC.cross_product
            |> SCPC.string_of_listset
            |> print_endline

let main () =
        t1 ();
        t2 ();
        t3 ();
        t4 ()

let _ = main ()
