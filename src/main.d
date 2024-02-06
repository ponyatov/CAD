module main;

import std.stdio;

import window;

import Xlib;
import core.stdc.config;

void main(string[] args) {
    writeln(args);
    assert(Xlib.XEvent.sizeof == 192);
    assert(c_long.sizeof * 24 == 192);
    assert(Xlib.XAnyEvent.sizeof < 192);
    assert(Xlib.XErrorEvent.sizeof < 192);
    (new Window(null, args[0])).loop();
}
