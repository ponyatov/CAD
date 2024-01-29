/// X11 bindings
module X;

import core.stdc.config;

extern (C) @nogc nothrow:

const uint X_PROTOCOL           = 11;   /* current protocol version */
const uint X_PROTOCOL_REVISION  = 0;    /* current minor version    */

alias c_ulong XID;
alias XID   Window;

/*****************************************************************
 * RESERVED RESOURCE AND CONSTANT DEFINITIONS
 *****************************************************************/
const XID       None            = 0;    /* universal null resource or null atom                                             */

