/// X11 bindings
module X;

import core.stdc.config;

extern (C) @nogc nothrow:

const uint X_PROTOCOL           = 11;   /* current protocol version */
const uint X_PROTOCOL_REVISION  = 0;    /* current minor version    */

alias c_ulong XID;
alias c_ulong Atom;
alias c_ulong VisualID;
alias c_ulong Time;
alias XID   Window;
alias XID   Drawable;
alias XID   Font;
alias XID   Pixmap;
alias XID   Colormap;
alias XID   GContext;

/*****************************************************************
 * RESERVED RESOURCE AND CONSTANT DEFINITIONS
 *****************************************************************/
const XID       None            = 0;    /* universal null resource or null atom                                             */
