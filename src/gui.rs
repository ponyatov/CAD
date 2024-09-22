#![allow(unused_variables)]

/// low-level GUI subsystem
extern crate sdl2;
use sdl2::Sdl;

pub fn init() {
    log::info!(std::stringify!(init));
    match mainloop() {
        Ok(()) => log::info!("Ok"),
        Err(e) => log::error!("SDL error: {}", e),
    }
}

#[test]
fn gui() {
    assert!(config::gui::W >= config::gui::QVGA.1);
}

fn mainloop() -> Result<(), String> {
    let sdl_context = sdl2::init()?;
    let video_subsystem = sdl_context.video()?;
    return Ok(());
}
