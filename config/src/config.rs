#![allow(non_upper_case_globals)]
#![allow(dead_code)]

pub mod gui {

    const VGA16: (u16, u16) = (640, 480);

    /// screen width, pixels
    pub const W: u16 = VGA16.1;
    /// screen height, pixels
    pub const H: u16 = VGA16.0;
}

#[test]
pub fn vga() {
    assert!(gui::W > 320);
    assert!(gui::H > 240);
}

// #[cfg(test)]
// pub mod test {
// }

pub mod server {
    use const_format::formatcp;

    pub const ip: &str = "localhost";
    pub const port: u16 = 12345;
    pub const url: &str = formatcp!("{ip}:{port}");
}
