#pragma once

#include <stdio.h>
#include <assert.h>

#include <readline/readline.h>
#include <readline/history.h>

#include <iostream>
#include <map>
#include <stack>
#include <cxxabi.h>
using namespace std;

#include <QtWidgets/QApplication>
#include <QtWidgets/QWidget>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QLabel>
#include <QtDebug>

extern void arg(int argc, char* argv);  /// print command line argument

extern void init(int& argc, char* argv[]);

/// @brief stop system
/// @param[in] gui run constructed GUI
extern int fini(bool gui);

// extern QApplication* app;

struct VM;

struct Object {
    /// @name fields
    QString value;
    map<QString, Object*> slot;
    stack<Object*> nest;
    /// @name stack operations
    void push(Object* o);
    /// @name vocabulary
    Object* lookup(QString name);

    /// @brief execute object
    /// @param[in] vm execution context
    virtual void exec(VM* vm);

    /// @name garbage collector
    size_t ref;
    static Object* pool;
    Object* next;

    /// @name constructor
    Object(QString value);
    Object();
    virtual ~Object();

    /// @name dump/stringify
    virtual QString tag();
    virtual QString val();
    QString dump(QString prefix = "");
    QString head(QString prefix = "");
};

struct Primitive : Object {
    Primitive(QString value);
};

struct Sym : Primitive {
    Sym(QString value);
};

struct Active : Object {
    Active(QString value);
};

struct Cmd : Active {
    Cmd(QString value, void (*fn)(VM*));
    void (*_fn)(VM*);
    void exec(VM* vm);
};

struct VM : Active {
    VM(QString name);
};

extern VM vm;

extern int yylex();
extern int yylineno;
extern char* yytext;
extern FILE* yyin;
extern int yyparse();
extern void yyerror(QString msg);
#include "CAD.parser.hpp"
#define TOKEN(C, X)               \
    {                             \
        yylval.o = new C(yytext); \
        return X;                 \
    }
