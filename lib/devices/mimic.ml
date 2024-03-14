open Functoria.DSL
open Dns
open Stack
open Happy_eyeballs
open Misc

type mimic = Mimic

let mimic = typ Mimic

let mimic_happy_eyeballs =
  let packages = [ package "mimic-happy-eyeballs" ~min:"0.0.5" ] in
  let connect _ modname = function
    | [ _stackv4v6; _dns_client; happy_eyeballs ] ->
        code ~pos:__POS__ {ocaml|%s.connect %s|ocaml} modname happy_eyeballs
    | _ -> connect_err "mimic" 3
  in
  impl ~packages ~connect "Mimic_happy_eyeballs.Make"
    (stackv4v6 @-> dns_client @-> happy_eyeballs @-> mimic)
