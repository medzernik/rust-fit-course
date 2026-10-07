//! Implement calculator functions. The tests should pass, if you implement it correctly.
//! Each function should only take 2 numbers.
//! Below you can find a set of unit tests.
///! TODO: implement the solution here. Function names should match with the tests:

#[cfg(test)]
mod tests {
    use super::add;
    use super::divide;
    use super::log;
    use super::multiply;
    use super::powern;
    use super::sub;

    #[test]
    fn add_two_numbers() {
        assert_eq!(add(1, 2), 3);
    }

    #[test]
    fn sub_two_numbers() {
        assert_eq!(sub(1, 2), -1);
    }

    #[test]
    fn divide_two_numbers() {
        assert_eq!(divide(1, 2), 0.5);
    }

    #[test]
    fn divide_by_zero() {
        assert_eq!(divide(1, 0), f64::INFINITY);
    }

    #[test]
    fn multiply_two_numbers() {
        assert_eq!(multiply(10, 2), 20);
    }

    #[test]
    fn powern_two_numbers() {
        assert_eq!(powern(6, 7), 279_936);
    }
}
