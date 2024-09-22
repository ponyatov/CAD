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
}

pub struct Poly {
    v: Vec<Line>,
    fill: Option<color::Color>,
    closed: bool,
}
