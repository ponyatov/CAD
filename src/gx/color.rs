pub struct RGB(pub u8, pub u8, pub u8);

#[test]
fn rgb_size() {
    assert_eq!(3, core::mem::size_of::<RGB>());
}

/// TrueColor 24 bit + alpha channel
pub struct RGBA(pub u8, pub u8, pub u8, pub u8);

#[test]
fn rgba_size() {
    assert_eq!(4, core::mem::size_of::<RGBA>());
}

pub enum Color {
    RGB,
    RGBA,
}
