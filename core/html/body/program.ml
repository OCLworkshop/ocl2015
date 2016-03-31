(*****************************************************************************
 * OCL 2015
 *
 * Copyright (c) 2013-2016 Université Paris-Sud, France
 *               2013-2016 IRT SystemX, France
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

open Api

module Program : PAGE = struct
  let file = "program.html"
  let title = "Program"

  module L = BatList
  module S = BatString

  let f_author = L.partition (function "author_info", _ -> true | _ -> false)
  let f_speaker = L.partition (function "speaker", _ -> true | _ -> false)

  let l = L.map (function time, chair, l -> 
            let l = 
              L.map (function time, abstract, l_author, title, l ->
                             let l_author_info, l = f_author l in
                             let l_speaker, l = match f_speaker l with
                                                | [_, speaker], l -> [ <:html< <div style="font-style:italic">Speaker: $str: speaker $</div> >>], l
                                                | _ -> [], l in
                             let l_author, (l_author_info1, l_author_info2) = 
                               let l1, l2 =
                                 let pat = ", " in
                                 L.split (L.map2 (fun (_, info) author ->
                                                    let motif, author = 
                                                      match author with motif, (author, None) ->
                                                                          motif, <:html< <span style="color:#337AB7">$str: author $</span> >>
                                                                      | motif, (author, Some ln) ->
                                                                          motif, <:html< <span><a href=$str: ln $>$str: author$</a></span> >> in
                                                    let info1, info2 = S.rsplit info ~by:pat in
                                                    <:html< <td style="width:3em;background-color:#F8F8F8;color:#727272">$str: motif $</td><td style="font-size:120%;padding-left:0.5em;padding-right:0.5em">$list: [author] $</td> >>,
                                                    (<:html< <td style="background-color:#F8F8F8"></td><td style="padding-left:0.5em;padding-right:0.5em">$str: info1 $</td> >>,
                                                    <:html< <td style="background-color:#F8F8F8"></td><td style="color:#727272;padding-left:0.5em;padding-right:0.5em">$str: info2 $</td> >>))
                                                 (match l_author_info, l_author with [], [_] -> ["", pat]
                                                                                   | _ when L.length l_author_info = L.length l_author -> l_author_info)
                                                 l_author) in
                               l1, L.split l2 in
                             let l =
                               let l = L.map (function name, ln -> <:html< <a href=$str: ln $ style="margin-left:1em;color:#B3001D"><b>$str: name$</b></a> >>) l in
                               if abstract = None then
                                 l
                               else 
                                 <:html< <a href=$str: "#" ^ CFP.short_time time $ style="color:#B3001D"><b>abstract</b></a> >> :: l in
                             <:html< <li><div style="color:#727272">$str: time $</div>
                                         <div style="font-size:120%"><b>$str: title $</b></div>
                                         $list: l$
                                         $list: l_speaker $
                                         <table style="text-align:center"><tbody><tr>$list: l_author $</tr><tr>$list: l_author_info1 $</tr><tr>$list: l_author_info2 $</tr></tbody></table></li> >>) l in
            let chair = match chair with None -> [] | Some chair -> [ <:html< <div style="text-align:right;font-style:italic">$str: chair $</div> >> ] in
            <:html< <hr></hr><h4>$str: time $</h4>$list: chair $<div><ul style="padding-left:8em">$list: l $</ul></div> >>) CFP.program

  let l_abstract = L.map (function time, _, l -> 
            let time = let by = " " in S.concat by L.(tl (tl (tl (S.nsplit time ~by)))) in
            let l = 
              L.map (function time, abstract, _, title, l ->
                             match abstract with
                               None -> <:html< >>
                             | Some s -> 
                               let _, l = f_author l in
                               let _, l = f_speaker l in
                               let l_abstract =
                                 let l = L.map (fun s -> <:html< <div style="text-align:justify">$str: s $</div> >>) (S.nsplit s ~by:"\n\n") in
                                 <:html< $list: l $ >>  in
                               let l = L.map (function name, ln -> <:html< <a href=$str: ln $><b>$str: name$</b></a> >>) l in
                               <:html< <a name=$str: CFP.short_time time $><div style="color:#727272">$str: time $</div></a>
                                       <div><b>$str: title $</b></div>
                                       $list: [l_abstract] $
                                       <br></br> >>) l in
            let l = if l = [] then l else <:html< <hr></hr><div style="text-align:right;font-style:italic">$str: time $</div> >> :: l in
            <:html< $list: l $ >>) CFP.program

  let body = body ("Program Overview", <:html<
<a href="http://cruise.eecs.uottawa.ca/models2015/workshops.html"><b>Workshop Room: Panorama</b></a>
$list: l $
        <hr></hr>
        <div style="margin-top:100px;text-align: center"><h3><b>Abstract</b></h3></div>
$list: l_abstract $
>>)
end
