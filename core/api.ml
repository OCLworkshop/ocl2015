(*****************************************************************************
 * OCL 2015
 *
 * Copyright (c) 2013-2015 Université Paris-Sud, France
 *               2013-2015 IRT SystemX, France
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *
 *     * Neither the name of the copyright holders nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************)
(* $Id:$ *)

open Printf

type html_cts = Body of bool (* true: shuffle images *) * string * Cow.Html.t
              | No_header of Cow.Html.t

let body (s, h) = Body (true, s, h)

type ('a, 'b) menu = Atom of 'a
                   | Long of bool (* true: divider *) * 'b * 'a list

module type PAGE = sig
  val file : string (* filename *)
  val title : string (* in menubar *)
  val body : html_cts
end

module X = struct
  let output_html ?(raw=false) fic html_new =
    if Sys.file_exists fic then
      kprintf failwith "overwriting %S" (String.escaped fic)
    else
      let html_new_s = BatString.nreplace ~str:(Cow.Xml.to_string html_new) ~sub:"\"/>" ~by:"\" />" in
      begin
        ignore (Cow.Xml.of_string ~entity:Cow.Xhtml.entity html_new_s);
        BatFile.with_file_out fic (fun oc -> BatIO.nwrite oc (let page (*?(ns="")*) body =
                                                                "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\">"
                                                                (*"<!DOCTYPE html><html lang=\"en\">"*)  ^ (*ns*) body ^ "</html>" in
                                                              if raw then
                                                                html_new_s
                                                              else
                                                                page html_new_s));
      end
end

module CFP = struct
  open BatFile
  module L = BatList
  open BatString

  let content fic = L.of_enum (BatFile.lines_of fic)
  let content' fic = String.concat "\n" (content fic)

  let parse file =
    let rec aux l ll = function
      | x :: xs ->
        if try x.[0] = '=' with _ -> false then
          let tit :: "" :: xs = xs in
          aux [] ((tit, l) :: ll) xs
        else
          aux (x :: l) ll xs
      | [] -> ("", l) :: ll in
    aux [] [] @@ List.rev @@ let rec goto_empty = function
                               | "" :: xs -> xs
                               | _ :: xs -> goto_empty xs in
                             goto_empty @@ content file

  (* *)

  let models2015 = "http://cruise.eecs.uottawa.ca/models2015"
  let webpage = [Some "http://www.brucker.ch"; None; Some "http://www.db.informatik.uni-bremen.de/~gogolla"; Some "http://www.lri.fr/~tuong"]

  let [ intro_title, intro_body
      ; topics_title, topics_body
      ; venue_title, venue_body
      ; workshop_title, workshop_body
      ; submission_title, submission_body
      ; important_date_title, _
      ; _
      ; _ ] = parse "data/OCL-2015-WorkshopCFP.txt"
  let [ _
      ; organizer_title, organizer_body
      ; organizer_mail_title, organizer_mail_body
      ; pc_title, pc_body ] = parse "data/OCL-2015-organizer.txt"

  let split_nl = L.group_consecutive (fun a b -> a <> "" && b <> "")
  let conc = concat "\n"
  let sp x = splice x 0 2 ""
  let sp_people =
    L.map
      (fun who ->
        let by = ", " in
        let name, who = BatString.split who ~by in
        let univ, loc = BatString.rsplit who ~by in
        name, univ, loc)

  (* *)

  let intro_body1, intro_body2 =
    let [ _ ; [""] ; intro_body1 ; [""] ; intro_body2 ] = split_nl intro_body in
    conc intro_body1, conc intro_body2
  let topics_body1, topics_body2 =
    let [topics_body1 ; [""] ; topics_body2] = split_nl topics_body in
    L.map (fun s -> match nsplit (sp (conc s)) ~by:"\n  -- " with
                    | [x] -> <:html< <li>$str: x $</li> >>
                    | x :: xs ->
                      let xs = List.map (fun s -> <:html< <li>$str: s $</li> >>) xs in
                      <:html< <li>$str: x $<ul>$list: xs $</ul></li> >>)
          (L.group_consecutive (fun a b -> let f x = try x.[0] <> '-' with _ -> true in f a || f b) topics_body1),
    conc topics_body2
  let venue_body = conc venue_body
  let workshop_body = conc workshop_body
  let submission_body1, submission_body2 =
    let x0 :: xa :: xb :: xc :: xs = submission_body in
    <:html<
      $str: x0 $
      <ul><li>$str: sp xa $</li>
          <li>$str: sp xb $</li>
          <li>$str: sp xc $</li></ul> >>,
    L.map (fun s -> try
                              let h = "http" in
                              let s0, s = split s ("(" ^ h) in
                              let s1, s2 = split s ")" in
                              let s1 = h ^ s1 in
                              <:html<$str: s0 $(<a href=$str: s1 $>$str: s1 $</a>)$str: s2 $ >>
                    with _ -> <:html<$str: s $ >>)
          xs
  let important_date_body0 =
    let img =
      let now = Unix.(let t = gmtime (time ()) in succ t.tm_mon * 100 + t.tm_mday) in
      let rec aux = function
        | (x, y) :: xs -> if now >= x then Some ("images/deadline/" ^ y) else aux xs
        | _ -> None (*failwith "no pictures occurring before now"*) in
      aux (List.fast_sort (fun (a, _) (b, _) -> Pervasives.compare b a) (List.map (fun s -> int_of_string (fst (split s ~by:".")), s) (Array.to_list (try Sys.readdir "data/png/output" with _ -> [||])))) in
    match img with None -> <:html< >> | Some img ->
      <:html< <img src=$str: img $ alt=$str: important_date_title $ style="width:100%"></img> >>
  let organizer_body = sp_people organizer_body
  let pc_body = sp_people pc_body
end
