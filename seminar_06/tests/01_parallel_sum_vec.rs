use std::sync::Arc;

/// TODO (1p): Implement the following function, which should add all numbers in the `items` vec
/// in parallel, using `threads` threads.
///
/// Make sure that your implementation is actually parallel and is faster for large inputs than
/// if it was executed on a single thread (assuming a reasonable thread count w.r.t. your hardware).
///
/// You should not allocate any additional memory that scales with the **length of the slice**.
/// In other words, the space complexity of this function should be O(1) w.r.t. the slice length.
/// You can allocate memory that scales with the number `threads`.
///
/// **DO NOT** use Rayon or any other crate, implement the distribution manually using only libstd.
fn parallel_sum_vec(items: Vec<u64>, threads: usize) -> u64 {
    todo!()
}

/// Below you can find a set of unit tests.
#[cfg(test)]
mod tests {
    use crate::parallel_sum_vec;
    use std::time::Instant;

    #[test]
    fn empty() {
        assert_eq!(parallel_sum_vec(vec![], 1), 0);
        assert_eq!(parallel_sum_vec(vec![], 100), 0);
    }

    #[test]
    fn single_item_single_thread() {
        assert_eq!(parallel_sum_vec(vec![5], 1), 5);
    }

    #[test]
    fn more_threads_than_items() {
        assert_eq!(parallel_sum_vec(vec![1, 2, 3], 8), 6);
    }

    #[test]
    fn uneven_count() {
        assert_eq!(parallel_sum_vec(vec![42, 86, 31, 12, 8, 4, 3], 4), 186);
    }

    #[test]
    fn large_slice() {
        assert_eq!(parallel_sum_vec(vec![42; 1024], 3), 43008);
    }

    #[test]
    fn complex() {
        let items: Vec<_> = (0..400000u64).map(|i| i * i).collect();
        let reference = 21333253333400000;

        for thread_count in 1..48 {
            assert_eq!(parallel_sum_vec(items.clone(), thread_count), reference);
        }
    }

    // Hope you have at least two physical threads/cores :)
    #[test]
    fn check_time() {
        let items: Vec<_> = (0..10000000u64)
            .map(|i| if i % 2 == 0 { i + 1 } else { i - 1 })
            .collect();
        let reference = 49999995000000;
        let items2 = items.clone();

        let start = Instant::now();
        assert_eq!(parallel_sum_vec(items, 1), reference);
        let duration_1t = start.elapsed().as_secs_f64();

        let start = Instant::now();
        assert_eq!(parallel_sum_vec(items2, 2), reference);
        let duration_2t = start.elapsed().as_secs_f64();

        assert!(duration_2t < duration_1t * 0.75);
    }
}
