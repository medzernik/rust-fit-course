use std::net::SocketAddr;

use clap::Parser;
use hyper::Uri;
use seminar_proxy::run_proxy;

#[derive(Parser, Debug)]
#[command(version, about, long_about = Some("A simple reverse proxy."))]
struct Args {
    #[arg(short, long, env, help = "address of this proxy")]
    listener_addr: SocketAddr,

    #[arg(short, long, env, help = "uri of the proxied server")]
    server_uri: Uri,
}

#[tokio::main]
async fn main() {
    let Args {
        listener_addr,
        server_uri,
    } = Args::parse();

    run_proxy(listener_addr, server_uri).await;
}
