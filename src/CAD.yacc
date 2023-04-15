/** @file
    @brief parser */

%{
    #include "CAD.hpp"
%}

%defines %union { Object *o; }

%token<o> SYM

%type<o> ex

%%
grammar :
        | grammar ex { qDebug() << $2->dump(); };

ex : SYM { vm.lookup($1->value)->exec(&vm); };
