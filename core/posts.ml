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
open Header
open Printf

let body_item =
  [ (module Index.Index : PAGE)
  ; (module CallForContributions.CallForContributions : PAGE)
  ; (module Organizing.Organizing : PAGE)
  ; (module Program.Program : PAGE)
  ; (module Registration.Registration : PAGE)
  ; (module Information.Information : PAGE)
  ; (module Contact.Contact : PAGE)
  ; (module PastEditions.PastEditions : PAGE) ]

let menu =
  let a v1 v2 = Atom (v1, v2) in
  let l v1 v2 v3 = Long (v1, v2, v3) in
  l false "Home"
      [ "index.html", "OCL 2015"
      ; CFP.models2015, "MODELS 2015" ]
  ::
  BatList.map (fun page -> let module Page = (val page : PAGE) in
                           a Page.file Page.title)
              (List.tl body_item)

let () =
  let dir_root = try Sys.argv.(1) with _ -> failwith "name of the root directory where html files will be generated" in
  begin
    Random.init (int_of_float (Unix.time ()) / 86400);
    List.iter
      (let body_item = BatList.map (fun page -> let module Page = (val page : PAGE) in
                                                <:html< <a href=$str: Page.file $>$str: Page.title $</a> >>) body_item in
       fun page ->
        let module Page = (val page : PAGE) in
        X.output_html
          ~raw:(match Page.body with Body _ -> false | _ -> true)
          (sprintf "%s/%s" dir_root Page.file)
          (match Page.body with
           | Body (b_shuffle, title, body) ->
             let black_border = sprintf "width:%dpx" (720 (* total size of images *) + (succ 3 (* number of images *)) * Header.black_border) in
             let carousel1, carousel2 = Header.mk_carousel b_shuffle in
             <:html<
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <title>OCL 2015, Ottawa Canada</title>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />

  <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>

<body>
  <script type="text/javascript" src="js/jquery-1.11.2.min.js">$str: " "$</script>
  <script type="text/javascript" src="js/init.js">$str: " "$</script>
  <script type="text/javascript" src="js/bootstrap.min.js">$str: " "$</script>
  <div class="container">

    <table style="width:100%"><tbody><tr align="center">
      <td>
        <a href="index.html"><img src="images/ocl2015Logo.png" alt="OCL 2015 Ottawa" width="140" height="150"/></a>
      </td>
      <td>
        <div id="thecar" class="carousel slide" data-ride="carousel" data-interval="15000" style=$str: black_border $>
          <ol class="carousel-indicators" style="bottom:-12px">$list: [carousel1] $</ol>
          <div class="carousel-inner" role="listbox">$list: [carousel2] $</div>
        </div>
      </td>
    </tr></tbody></table>

    <hr/>

    <div class="navbar navbar-default">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#mynavbar-content">
            <span class="icon-bar">$str: " "$</span>
            <span class="icon-bar">$str: " "$</span>
            <span class="icon-bar">$str: " "$</span>
          </button>
        </div>
        <div class="collapse navbar-collapse" id="mynavbar-content">
        $list: [Header.html_of_menu menu] $
        </div>
      </div>
    </div>

    <hr/>

    <div class="row">
      <div class="col-md-8">

        <div style="text-align: center">
          <h4 style="color:#000080">15th International Workshop on<br/><b>OCL and Textual Modeling</b></h4>
          <h5><div style="color:#777">co-located with</div><a href=$str: CFP.models2015 $><img src="images/models2015LogoFullsize2.png" alt="Models 2015 Ottawa" width="101" height="101"/></a></h5>
        </div>

        <noscript>
          <div>$list: body_item $</div>
        </noscript>

        <div style="text-align: center"><h3><b>$str: title $</b></h3></div>
        $list: [body] $

      </div>
      <div class="col-md-4">
        <div id="social">$str: " "$</div>
      </div>
    </div>
  </div>
  <div id="footer">$str: " "$</div>
</body>
             >>
           | No_header x -> x))

      (BatList.flatten [ [ (module Social.Social : PAGE)
                         ; (module Footer.Footer : PAGE) ]
                       ; body_item ])
  end
