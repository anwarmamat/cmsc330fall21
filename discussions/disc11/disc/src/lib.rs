/// Returns the sum of the even integers in the range [i, j).
/// `sum_evens(0, 6) == 6`. (0 + 2 + 4)
pub fn sum_evens(i: i32, j: i32) -> i32 {
    unimplemented!();
}

/// Returns the Euclidean distance between two 2-dimensional points.
/// The points are represented as 2-tuples of [f64]s.
/// `distance((0.0, 0.0), (1.0, 1.0) == 1.414...`
pub fn distance((ax, ay): (f64, f64), (bx, by): (f64, f64)) -> f64 {
    unimplemented!();
}

/// Returns the sum of the squared elements of arr.
/// `sum_squares(&[1, 2]) == 5 (1^2 + 2^2)`.
pub fn sum_squares(arr: &[i32]) -> i32 {
    unimplemented!();
}

/// Adds 1 to each element of the array. (Mutates the array.)
/// `let mut arr: [i32; 3] = [0, 1, 2];`
/// `raise_1(&mut arr);`
/// `arr == [1, 2, 3]`
pub fn raise_1(arr: &mut [i32]) {
    unimplemented!();
}

// CHALLENGE PROBLEM (UNGRADED)

/// Returns the max consecutive 1s in the array.
/// `consecutive_1s(&[1, 1, 1, 0, 1, 1]) == 3;`
/// `consecutive_1s(&[0, 1]) == 1;`
pub fn consecutive_1s(arr: &[i32]) -> i32 {
    unimplemented!();
}