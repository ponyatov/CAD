#![allow(non_upper_case_globals)]

pub mod gui {
    /// screen width, pixels
    pub const W: u32 = 240;
    /// screen height, pixels
    pub const H: u32 = 320;
}

pub mod server {
    use const_format::formatcp;

    pub const ip: &str = "localhost";
    pub const port: u16 = 12345;
    pub const url: &str = formatcp!("{ip}:{port}");
}
