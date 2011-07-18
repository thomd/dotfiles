### To compile a JavaScript file into java byte code invoke the following class

    java org.mozilla.javascript.tools.jsc.Main script.js
    java script

from http://www.rhino-tutorial.buss.hk/tutorials/compile-javascript-file

# jsc
compile `Jsc.java` and add to `~/bin`:

    import org.mozilla.javascript.tools.jsc.Main;
    class Jsc {
        public static void main(String args[]){
             Main.main(args);
        }
    }

setup an alias:

    alias jsc="java Jsc $1"

compile and run:

    jsc script.js
    java script

