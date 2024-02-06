module Xlib;
import X;
import Xlibint;

import core.stdc.config;

extern (C) @nogc nothrow:

alias char* XPointer;

alias int Bool;
enum {
    False,
    True
}

/*
 * Extensions need a way to hang private data on some structures.
 */
struct XExtData{
    int number;                                         /* number returned by XRegisterExtension                        */
    XExtData* next;                                     /* next item on list of data for structure                      */
    extern (C) nothrow int function( XExtData* extension ) free_private;   /* called to free private storage                               */
    XPointer private_data;                              /* data private to this extension.                              */
}

/*
 * Data structure for setting graphics context.
 */

struct XGCValues{
    int function_;                                      /* logical operation                                            */
    c_ulong  plane_mask;                                /* plane mask                                                   */
    c_ulong  foreground;                                /* foreground pixel                                             */
    c_ulong  background;                                /* background pixel                                             */
    int line_width;                                     /* line width                                                   */
    int line_style;                                     /* LineSolid; LineOnOffDash; LineDoubleDash                     */
    int cap_style;                                      /* CapNotLast; CapButt; CapRound; CapProjecting                 */
    int join_style;                                     /* JoinMiter; JoinRound; JoinBevel                              */
    int fill_style;                                     /* FillSolid; FillTiled; FillStippled; FillOpaeueStippled       */
    int fill_rule;                                      /* EvenOddRule; WindingRule                                     */
    int arc_mode;                                       /* ArcChord; ArcPieSlice                                        */
    Pixmap tile;                                        /* tile pixmap for tiling operations                            */
    Pixmap stipple;                                     /* stipple 1 plane pixmap for stipping                          */
    int ts_x_origin;                                    /* offset for tile or stipple operations                        */
    int ts_y_origin;
    Font font;                                          /* default text font for text operations                        */
    int subwindow_mode;                                 /* ClipByChildren; IncludeInferiors                             */
    Bool graphics_exposures;                            /* boolean; should exposures be generated                       */
    int clip_x_origin;                                  /* origin for clipping                                          */
    int clip_y_origin;
    Pixmap clip_mask;                                   /* bitmap clipping; other calls for rects                       */
    int dash_offset;                                    /* patterned/dashed line information                            */
    char dashes;
}

alias _XGC* GC;

/*
 * Visual structure; contains information about colormapping possible.
 */
struct Visual{
    XExtData* ext_data;                                 /* hook for extension to hang data                              */
    VisualID visualid;                                  /* visual id of this visual                                     */
    int c_class;                                        /* class of screen (monochrome, etc.)                           */
    c_ulong  red_mask, green_mask, blue_mask;            /* mask values                                                  */
    int bits_per_rgb;                                   /* log base 2 of distinct color values                          */
    int map_entries;                                    /* color map entries                                            */
}

/*
 * Depth structure; contains information for each possible depth.
 */
struct Depth {
    int depth;                                          /* this depth (Z) of the depth                                  */
    int nvisuals;                                       /* number of Visual types at this depth                         */
    Visual* visuals;                                    /* list of visuals possible at this depth                       */
}

alias Display XDisplay;

struct Screen {
    XExtData* ext_data;                                 /* hook for extension to hang data                              */
    XDisplay* display;                                  /* back pointer to display structure                            */
    Window root;                                        /* Root window id.                                              */
    int width, height;                                  /* width and height of screen                                   */
    int mwidth, mheight;                                /* width and height of  in millimeters                          */
    int ndepths;                                        /* number of depths possible                                    */
    Depth* depths;                                      /* list of allowable depths on the screen                       */
    int root_depth;                                     /* bits per pixel                                               */
    Visual* root_visual;                                /* root visual                                                  */
    GC default_gc;                                      /* GC for the root root visual                                  */
    Colormap cmap;                                      /* default color map                                            */
    c_ulong  white_pixel;
    c_ulong  black_pixel;                               /* White and Black pixel values                                 */
    int max_maps, min_maps;                             /* max and min color maps                                       */
    int backing_store;                                  /* Never, WhenMapped, Always                                    */
    Bool save_unders;
    c_long root_input_mask;                               /* initial root input mask                                      */
}

/*
 * Format structure; describes ZFormat data the screen will understand.
 */
struct ScreenFormat{
    XExtData* ext_data;                                 /* hook for extension to hang data                              */
    int depth;                                          /* depth of this image format                                   */
    int bits_per_pixel;                                 /* bits/pixel at this depth                                     */
    int scanline_pad;                                   /* scanline must padded to this multiple                        */
}


/*
 * Display datatype maintaining display specific data.
 * The contents of this structure are implementation dependent.
 * A Display should be treated as opaque by application code.
 */

struct _XPrivate;                                        /* Forward declare before use for C++                          */
struct _XrmHashBucketRec;

