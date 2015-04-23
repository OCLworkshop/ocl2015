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

module CallForContributions : PAGE = struct
  let file = "callForContributions.html"
  let title = "Call for Papers"

  let body = body ("Call for OCL Workshop Papers", (*<:html< <p></p> >>*) <:html<
<p style="text-align:justify">$str: CFP.intro_body1 $</p>
<p style="text-align:justify">$str: CFP.intro_body2 $</p>

<div style="text-align: center"><a href="OCL-2015-WorkshopCFP.txt">Plain text version of the CFP</a></div>

<div style="text-align: center"><h3><b>$str: CFP.topics_title $</b></h3></div>
<ul>$list: CFP.topics_body1 $</ul>
<div style="text-align:justify">$str: CFP.topics_body2 $</div>

<div style="text-align: center"><h3><b>$str: CFP.venue_title $</b></h3></div>
<p style="text-align:justify">$str: CFP.venue_body $</p>

<div style="text-align: center"><h3><b>$str: CFP.workshop_title $</b></h3></div>
<p style="text-align:justify">$str: CFP.workshop_body $</p>

<div style="text-align: center"><h3><b>$str: CFP.submission_title $</b></h3></div>
$list: [CFP.submission_body1] $
<div style="text-align:justify">$list: CFP.submission_body2 $</div>

<div style="text-align: center"><h3><b>$str: CFP.important_date_title $</b></h3></div>
$list: [CFP.important_date_body0] $

>> )
end
