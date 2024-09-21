#![allow(non_upper_case_globals)]
#![allow(dead_code)]

pub mod gui {

    pub const VGA13: (u16, u16) = (320, 200);
    pub const QVGA: (u16, u16) = (320, 240);
    pub const VGA16: (u16, u16) = (640, 480);

    /// screen width, pixels
    pub const W: u16 = QVGA.1;
    /// screen height, pixels
    pub const H: u16 = QVGA.0;
}

#[test]
fn vga() {
    assert!(gui::W >= 240);
    assert!(gui::H >= 320);
}

pub mod server {
    use const_format::formatcp;

    pub const ip: &str = "localhost";
    pub const port: u16 = 12345;
    pub const url: &str = formatcp!("{ip}:{port}");
}