struct _XDisplay{
    XExtData* ext_data;                                 /* hook for extension to hang data                              */
    _XPrivate* private1;
    int fd;                                             /* Network socket.                                              */
    int private2;
    int proto_major_version;                            /* major version of server's X protocol */
    int proto_minor_version;                            /* minor version of servers X protocol */
    char* vendor;                                       /* vendor of the server hardware */
    XID private3;
    XID private4;
    XID private5;
    int private6;
    extern (C) nothrow XID function(_XDisplay*) resource_alloc;             /* allocator function */
    int char_order;                                     /* screen char order, LSBFirst, MSBFirst */
    int bitmap_unit;                                    /* padding and data requirements */
    int bitmap_pad;                                     /* padding requirements on bitmaps */
    int bitmap_bit_order;                               /* LeastSignificant or MostSignificant */
    int nformats;                                       /* number of pixmap formats in list */
    ScreenFormat* pixmap_format;                        /* pixmap format list */
    int private8;
    int release;                                        /* release of the server */
    _XPrivate* private9, private10;
    int qlen;                                           /* Length of input event queue */
    c_ulong  last_request_read;                         /* seq number of last event read */
    c_ulong  request;                                   /* sequence number of last request. */
    XPointer private11;
    XPointer private12;
    XPointer private13;
    XPointer private14;
    uint max_request_size;                          /* maximum number 32 bit words in request*/
    _XrmHashBucketRec* db;
    extern (C) nothrow int function( _XDisplay* )private15;
    char* display_name;                             /* "host:display" string used on this connect*/
    int default_screen;                             /* default screen for operations */
    int nscreens;                                   /* number of screens on this server*/
    Screen* screens;                                /* pointer to list of screens */
    c_ulong motion_buffer;                          /* size of motion buffer */
    c_ulong private16;
    int min_keycode;                                /* minimum defined keycode */
    int max_keycode;                                /* maximum defined keycode */
    XPointer private17;
    XPointer private18;
    int private19;
    char* xdefaults;                                /* contents of defaults from server */
    /* there is more to this structure, but it is private to Xlib */
}
alias _XDisplay Display;
alias _XDisplay* _XPrivDisplay;

struct XKeyEvent{
    int type;                                           /* of event                                                     */
    c_ulong  serial;                                    /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;                                      /* "event" window it is reported relative to                    */
    Window root;                                        /* root window that the event occurred on                       */
    Window subwindow;                                   /* child window                                                 */
    Time time;                                          /* milliseconds                                                 */
    int x, y;                                           /* pointer x, y coordinates in event window                     */
    int x_root, y_root;                                 /* coordinates relative to root                                 */
    uint state;                                         /* key or button mask                                           */
    uint keycode;                                       /* detail                                                       */
    Bool same_screen;                                   /* same screen flag                                             */
}

alias XKeyEvent XKeyPressedEvent;
alias XKeyEvent XKeyReleasedEvent;

struct XButtonEvent{
    int type;                                           /* of event                                                     */
    c_ulong  serial;                                    /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;                                      /* "event" window it is reported relative to                    */
    Window root;                                        /* root window that the event occurred on                       */
    Window subwindow;                                   /* child window                                                 */
    Time time;                                          /* milliseconds                                                 */
    int x, y;                                           /* pointer x, y coordinates in event window                     */
    int x_root, y_root;                                 /* coordinates relative to root                                 */
    uint state;                                         /* key or button mask                                           */
    uint button;                                        /* detail                                                       */
    Bool same_screen;                                   /* same screen flag                                             */
}
alias XButtonEvent XButtonPressedEvent;
alias XButtonEvent XButtonReleasedEvent;

struct XMotionEvent{
    int type;                                           /* of event                                                     */
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;                                      /* "event" window reported relative to                          */
    Window root;                                        /* root window that the event occurred on                       */
    Window subwindow;                                   /* child window                                                 */
    Time time;                                          /* milliseconds                                                 */
    int x, y;                                           /* pointer x, y coordinates in event window                     */
    int x_root, y_root;                                 /* coordinates relative to root                                 */
    uint state;                                         /* key or button mask                                           */
    char is_hint;                                       /* detail                                                       */
    Bool same_screen;                                   /* same screen flag                                             */
}
alias XMotionEvent XPointerMovedEvent;

struct XCrossingEvent{
    int type;                                           /* of event                                                     */
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;                                      /* "event" window reported relative to                          */
    Window root;                                        /* root window that the event occurred on                       */
    Window subwindow;                                   /* child window                                                 */
    Time time;                                          /* milliseconds                                                 */
    int x, y;                                           /* pointer x, y coordinates in event window                     */
    int x_root, y_root;                                 /* coordinates relative to root                                 */
    int mode;                                           /* NotifyNormal, NotifyGrab, NotifyUngrab                       */
    int detail;
    /*
     * NotifyAncestor, NotifyVirtual, NotifyInferior,
     * NotifyNonlinear,NotifyNonlinearVirtual
     */
    Bool same_screen;                                   /* same screen flag                                             */
    Bool focus;                                         /* boolean focus                                                */
    uint state;                                         /* key or button mask                                           */
}
alias XCrossingEvent XEnterWindowEvent;
alias XCrossingEvent XLeaveWindowEvent;

