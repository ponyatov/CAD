module window;

import config;

import std.stdio;
import std.format;
import std.string;

// https://github.com/ZILtoid1991/x11d/blob/master/test/app.d

import x11.Xlib;
import x11.X;

// uses https://wiki.dlang.org/Simpledisplay.d

class Win {
    Window window; ///< X11 hwnd
    Win parent; ///< parent window in GUI tree
    string title; ///< window title
    short width, height; ///< window size
    Resize resize; ///< resizing mode
    Type type;
    bool hidden; ///< show window

    private static __gshared Display* display; ///< global X11 display

    this(Win parent = null, string title = null, short width = config.Win.width,
            short height = config.Win.height, Resize resize = Resize.normal,
            Type type = Type.normal, bool hidden = false) {
        if (display is null) {
            display = XOpenDisplay(null);
            assert(display !is null);
        }
        this.parent = parent;
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
