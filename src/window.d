module window;

import std.stdio;

class Window {
    string title;
    this(string title) {
        this.title = title;
    }

    override string toString() const @safe pure nothrow {
        return "Window:" ~ title;
    }

    void loop() {
        writeln(this);
    }
}
