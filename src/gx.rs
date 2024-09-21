/// 2D vector graphics engine

pub fn init() {
    log::info!(std::stringify!(init));
}

/// classical TrueColor 24bit
pub struct RGB {
    r: u8,
    g: u8,
    b: u8,
}

#[test]
fn rgb_size() {
    assert_eq!(3, core::mem::size_of::<RGB>());
}

/// TrueColor 24 bit + alpha channel
pub struct RGBA {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
}

#[test]
fn rgba_size() {
    assert_eq!(4, core::mem::size_of::<RGBA>());
}

pub enum Color {
    RGB,
    RGBA,
}

/// single point
pub struct Point {
    x: i16,
    y: i16,
    color: RGB,
    visible: bool,
}

/// stroke line
pub struct Line {
    a: Point,
    b: Point,
    color: Color,
}
