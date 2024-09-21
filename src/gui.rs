/// low-level GUI subsystem

pub fn init() {
    log::info!(std::stringify!(init));
}

#[test]
fn gui() {
    assert_eq!(config::gui::W, 480);
}
