use std::net::{SocketAddr, SocketAddrV4};

use clap::Parser;
use tokio::{io::AsyncReadExt, net::TcpListener};

#[derive(Parser, Debug)]
#[command(version, about, long_about = Some("A simple reverse proxy."))]
struct Args {
    #[arg(short, long, env, help = "address of this proxy")]
    listener_addr: SocketAddr,
}

#[tokio::main]
async fn main() {
    let Args { listener_addr } = Args::parse();
    let listener = TcpListener::bind(listener_addr).await.unwrap();
    let (mut stream, client_addr) = listener.accept().await.unwrap();
    println!("handling connection from: {client_addr}");

    let mut buf = [0u8; 1024];
    let bytes_read = stream.read(&mut buf).await.unwrap();

    let data = String::from_utf8(buf[0..bytes_read].to_vec()).unwrap();

    println!("{data}");
}
