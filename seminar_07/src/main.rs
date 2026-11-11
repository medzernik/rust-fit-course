fn main() {
    let greeting:  = "GREETINGS IN PASSIVE AGGRESIVE CAPS!!!".to_string();

    std::thread::spawn(|| println!("{greeting}"))
        .join()
        .unwrap();
    println!("{greeting}");
}
