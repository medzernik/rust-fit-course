use std::net::SocketAddr;

use clap::Parser;
use hyper::{Request, Response, Uri, body::Incoming, server, service::service_fn};
use hyper_util::rt::TokioIo;
use tokio::net::TcpListener;

#[derive(Parser, Debug)]
#[command(version, about, long_about = Some("A simple reverse proxy."))]
struct Args {
    #[arg(short, long, env, help = "address of this proxy")]
    listener_addr: SocketAddr,

    #[arg(short, long, env, help = "address of the proxied server")]
    server_addr: Uri,
}

#[tokio::main]
async fn main() {
    let Args {
        listener_addr,
        server_addr,
    } = Args::parse();

    let listener = TcpListener::bind(listener_addr).await.unwrap();

    loop {
        let (stream, client_addr) = listener.accept().await.unwrap();
        println!("handling connection from: {client_addr}");

        let io = TokioIo::new(stream);

        let server_addr = server_addr.clone();
        tokio::task::spawn(async move {
            server::conn::http1::Builder::new()
                .serve_connection(
                    io,
                    service_fn(|req| handle_request(req, server_addr.clone())),
                )
                .await
                .unwrap();
        });
    }
}

async fn handle_request(
    request: Request<Incoming>,
    server_uri: Uri,
) -> Result<Response<Incoming>, std::io::Error> {
    // Implement this.
    //
    // You will need to create a hyper::Client for talking to the proxied server and pass its response back
    // in the form of a Response. You will also need to modify the http request before passing it on.
    //
    // You can use httpbin.org as your proxied server to test your proxy.
    //
    // Once you have that in place, implement caching (using e.g. a HashMap). This is kind of broad, so
    // feel free to ask questions or make assumptions (e.g. about cache eviction, TTL etc.).
    // Some info on HTTP caching: https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Caching.
    unimplemented!()
}
