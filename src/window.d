module window;

import std.stdio;

// uses https://wiki.dlang.org/Simpledisplay.d

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
