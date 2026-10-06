
// TODO: find the longest word in a sentence and return a reference to it. The function signature
// is incomplete. You must return some reference to a string.
fn find_longest() -> &str {}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn longest_01() {
        let string = "Hi! This is a test of the longest substring function.".to_string();

        let substring = find_longest(&string);
        assert_eq!(substring.len(), 9);
    }

    #[test]
    fn longest_02() {
        let string = "Hi! This is a test of the longest substring functions.".to_string();

        let substring = find_longest(&string);
        assert_eq!(substring.len(), 9);
    }
    
    #[test]
    fn longest_02() {
        let string = "Hi! This is a test of the longest substring functions.".to_string();

        let substring = find_longest(&string);
        assert_eq!(substring.len(), 9);
    }
}
