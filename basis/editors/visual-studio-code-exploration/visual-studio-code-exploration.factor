! Copyright (C) 2020 Doug Coleman.
! See http://factorcode.org/license.txt for BSD license.
USING: combinators editors editors.visual-studio-code
io.pathnames io.standard-paths kernel namespaces system
tools.which ;
IN: editors.visual-studio-code-exploration

SINGLETON: visual-studio-code-exploration

INSTANCE: visual-studio-code-exploration visual-studio-code-base

editor-class get-global dup [ visual-studio-code? not ] when
[ visual-studio-code-exploration editor-class set-global ] unless

M: visual-studio-code-exploration find-visual-studio-code-path
    os {
        { linux [ "code-exploration" which ] }
        { macosx [
            "com.microsoft.VSCodeExploration" find-native-bundle
            [ "Contents/MacOS/Electron" append-path ] [ f ] if* ] }
        { windows [
            { "Microsoft VS Code Exploration" } "code-exploration.cmd" find-in-applications ] }
    } case ;
