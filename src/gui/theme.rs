use crate::gx::color::{RGB, RGBA};
use sdl2::pixels::Color;

impl From<RGB> for sdl2::pixels::Color {
    fn from(value: RGB) -> Self {
        let RGB(r, g, b) = value;
        return Self::from((r, g, b));
    }
}

impl From<RGBA> for sdl2::pixels::Color {
    fn from(value: RGBA) -> Self {
        let RGBA(r, g, b, a) = value;
        return Self::from((r, g, b, a));
    }
}

pub const background: RGBA = RGBA(0x22, 0x22, 0x22, 0);
