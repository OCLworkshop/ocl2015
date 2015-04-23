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
open Printf

module Header = struct

  type licence = By2 (* CC BY 2.0 *) | BySA2 (* CC BY-SA 2.0 *)

  let f a =
    [ a "https://www.flickr.com/photos/dexxus/9859155514" "gatineau by paul bica" "https://farm3.staticflickr.com/2811/9859155514_de0cab5b61_m.jpg" "240" "180" "gatineau" By2
    ; a "https://www.flickr.com/photos/15609463@N03/14276682652" "Kayaking in the clouds. by Jamie McCaffrey" "https://farm4.staticflickr.com/3740/14276682652_e3927c2729_m.jpg" "240" "160" "Kayaking in the clouds." By2
    ; a "https://www.flickr.com/photos/husseinabdallah/2087898581" "Ottawa - tulipes by abdallahh" "https://farm3.staticflickr.com/2147/2087898581_fe7bec9f2f_m.jpg" "240" "180" "Ottawa - tulipes" By2
    ; a "https://www.flickr.com/photos/tsaiproject/6704591049" "Ottawa Convention Centre by tsaiproject" "https://farm8.staticflickr.com/7026/6704591049_023d26e71f_m.jpg" "240" "150" "Ottawa Convention Centre" By2
    ; a "https://www.flickr.com/photos/ojbyrne/3109051957" "Merry Christmas From Ottawa by Owen Byrne" "https://farm4.staticflickr.com/3243/3109051957_7831bb16be_m.jpg" "240" "163" "Merry Christmas From Ottawa" By2
    ; a "https://www.flickr.com/photos/15609463@N03/15905171899" "A window on transit in Ottawa by Jamie McCaffrey" "https://farm9.staticflickr.com/8634/15905171899_d9b0aede01_m.jpg" "240" "169" "A window on transit in Ottawa" By2
    ; a "https://www.flickr.com/photos/15609463@N03/7695067138" "Royal Alexandra Interprovincial Bridge by Jamie McCaffrey" "https://farm8.staticflickr.com/7263/7695067138_aea24c4d88_m.jpg" "240" "160" "Royal Alexandra Interprovincial Bridge" By2
    ; a "https://www.flickr.com/photos/burgtender/4408085639" "6/52 Downtown by Pier-Luc Bergeron" "https://farm5.staticflickr.com/4038/4408085639_bd2679366f_m.jpg" "240" "161" "6/52 Downtown" BySA2
    ; a "https://www.flickr.com/photos/15609463@N03/14352038369" "Sorry mister - I didn't know I was trespassing. by Jamie McCaffrey" "https://farm4.staticflickr.com/3876/14352038369_7fc9f61a43_m.jpg" "240" "160" "Sorry mister - I didn't know I was trespassing." By2
    ; a "https://www.flickr.com/photos/15609463@N03/7485244366" "Canada Day Fireworks 2012 17 by Jamie McCaffrey" "https://farm8.staticflickr.com/7259/7485244366_cd9a2ed378_m.jpg" "240" "160" "Canada Day Fireworks 2012 17" By2
    ; a "https://www.flickr.com/photos/15609463@N03/11692103706" "A very cold New Year's Eve by Jamie McCaffrey" "https://farm6.staticflickr.com/5515/11692103706_b59eff7e2d_m.jpg" "240" "160" "A very cold New Year's Eve" By2
    ; a "https://www.flickr.com/photos/cpstorm/146691217" "Rink of Fire by C.P.Storm" "https://farm1.staticflickr.com/44/146691217_d46da69345_m.jpg" "240" "160" "Rink of Fire" By2
    ; a "https://www.flickr.com/photos/92414546@N04/14577349537" "The Wilson Mill by davejdoe" "https://farm3.staticflickr.com/2909/14577349537_66c3392a9c_m.jpg" "240" "160" "The Wilson Mill" By2
    ; a "https://www.flickr.com/photos/15609463@N03/7618826242" "John G. Diefenbaker Building - Old Ottawa City Hall by Jamie McCaffrey" "https://farm9.staticflickr.com/8294/7618826242_9597bbdf71_m.jpg" "240" "159" "John G. Diefenbaker Building - Old Ottawa City Hall" By2
    ; a "https://www.flickr.com/photos/15609463@N03/8440926025" "Winterlude Sea Horses in Ice by Jamie McCaffrey" "https://farm9.staticflickr.com/8468/8440926025_a52e8c4c29_m.jpg" "240" "171" "Winterlude Sea Horses in Ice" By2 ]

  let black_border = 4

  let window_open = sprintf "window.open('%s');"

  let l_group =
    let a url_main title url_short width height alt cc =
      url_main, sprintf "%s (%s) [%s]" title url_main (match cc with
                                                       | By2 -> "CC BY 2.0 (http://creativecommons.org/licenses/by/2.0)"
                                                       | BySA2 -> "CC BY-SA 2.0 (http://creativecommons.org/licenses/by-sa/2.0)") in
    BatList.group_consecutive
      (fun a b -> let f x = fst x / 3 in (f a) = (f b))
      (BatList.mapi
         (fun i (ln, title) ->
           let src = sprintf "images/%d.jpg" i
           and onclick = window_open ln in
           i, <:html< <img title=$str: title $ alt=$str: title $ src=$str: src $ onclick=$str: onclick $ style="cursor:pointer"></img> >>)
         (f a))

  let shuffle l = Array.to_list (BatRandom.shuffle (BatList.enum l))

  let mk_carousel b_shuffle =
    let height = sprintf "height:%dpx" (int_of_string (BatList.max (f (fun url_main title url_short width height alt cc -> height))) + 2 * black_border) in
    match
    BatList.mapi
      (fun i -> function (_, x) :: xs ->
        let i = sprintf "%d" i
        and l =
          (let style = sprintf "background-color:#000000;padding:%dpx" black_border in
           <:html< <td style=$str: style $>$list: [x]$</td> >>)
          ::
            BatList.map (function _, img ->
              let style = sprintf "background-color:#000000;padding:%dpx %dpx %dpx 0px" black_border black_border black_border in
              <:html< <td style=$str: style $>$list: [img]$</td> >>) xs in
        ( <:html< <li data-target="#thecar" data-slide-to=$str: i $>$str: " "$</li> >>
        , <:html< <table style=$str: height $><tbody><tr>$list: l $</tr></tbody></table> >>))
      (if b_shuffle then shuffle l_group else l_group)
    with
    | (_, x) :: xs ->
      let l1, l2 = BatList.split (BatList.map (fun (a, x) -> a, <:html< <div class="item">$list: [x] $</div> >>) xs) in
      ( <:html< <li data-target="#thecar" data-slide-to="0" class="active">$str: " "$</li>$list: l1 $ >>
      , <:html< <div class="item active">$list: [x] $</div>$list: l2 $ >>)

  let html_of_menu l =
    let l = List.map (fun s ->
      let mk_atom file tit = <:html< <a href=$str: file $>$str: tit $</a> >> in
      let attr, l = match s with
        | Atom (file, tit) -> "", mk_atom file tit
        | Long (b, tit, l) -> "dropdown",
          let l =
            let l = List.map (fun (file, tit) -> let l = mk_atom file tit in <:html< <li>$list: [l] $</li> >>) l in
            if b then
              BatList.interleave <:html< <li class="divider">$str: " "$</li> >> l
            else
              l in
          <:html<
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">$str: tit $<b class="caret">$str: " "$</b></a>
            <ul class="dropdown-menu">$list: l $</ul> >>  in
      <:html< <li class=$str: attr $>$list: [l] $</li> >>) l in
    <:html< <ul class="nav navbar-nav">$list: l $</ul> >>
end
