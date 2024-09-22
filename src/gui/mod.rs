// #![allow(unused_variables)]

/// application configuration
/// low-level GUI subsystem
extern crate config;

extern crate sdl2;
use std::thread;
use std::time::Duration;

use sdl2::event::Event;
use sdl2::keyboard::Keycode;
use sdl2::Sdl;

mod theme;

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
    // SDL base active objects
    let sdl_context = sdl2::init()?;
    let video_subsystem = sdl_context.video()?;
    let width = config::gui::W as u32;
    let height = config::gui::H as u32;
    let window = video_subsystem //
        .window(&title, width, height)
        // .position_centered()
        .build()
        .map_err(|e| e.to_string())?;
    let mut canvas = window
        .into_canvas() //
        .build()
        .map_err(|e| e.to_string())?;

    // clean canvas
    canvas.set_draw_color(theme::background);

    // event loop
    let mut event_pump = sdl_context.event_pump()?;

    'eventloop: loop {
        for event in event_pump.poll_iter() {
            match event {
                Event::Quit { .. }
                | Event::KeyDown {
                    keycode: Some(Keycode::Escape),
                    ..
                } => break 'eventloop,
                _ => {}
            }
        }
        canvas.clear();
        canvas.present();
        thread::sleep(Duration::from_secs(1));
    }

    return Ok(());
}
