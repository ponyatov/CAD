///! graphical primitives
use crate::gx::color;

pub struct Layer {
    z: u16,
}

/// User Coordinate System
pub struct UCS {
    x: i16,
    y: i16,
}

enum Prim {
    Line,
    Poly,
    Area,
}

/// classical TrueColor 24bit
/// single point
pub struct Point {
    ucs: Option<UCS>,
    x: i16,
    y: i16,
    color: color::RGB,
    visible: bool,
    layer: Option<Layer>,
    parent: Option<Prim>,
}

/// stroke line
pub struct Line {
    a: Point,
    b: Point,
    color: color::Color,
    visible: bool,
}

pub struct Poly {
    v: Vec<Line>,
    closed: bool,
    visible: bool,
}

pub struct Area {
    p: Poly,
    fill: Option<color::Color>,
    visible: bool,
}
