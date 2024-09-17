#![allow(dead_code)]
#![allow(non_upper_case_globals)]
#![allow(unused_imports)]

const server: &str = config::server::url;
const body: &str = include_str!("../static/index.html");
const js: &str = include_str!("../static/js.js");
const logo: &[u8] = include_bytes!("../../img/logo/64x64.png");
const manifest: &str = include_str!("../static/manifest");
fn manifest_mime() -> Mime {
    "application/manifest+json".parse::<Mime>().unwrap()
}
const jquery: &str = include_str!("../static/cdn/jquery.min.js");

extern crate iron;
use iron::prelude::*;
use iron::status;

#[macro_use]
extern crate mime;
use mime::Mime;

extern crate router;
use router::Router;

fn main() {
    eprintln!("server @ http://{server}");
    let mut router = Router::new();
    router.get("/", get_index, "root");
    router.get("/favicon.ico", get_logo, "ico");
    router.get("/logo.png", get_logo, "png");
    router.get("/manifest", get_manifest, "manifest");
    router.get("/js.js", get_js, "js");
    router.get("/jquery.min.js", get_jquery, "jquery");
    Iron::new(router).http(server).unwrap();
}

fn get_index(_request: &mut Request) -> IronResult<Response> {
    let mut response = Response::new();
    response.set_mut(status::Ok);
    response.set_mut(mime!(Text/Html;Charset=Utf8));
    response.set_mut(body);
    Ok(response)
}

fn get_logo(_request: &mut Request) -> IronResult<Response> {
    let mut response = Response::new();
    response.set_mut(status::Ok);
    response.set_mut(mime!(Image / Png));
    response.set_mut(logo);
    Ok(response)
}

fn get_manifest(_request: &mut Request) -> IronResult<Response> {
    let mut response = Response::new();
    response.set_mut(status::Ok);
    response.set_mut(manifest_mime());
    response.set_mut(manifest);
    Ok(response)
}

fn get_jquery(_request: &mut Request) -> IronResult<Response> {
    let mut response = Response::new();
    response.set_mut(status::Ok);
    response.set_mut(mime!(Text / Javascript));
    response.set_mut(jquery);
    Ok(response)
}

fn get_js(_request: &mut Request) -> IronResult<Response> {
    let mut response = Response::new();
    response.set_mut(status::Ok);
    response.set_mut(mime!(Text / Javascript));
    response.set_mut(js);
    Ok(response)
}
