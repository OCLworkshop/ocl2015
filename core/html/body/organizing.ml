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

open Api

module Organizing : PAGE = struct
  let file = "organizing.html"
  let title = "Committee"

  type 'a cts = Name of 'a
              | Title of Cow.Html.t

  let f x =
    let table =
      match x with
        | Name (ln, l) ->
          let f ln (name, univ, loc) =
            let name = match ln with None -> <:html< $str: name $ >> | Some ln -> <:html< <a href=$str: ln $>$str: name$</a> >> in
            <:html< <tr><td style="font-size:120%;padding-right:10px;color:#337AB7">$list: [name] $</td>
                        <td><span>$str: univ $</span>&nbsp;&nbsp;&nbsp;
                            <span style="color:#727272">$str: loc $</span></td></tr> >> in
          if ln = [] then
            BatList.map (f None) l
          else
            BatList.map2 f ln l
        | Title x -> [ <:html< <tr><td style="text-align:center">$list: [x] $</td></tr> >> ] in
    <:html< <table style="margin-left:auto;margin-right:auto">$list: table $</table> >>

  let l = List.map f [ Name (CFP.webpage, CFP.organizer_body)
                     ; Title <:html< <h3><b>$str: CFP.pc_title $</b></h3> >>
                     ; Name CFP.pc_body ]

  let body = body ("Workshop Organizers", <:html<
$list: l $
>>)
end
