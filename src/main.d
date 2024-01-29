module main;

import std.stdio;

import window;

void main(string[] args) {
    writeln(args);
    (new Window(null, args[0])).loop();
}
