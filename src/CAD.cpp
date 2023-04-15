#include "CAD.hpp"

void arg(int argc, char *argv) {  //
    qDebug() << "argv[" << argc << "] = <" << argv << ">";
}

QCoreApplication *app = nullptr;

void _gui(VM *vm) { exit(app->exec()); }

Cmd gui(".gui", _gui);

void init(int &argc, char *argv[]) {  //
    assert(app = new QCoreApplication(argc, argv));
}

int fini(bool gui) {
    if (gui)
        return app->exec();
    else
        return 0;
}

int main(int argc, char *argv[]) {
    arg(0, argv[0]);
    init(argc, argv);
    //
    for (int i = 1; i < argc; i++) {  //
        arg(i, argv[i]);
        assert(yyin = fopen(argv[i], "r"));
        yyparse();
        fclose(yyin);
    }
    //
    return fini(false);
}

void yyerror(QString msg) {
    qDebug() << "\n\n" << yylineno << ":" << msg << "[" << yytext << "]\n\n";
    exit(-1);
}

Cmd::Cmd(QString value, void (*fn)(VM *)) : Active(value) { _fn = fn; }

Active::Active(QString value) : Object(value) {}

Object::Object(QString value) : Object() {  //
    this->value = value;
}

Object *Object::pool = nullptr;

Object::Object() {
    ref = 0;
    next = pool;
    pool = this;
}

Object::~Object() {}

Primitive::Primitive(QString value) : Object(value) {}

Sym::Sym(QString value) : Primitive(value) {}

QString Object::tag() {
    int status;
    return QString(abi::__cxa_demangle(typeid(*this).name(), 0, 0, &status))
        .toLower();
}

QString Object::val() { return value; }

QString Object::head(QString prefix) {
    return (prefix + "<" + tag() + ":" + val() + ">" +
            QString::asprintf(" @%x", this));
}

QString Object::dump(QString prefix) { return head(prefix); }

void Object::exec(VM *vm) { vm->push(this); }

void Cmd::exec(VM *vm) { _fn(vm); }

void Object::push(Object *o) {
    nest.push(o);
    o->ref++;
}

VM::VM(QString name) : Active(name) {}

VM vm("FORTH");

Object *Object::lookup(QString name) {
    Object *o = slot[name];
    if (o == nullptr) { yyerror("unknown : " + name); }
    return o;
}
