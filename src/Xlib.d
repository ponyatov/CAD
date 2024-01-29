module Xlib;
import X;

import core.stdc.config;

extern (C) @nogc nothrow:

alias char* XPointer;

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
alias Display XDisplay;