struct XFocusChangeEvent{
    int type;                                           /* FocusIn or FocusOut                                          */
    c_ulong serial;                                     /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;                                      /* window of event                                              */
    int mode;                                           /* NotifyNormal, NotifyWhileGrabbed,*/
                                                        /* NotifyGrab, NotifyUngrab */
    int detail;
    /*
     * NotifyAncestor, NotifyVirtual, NotifyInferior,
     * NotifyNonlinear,NotifyNonlinearVirtual, NotifyPointer,
     * NotifyPointerRoot, NotifyDetailNone
     */
}
alias  XFocusChangeEvent XFocusInEvent;
alias  XFocusChangeEvent XFocusOutEvent;

                                                        /* generated on EnterWindow and FocusIn  when KeyMapState selected */
struct XKeymapEvent{
    int type;
    c_ulong serial;                                     /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;
    char[32] key_vector;
}

struct XExposeEvent{
    int type;
    c_ulong serial;                                     /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;
    int x, y;
    int width, height;
    int count;                                          /* if non-zero, at least this many more                         */
}

struct XGraphicsExposeEvent{
    int type;
    c_ulong serial;                                     /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Drawable drawable;
    int x, y;
    int width, height;
    int count;                                          /* if non-zero, at least this many more                         */
    int major_code;                                     /* core is CopyArea or CopyPlane                                */
    int minor_code;                                     /* not defined in the core                                      */
}

struct XNoExposeEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Drawable drawable;
    int major_code;                                     /* core is CopyArea or CopyPlane                                */
    int minor_code;                                     /* not defined in the core                                      */
}

struct XVisibilityEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;
    int state;                                          /* Visibility state                                             */
}

struct XCreateWindowEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window parent;                                      /* parent of the window                                         */
    Window window;                                      /* window id of window created                                  */
    int x, y;                                           /* window location                                              */
    int width, height;                                  /* size of window                                               */
    int border_width;                                   /* border width                                                 */
    Bool override_redirect;                             /* creation should be overridden                                */
}

struct XDestroyWindowEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window event;
    Window window;
}

struct XUnmapEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window event;
    Window window;
    Bool from_configure;
}

struct XMapEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window event;
    Window window;
    Bool override_redirect;                             /* boolean, is override set...                                  */
}

struct XMapRequestEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window parent;
    Window window;
}

struct XReparentEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window event;
    Window window;
    Window parent;
    int x, y;
    Bool override_redirect;
}

struct XConfigureEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window event;
    Window window;
    int x, y;
    int width, height;
    int border_width;
    Window above;
    Bool override_redirect;
}

struct XGravityEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window event;
    Window window;
    int x, y;
}

struct XResizeRequestEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;
    int width, height;
}

struct XConfigureRequestEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window parent;
    Window window;
    int x, y;
    int width, height;
    int border_width;
    Window above;
    int detail;                                         /* Above, Below, TopIf, BottomIf, Opposite                      */
    c_ulong value_mask;
}

struct XCirculateEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window event;
    Window window;
    int place;                                          /* PlaceOnTop, PlaceOnBottom                                    */
}

struct XCirculateRequestEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window parent;
    Window window;
    int place;                                          /* PlaceOnTop, PlaceOnBottom                                    */
}

struct XPropertyEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;
    Atom atom;
    Time time;
    int state;                                          /* NewValue, Deleted                                            */
}

struct XSelectionClearEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;
    Atom selection;
    Time time;
}

struct XSelectionRequestEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window owner;
    Window requestor;
    Atom selection;
    Atom target;
    Atom property;
    Time time;
}

struct XSelectionEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window requestor;
    Atom selection;
    Atom target;
    Atom property;                                      /* ATOM or None                                                 */
    Time time;
}

struct XColormapEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;
    Colormap colormap;                                  /* COLORMAP or None                                             */
    Bool c_new;                                         /* C++                                                          */
    int state;                                          /* ColormapInstalled, ColormapUninstalled                       */
}

struct XClientMessageEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;
    Atom message_type;
    int format;
    union _data  {
                    char[20] b;
                    short[10] s;
                    c_long[5] l;
                }
	_data data;
}

struct XMappingEvent{
    int type;
    c_ulong serial;                                       /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;                                      /* unused                                                       */
    int request;                                        /* one of MappingModifier, MappingKeyboard, MappingPointer      */
    int first_keycode;                                  /* first keycode                                                */
    int count;                                          /* defines range of change w. first_keycode                     */
}

