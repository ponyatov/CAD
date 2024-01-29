module main;

import std.stdio;

import window;

void main(string[] args) {
    writeln(args);
    (new Window(args[0])).loop();
}
