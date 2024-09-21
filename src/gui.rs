/// low-level GUI subsystem

pub fn init() {
    log::info!(std::stringify!(init));
}

#[test]
fn gui() {
    assert!(config::gui::W >= config::gui::QVGA.1);
}
