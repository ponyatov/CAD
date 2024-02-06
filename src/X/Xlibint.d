/// Xlib intertnals
module Xlibint;

import core.stdc.config;

import X;
import Xlib;

extern (C) @nogc nothrow:

struct _XGC{
    XExtData*           ext_data;                       /* hook for extension to hang data                              */
    GContext            gid;                            /* protocol ID for graphics context                             */
    Bool                rects;                          /* boolean: TRUE if clipmask is list of rectangles              */
    Bool                dashes;                         /* boolean: TRUE if dash-list is really a list                  */
    c_ulong             dirty;                          /* cache dirty bits                                             */
    XGCValues           values;                         /* shadow structure of values                                   */
}
alias _XGC* GC;
