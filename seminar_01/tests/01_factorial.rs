//! Run this file with:
//! ```shell
//! cargo test --test 01_factorial`
//! ```
//! or ideally by using the IDE configuration (if using Zed or JetBrains RustRover).
//!

// TODO: Implement a simple factorial function.

/// Below you can find a set of unit tests.
#[cfg(test)]
mod tests {
    use super::factorial;

    #[test]
    fn factorial_0() {
        assert_eq!(factorial(0), 1);
    }

    #[test]
    fn factorial_1() {
        assert_eq!(factorial(1), 1);
    }

    #[test]
    fn factorial_2() {
        assert_eq!(factorial(2), 2);
    }

    #[test]
    fn factorial_5() {
        assert_eq!(factorial(5), 120);
    }
}
