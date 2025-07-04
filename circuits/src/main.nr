fn main(votes: [Field; 5], weights: [Field; 5], public_total: pub Field) {
    let mut sum = 0.into();
    for i in 0..5 {
        sum += votes[i] * weights[i];
    }
    assert(sum == public_total);
}

 #[test]
    fn test_weighted_sum_pass1() {
        let votes = [1.into(), 2.into(), 3.into(), 4.into(), 5.into()];
        let weights = [1.into(), 1.into(), 1.into(), 1.into(), 1.into()];
        let public_total = 15.into();
        crate::main(votes, weights, public_total);
    }

    #[test]
    fn test_weighted_sum_pass2() {
        let votes = [2.into(), 2.into(), 2.into(), 2.into(), 2.into()];
        let weights = [3.into(), 1.into(), 0.into(), 1.into(), 0.into()];
        let public_total = 10.into();
        crate::main(votes, weights, public_total);
    }

     #[test(should_fail)]
    fn test_weighted_sum_fail() {
        let votes = [1.into(), 2.into(), 3.into(), 4.into(), 5.into()];
        let weights = [2.into(), 3.into(), 1.into(), 2.into(), 1.into()];
        let public_total = 20.into(); // incorrect sum
        crate::main(votes, weights, public_total); // This should fail
    }