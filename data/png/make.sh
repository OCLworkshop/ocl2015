#!/bin/bash

 ###############################################################################
 # OCL 2015
 #
 # Copyright (c) 2013-2016 Université Paris-Sud, France
 #               2013-2016 IRT SystemX, France
 #
 # All rights reserved.
 #
 # Redistribution and use in source and binary forms, with or without
 # modification, are permitted provided that the following conditions are
 # met:
 #
 #     * Redistributions of source code must retain the above copyright
 #       notice, this list of conditions and the following disclaimer.
 #
 #     * Redistributions in binary form must reproduce the above
 #       copyright notice, this list of conditions and the following
 #       disclaimer in the documentation and/or other materials provided
 #       with the distribution.
 #
 #     * Neither the name of the copyright holders nor the names of its
 #       contributors may be used to endorse or promote products derived
 #       from this software without specific prior written permission.
 #
 # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 # "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 # LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 # A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 # OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 # SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 # LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 # DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 # THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 # OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 ###############################################################################

set -x
set -e

dir=output
fic=deadline

lodraw --convert-to pdf $fic.odg
pdfcrop --margins "0 4 0 0" $fic.pdf
mv "$fic-crop.pdf" $fic.pdf
gs -dNOPAUSE -dBATCH -sDEVICE=pngalpha -r200 -sOutputFile=$dir/$fic.png $fic.pdf
rm $fic.pdf
f=$dir/$fic.2.png
pngcrush -rem gAMA -rem cHRM -rem iCCP -rem sRGB $dir/$fic.png $f
mv $f $dir/$fic.png

# see also: https://openclipart.org/download/121621/Maple-Leaf-by-Merlin2525.svg
# see also: https://openclipart.org/download/65851/1276282624.svg
# see also: https://openclipart.org/download/212393/rodentia-icons_news-feed.svg
# see also: https://openclipart.org/download/140251/messy-lined-papers.svg
# see also: https://openclipart.org/download/3297/barretr-Pencil.svg
