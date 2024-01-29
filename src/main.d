module main;

import std.stdio;

import window;

void main(string[] args) {
    writeln(args);
    (new Win(null, args[0])).loop();
}
