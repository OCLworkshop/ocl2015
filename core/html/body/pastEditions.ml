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
(* $Id:$ *)

open Api

module PastEditions : PAGE = struct
  let file = "pastEditions.html"
  let title = "Past Editions"

  let f a =
    [ a "http://www.software.imdea.org/OCL2014/" "OCL 2014" "Valencia"
    ; a "http://ocl2013.inf.mit.bme.hu/" "OCL 2013" "Miami"
    ; a "http://st.inf.tu-dresden.de/OCL2012/" "OCL 2012" "Innsbruck"
    ; a "http://gres.uoc.edu/OCL2011/" "OCL 2011" "Zurich"
    ; a "http://modeling-languages.com/events/OCLWorkshop2010/" "OCL 2010" "Oslo"
    ; a "http://modeling-languages.com/events/OCLWorkshop2009/" "OCL 2009" "Colorado"
    ; a "http://fots.ua.ac.be/events/ocl2008/" "OCL 2008" "Toulouse"
    ; a "http://st.inf.tu-dresden.de/Ocl4All2007/" "OCL 2007" "Nashville"
    ; a "http://st.inf.tu-dresden.de/OCLApps2006/" "OCL 2006" "Genova"
    ; a "http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.175.1503&amp;rep=rep1&amp;type=pdf" "OCL 2005" "Montego Bay"
    ; a "http://www.cs.kent.ac.uk/projects/ocl/oclmdewsuml04/" "OCL 2004" "Lisbon"
    ; a "http://www.informatik.uni-trier.de/~ley/db/journals/entcs/entcs102.html#Schmitt04" "OCL 2003" "San Francisco"
    ; a "http://www.cs.toronto.edu/uml2001/workshop.html" "OCL 2001" "Toronto"
    ; a "http://www.comp.brad.ac.uk/research/OCL2000/index.html" "OCL 2000" "York" ]

  let l = f (fun href a city -> <:html< <tr><td><a href=$str: href $>$str: a $</a></td><td style="padding-left:8px">$str: city $</td></tr> >>)

  let body = body ("Other Editions of OCL Workshop", <:html<
<table style="margin-left:auto;margin-right:auto">$list: l $</table>
>>)
end
