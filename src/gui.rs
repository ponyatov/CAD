#![allow(unused_variables)]
#![allow(unused_mut)]

extern crate config;
extern crate log;

/// application configuration
/// low-level GUI subsystem
extern crate sdl2;
use sdl2::Sdl;

pub fn init(title: &str) {
    log::info!(std::stringify!(init));
    match mainloop(title) {
        Ok(()) => log::info!("Ok"),
        Err(e) => log::error!("SDL error: {}", e),
    }
}

#[test]
fn gui() {
    assert!(config::gui::W >= config::gui::QVGA.1);
}

fn mainloop(title: &str) -> Result<(), String> {
    let sdl_context = sdl2::init()?;
    let video_subsystem = sdl_context.video()?;
    let window = video_subsystem //
        .window(
            &title, //
            config::gui::W as u32,
            config::gui::H as u32,
        )
        // .position_centered()
        .build()
        .map_err(|e| e.to_string())?;
    let mut canvas = window
        .into_canvas() //
        .build()
        .map_err(|e| e.to_string())?;
    return Ok(());
}
