function sumOfTripledEvens(array) {
  return array
    .filter((num) => num % 2 == 0)
    .map((num) => num * 3)
    .reduce((prev, curr) => prev + curr);
}

console.log(sumOfTripledEvens([1, 2, 3, 4, 5, 6, 7, 8]));

function camelize(kebabCase) {
  return kebabCase
    .split("-")
    .map((word, index) => (index > 0 ? word.at(0).toUpperCase() + word.slice(1) : word))
    .join("");
}

console.log(camelize("background-color"));
console.log(camelize("list-style-image"));
console.log(camelize("-webkit-transition"));

{
  function filterRange(array, min, max) {
    return array.filter((value) => value >= min && value <= max);
  }

  let arr = [5, 3, 8, 1];
  let filtered = filterRange(arr, 1, 4);
  console.log(filtered); // 3,1 (matching values)
  console.log(arr); // 5,3,8,1 (not modified)
}

{
  function filterRangeInPlace(array, min, max) {
    for (let i = 0; i < array.length; i++) {
      if (array[i] < min || array[i] > max) {
        array.splice(i, 1);
        i--;
      }
    }
  }

  let arr = [5, 3, 8, 1];
  filterRangeInPlace(arr, 1, 4); // removed the numbers except from 1 to 4
  console.log(arr); // [3, 1]
}

{
  let arr = [5, 2, 1, -10, 8];
  arr.sort((a, b) => b - a);
  console.log(arr); // 8, 5, 2, 1, -10
}

{
  function copySorted(array) {
    return array.toSorted();
  }

  let arr = ["HTML", "JavaScript", "CSS"];
  let sorted = copySorted(arr);

  console.log(sorted); // CSS, HTML, JavaScript
  console.log(arr); // HTML, JavaScript, CSS (no changes)
}

{
  let john = { name: "John", age: 25 };
  let pete = { name: "Pete", age: 30 };
  let mary = { name: "Mary", age: 28 };

  let users = [john, pete, mary];

  let names = users.map((user) => user.name);

  console.log(names); // John, Pete, Mary
}

{
  let john = { name: "John", surname: "Smith", id: 1 };
  let pete = { name: "Pete", surname: "Hunt", id: 2 };
  let mary = { name: "Mary", surname: "Key", id: 3 };

  let users = [john, pete, mary];

  let usersMapped = users.map((user) => {
    return {
      fullName: `${user.name} ${user.surname}`,
      id: user.id,
    };
  });

  /*
  usersMapped = [
    { fullName: "John Smith", id: 1 },
    { fullName: "Pete Hunt", id: 2 },
    { fullName: "Mary Key", id: 3 }
  ]
  */

  console.table(usersMapped);
}

{
  function sortByAge(array) {
    array.sort((currUser, nextUser) => currUser.age - nextUser.age);
  }

  let john = { name: "John", age: 25 };
  let pete = { name: "Pete", age: 30 };
  let mary = { name: "Mary", age: 28 };

  let arr = [pete, john, mary];

  sortByAge(arr);

  // now: [john, mary, pete]
  console.table(arr);
}

{
  function shuffle(array) {
    array.sort(() => Math.random() - 0.5);
  }

  let arr = [1, 2, 3];

  for (let i = 0; i < 4; i++) {
    shuffle(arr);
    console.log(arr);
  }
}

{
  function getAverageAge(array) {
    return array.map((person) => person.age).reduce((total, current) => (total += current)) / array.length;
  }

  let john = { name: "John", age: 25 };
  let pete = { name: "Pete", age: 30 };
  let mary = { name: "Mary", age: 29 };

  let arr = [john, pete, mary];

  console.log(getAverageAge(arr)); // (25 + 30 + 29) / 3 = 28
}

{
  function unique(array) {
    const newArray = [];
    for (const value of array) {
      if (!newArray.includes(value)) {
        newArray.push(value);
      }
    }
    return newArray; 
  }

  let strings = ["Hare", "Krishna", "Hare", "Krishna", "Krishna", "Krishna", "Hare", "Hare", ":-O"];

  console.log(unique(strings)); // Hare, Krishna, :-O
}

{
  function groupById(array) {
    return array.reduce((accumulator, currentValue) => {
      accumulator[currentValue.id] = currentValue;
      return accumulator;
    }, {});
  }

  let users = [
    {id: 'john', name: "John Smith", age: 20},
    {id: 'ann', name: "Ann Smith", age: 24},
    {id: 'pete', name: "Pete Peterson", age: 31},
  ];

  let usersById = groupById(users);

  console.table(usersById);
  /*
  // after the call we should have:

  usersById = {
    john: {id: 'john', name: "John Smith", age: 20},
    ann: {id: 'ann', name: "Ann Smith", age: 24},
    pete: {id: 'pete', name: "Pete Peterson", age: 31},
  }
  */
}

{

}