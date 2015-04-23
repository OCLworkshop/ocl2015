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

module Contact : PAGE = struct
  let file = "contact.html"
  let title = "Contact"

  let color = "color:#878787"

  let name =
    BatList.interleave
      <:html< $str: ", " $ >>
      (BatList.map2
         (fun ln name ->
           match ln with
           | None -> <:html< $str: name $ >>
           | Some ln -> <:html< <a href=$str: ln $ style=$str: color $>$str: name$</a> >>)
         CFP.webpage
         (BatList.map (fun (p, _, _) -> p) CFP.organizer_body))

  let td_style = ""

  let arobase =
    <:html< <tr><td style=$str: td_style $></td><td style=$str: td_style $><a title=$str: "(e.g. how to solve this puzzle in OCL? )" $ href="#" style="color:#333">@</a></td><td style=$str: td_style $></td></tr> >>

  let l =
    arobase ::
      BatList.map
        (fun s ->
          let [n1; n2] = BatString.nsplit s ~by:"£" in
          <:html< <tr><td style=$str: "text-align:right;" ^ td_style $>$str: n1 $</td><td style=$str: td_style $></td><td style=$str: td_style $>$str: n2 $</td></tr>
                  $list: [arobase] $ >>)
        CFP.organizer_mail_body

  let body = body ("Contact", <:html<
<p style=$str: color $>Please contact the organizers with any comments or questions you may have.</p>
<table style="margin: 20px auto 20px auto">$list: l $</table>
<p style=$str: "text-align:right;" ^ color $>$list: name $</p>
>>)
end
