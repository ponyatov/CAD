///! graphical primitives
use crate::gx::color;

/// classical TrueColor 24bit
/// single point
pub struct Point {
    x: i16,
    y: i16,
    color: color::RGB,
    visible: bool,
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
