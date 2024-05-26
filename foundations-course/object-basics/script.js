function sumOfTripledEvens(array) {
  return array
    .filter((num) => num % 2 == 0)
    .map((num) => num * 3)
    .reduce((prev, curr) => prev + curr);
}

console.log(sumOfTripledEvens([1, 2, 3, 4, 5, 6, 7, 8]));
