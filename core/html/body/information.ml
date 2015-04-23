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

module Information : PAGE = struct
  let file = "information.html"
  let title = "Local Information"

  let venue = CFP.models2015 ^ "/venue.html"

  let body = body ("Venue and Conference Hotel", <:html<
        <p style="text-align:justify">The conference venue will be the <a
        href="https://www.deltahotels.com/Hotels/Delta-Ottawa-City-Centre"> Delta
        Ottawa City Centre</a>. The conference has arranged special rates at the hotel here: <a href=$str: venue $>$str: venue $</a>.</p>

<p style="text-align:justify">The hotel is recently renovated and is within a short walk of the Supreme Court, Parliament and the Canadian War Museum. It is also right on the main Transitway, enabling a quick bus ride to and from the airport.</p>

        <div style="text-align: center"><h3><b>Travel</b></h3></div>

        <p style="text-align:justify">Ottawa is the Capital of Canada and is accessible with direct flights
        from many US Cities, and also from London UK and Frankfurt. International
        attendees are urged to consider international flights landing in Ottawa. If
        you choose flights that land elsewhere in Canada (e.g. Toronto, Montreal,
        Vancouver) and then transfer to domestic flights to Ottawa, you will have
        to clear customs and immigration in the first city in which you land; this
        process includes collecting any checked baggage and then checking it again,
        so you should leave at least two hours of transfer time.</p>

        <p style="text-align:justify">For passengers leaving Ottawa, destined for US airports, you will go
        through US customs and immigration at the Ottawa airport on departure.</p>
>>)
end