struct XErrorEvent{
    int type;
    Display* display;                                   /* Display the event was read from                              */
    XID resourceid;                                     /* resource id                                                  */
    c_ulong  serial;                                    /* serial number of failed request                              */
    ubyte error_code;                                   /* error code of failed request                                 */
    ubyte request_code;                                 /* Major op-code of failed request                              */
    ubyte minor_code;                                   /* Minor op-code of failed request                              */
}

struct XAnyEvent{
    int type;
    c_ulong serial;                                      /* # of last request processed by server                        */
    Bool send_event;                                    /* true if this came from a SendEvent request                   */
    Display* display;                                   /* Display the event was read from                              */
    Window window;                                      /* window on which event was requested in event mask            */
}


/***************************************************************
 *
 * GenericEvent.  This event is the standard event for all newer extensions.
 */

struct XGenericEvent {
    int            type;                                /* of event. Always GenericEvent                                */
    c_ulong        serial;                              /* # of last request processed                                  */
    Bool           send_event;                          /* true if from SendEvent request                               */
    Display*       display;                             /* Display the event was read from                              */
    int            extension;                           /* major opcode of extension that caused the event              */
    int            evtype;                              /* actual event type.                                           */
}

struct XGenericEventCookie{
    int            type;                                /* of event. Always GenericEvent                                */
    c_ulong        serial;                              /* # of last request processed                                  */
    Bool           send_event;                          /* true if from SendEvent request                               */
    Display*       display;                             /* Display the event was read from                              */
    int            extension;                           /* major opcode of extension that caused the event              */
    int            evtype;                              /* actual event type.                                           */
    uint           cookie;
    void*          data;
}

/*
 * this union is defined so Xlib can always use the same sized
 * event structure internally, to avoid memory fragmentation.
 */
 union XEvent {
    int type;                                           /* must not be changed; first element                           */
    XAnyEvent xany;
    XKeyEvent xkey;
    XButtonEvent xbutton;
    XMotionEvent xmotion;
    XCrossingEvent xcrossing;
    XFocusChangeEvent xfocus;
    XExposeEvent xexpose;
    XGraphicsExposeEvent xgraphicsexpose;
    XNoExposeEvent xnoexpose;
    XVisibilityEvent xvisibility;
    XCreateWindowEvent xcreatewindow;
    XDestroyWindowEvent xdestroywindow;
    XUnmapEvent xunmap;
    XMapEvent xmap;
    XMapRequestEvent xmaprequest;
    XReparentEvent xreparent;
    XConfigureEvent xconfigure;
    XGravityEvent xgravity;
    XResizeRequestEvent xresizerequest;
    XConfigureRequestEvent xconfigurerequest;
    XCirculateEvent xcirculate;
    XCirculateRequestEvent xcirculaterequest;
    XPropertyEvent xproperty;
    XSelectionClearEvent xselectionclear;
    XSelectionRequestEvent xselectionrequest;
    XSelectionEvent xselection;
    XColormapEvent xcolormap;
    XClientMessageEvent xclient;
    XMappingEvent xmapping;
    XErrorEvent xerror;
    XKeymapEvent xkeymap;
    XGenericEvent xgeneric;
    XGenericEventCookie xcookie;
    c_long[24] pad;
};


/*
 * X function declarations.
 */

extern Window XCreateSimpleWindow(
    Display*                                            /* display                                                      */,
    Window                                              /* parent                                                       */,
    int                                                 /* x                                                            */,
    int                                                 /* y                                                            */,
    uint                                                /* width                                                        */,
    uint                                                /* height                                                       */,
    uint                                                /* border_width                                                 */,
    c_ulong                                             /* border                                                       */,
    c_ulong                                             /* background                                                   */
);

extern c_ulong XBlackPixel(
    Display*                                            /* display                                                      */,
    int                                                 /* screen_number                                                */
);
extern c_ulong XWhitePixel(
    Display*                                            /* display                                                      */,
    int                                                 /* screen_number                                                */
);

extern int XDefaultScreen(
    Display*                                            /* display                                                      */
);

extern Window XRootWindow(
    Display*                                            /* display                                                      */,
    int                                                 /* screen_number                                                */
);

extern Display* XOpenDisplay(
    char*                                               /* display_name                                                 */
);

extern int XDestroyWindow(
    Display*                                            /* display                                                      */,
    Window                                              /* w                                                            */
);

extern int XMapWindow(
    Display*                                            /* display                                                      */,
    Window                                              /* w                                                            */
);

extern int XUnmapWindow(
    Display*                                            /* display                                                      */,
    Window                                              /* w                                                            */
);

extern int XNextEvent(
    Display*                                            /* display                                                      */,
    XEvent*                                             /* event_return                                                 */
);

