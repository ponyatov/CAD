module window;

import config;

import std.stdio;
import std.format;
import std.string;

// uses https://wiki.dlang.org/Simpledisplay.d

class Window {
    string title; ///< window title
    short width, height; ///< window size

    this(string title, short width = config.Window.Width,
            short height = config.Window.Height,) {
        this.title = title;
        this.width = width;
        this.height = height;
    }

    override string toString() const @safe pure {
        return "Window:%s[%s@%s]".format(title, width, height);
    }

    void loop() {
        writeln(this);
    }
}
