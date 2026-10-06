use serde::Serialize;

// TODO: Define this struct so that it serializes into a JSON value defined in the tests.
#[derive(Serialize)]
struct StudentData {}


#[cfg(test)]
mod tests {
    use serde_json::json;
    use super::*;

    #[test]
    fn serialize_this() {
        let student = StudentData {};
        let serialized = serde_json::to_value(student).unwrap();

        assert_eq!(serialized, json!({
            "name": "Asterix",
            "age": 23,
            "enrolled": true,
            "faculty": "FIT",
            "courses": [
                "Rust",
                "Zig",
                "Why Algorithms Are Not Just Theory",
                "Are Algorithms Actually Useful?",
            ],
            "address": {
                "street": "Pocernicka",
                "number": 42,
                "city": "Prague",
                "dorm": false
            },
            "phone": "754423096"
        }))
    }

    #[test]
    fn serialize_that() {
        let structure = StudentData {};
        let student = serde_json::to_value(structure).unwrap();

        assert_eq!(student, json!({
            "name": "Obelix",
            "age": 22,
            "enrolled": false,
            "faculty": "FSV",
            "courses": [
                "Rusty Bridges",
                "Roads",
                "Concrete Problems",
            ],
            "address": {
                "street": "Vanickova",
                "number": 7,
                "city": "Prague",
                "dorm": true
            }
        }))
    }
}
