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

module Program : PAGE = struct
  let file = "program.html"
  let title = "Program"

  let l = BatList.map (function time, l -> 
            let l = 
              BatList.map (function time, l_author, title, l ->
                             let l_author = BatList.map (function motif, (author, None) -> <:html< <span>$str: motif $</span><span style="color:#337AB7">$str: author $</span> >>
                                                                | motif, (author, Some ln) -> <:html< <span>$str: motif $</span><a href=$str: ln $>$str: author$</a> >>) l_author in
                             let l = BatList.map (function name, ln -> <:html< <a href=$str: ln $>$str: name$</a> >>) l in
                             <:html< <li><div style="color:#727272">$str: time $</div>
                                         $list: l_author $
                                         <div><b>$str: title $</b></div>
                                         $list: l$</li> >>) l in
            <:html< <h4>$str: time $</h4><div><ul>$list: l $</ul></div> >>) CFP.program
  let body = body ("Program Overview", <:html<
$list: l $
>>)
end
