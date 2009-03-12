! Copyright (C) 2009 Daniel Ehrenberg
! See http://factorcode.org/license.txt for BSD license.
USING: sequences splitting kernel math.parser io.files io.encodings.ascii biassocs ;
IN: simple-flat-file

: drop-comments ( seq -- newseq )
    [ "#" split1 drop ] map harvest ;

: split-column ( line -- columns )
    " \t" split harvest 2 short head 2 f pad-tail ;

: parse-hex ( s -- n )
    dup [
        "0x" ?head [ "U+" ?head [ "Missing 0x or U+" throw ] unless ] unless
        hex>
    ] when ;

: parse-line ( line -- code-unicode )
    split-column [ parse-hex ] map ;

: process-codetable-lines ( lines -- assoc )
    drop-comments [ parse-line ] map ; 

: flat-file>biassoc ( filename -- biassoc )
    ascii file-lines process-codetable-lines >biassoc ;

