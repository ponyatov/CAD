module window;

import config;

import std.stdio;
import std.format;
import std.string;

// uses https://wiki.dlang.org/Simpledisplay.d

class Window {
    string title; ///< window title
    short width, height; ///< window size
    Resize resize; ///< resizing mode
    Type type;
    bool hidden; ///< show window

    this(Window parent = null, string title = null,
            short width = config.Window.Width,
            short height = config.Window.Height, Resize resize = Resize.normal,
            Type type = Type.normal, bool hidden = false) {
        this.title = title is null ? this.toString : title;
        this.width = width;
        this.height = height;
        this.resize = resize;
        this.type = type;
        this.hidden = hidden;
    }

    override string toString() const @safe pure {
        return "Window:%s[%s@%s]".format(title, width, height);
    }

    void loop() {
        writeln(this);
    }

    void hide() {
        hidden = true;
    }

    void show() {
        hidden = false;
    }
}

/// @ref Window resize mode
enum Resize {
    fixed,
    normal,
    fullscreen
}

enum Type {
    normal, /// ordinary
    undecorated, /// no title, border and controls
    event, /// hidden dummy window for communication etc
    dropdown, /// menu bar -like menu
    popup, /// mouse/object -local popup menu
    bubble, /// notification
    dialog, /// system-wide dialog
    toolbar, /// short-click menu
}
