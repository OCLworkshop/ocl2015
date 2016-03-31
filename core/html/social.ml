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
open Printf

module Social : PAGE = struct
  let file = "social.html"
  let title = "Social"

  let js = try CFP.content' "data/twitter_js" with _ -> ""

  let js_open = sprintf "window.open(\"%s\");"

  let js1 = "http://twitter.com/modelsconf"
  let js2 = "http://twitter.com/oclworkshop"
  let js3 = "http://www.facebook.com/modelsconference"
  let js4 = "https://github.com/oclworkshop"

  let js3_o = js_open js3
  let js4_o = js_open js4

  let msg1 = try CFP.content' "data/twitter_msg" with _ -> ""
  (*https://support.twitter.com/articles/20170514*)
  (*https://www.facebook.com/help/cookies*)

  let color = "color:#5bc0de"
  let style = sprintf "width:100%%;text-align:left;%s" color
  let msg2 = sprintf "<button class=\"btn btn-default\" style=\"width:100%%;%s\" onclick=\"location.reload()\">Cancel</button>" color

  let js_default =
    String.concat " ; "
      [ sprintf "document.getElementById('%s').innerHTML = '%s'" "msg1" msg1
      ; sprintf "document.getElementById('%s').innerHTML = '%s'" "msg2" msg2
      ; js ]

  let but =
    BatList.map
      (fun x -> <:html< <tr><td style="padding-bottom:10px">$list: [x] $</td></tr> >>)
      [       <:html<
      <h1>
        <a href="http://github.com/OCLworkshop/ocl2015/commits/master.atom">
          News
          <img alt="rss" src="images/rodentia-icons_news-feed.png"></img>
        </a>
      </h1>
              >>
            ; <:html<
      <div id="msg1" class="small" style="text-align:justify;color:#767676"></div>
              >>
            ; <:html<
      <div id="msg2" class="small"></div>
              >>
            ; <:html<
      <a onclick=$str: js_default $ class="btn btn-default twitter-timeline" data-widget-id="459293712271409152" data-dnt="true"
              style=$str: style $
              title=$str: js2 $
              height="480"
              >Tweets by @oclworkshop</a>
              >>
            ; <:html<
      <a onclick=$str: js_default $ class="btn btn-default twitter-timeline" data-widget-id="349243762637164544" data-dnt="true"
              style=$str: style $
              title=$str: js1 $
              height="480"
              >Tweets by @modelsconf</a>
              >>
            ; <:html<
      <a onclick=$str: js3_o $ class="btn btn-default"
              style=$str: style $
              title=$str: js3 $
              >Find ModelsConference on Facebook</a>
              >>
            ; <:html<
      <a onclick=$str: js4_o $ class="btn btn-default"
              style=$str: style $
              title=$str: js4 $
              >Find OCLworkshop on GitHub</a>
              >>
      ]

  let body = No_header <:html<
<table>$list: but $</table>
>>
end
