const displayContainer = document.querySelector("#displayContainer");
const buttonsContainer = document.querySelector("#buttonsContainer");

const add = (a, b) => a + b;
const subtract = (a, b) => a - b;
const multiply = (a, b) => a * b;
const divide = (a, b) => a / b;

function operate(a, b, func) {
  return func(a, b);
}

const operation = {
  lhs: null,
  operator: null,
  rhs: null,
};

function operatorToFunction(string) {
  switch (string) {
    case "/":
    case "÷":
      return divide;
    case "*":
    case "×":
      return multiply;
    case "-":
    case "−":
      return subtract;
    case "+":
      return add;
  }
}

function tryOperate(operation, force = true) {
  let condition = operation.lhs !== null && operation.operator !== null && operation.rhs !== null;

  // if (!force) {
  //   condition = condition && operation.rhs !== null;
  // }

  if (condition) {
    // if (force && operation.rhs === null) {
    //   operation.rhs = operation.lhs;
    // }

    operation.lhs = Number(
      operate(Number(operation.lhs), Number(operation.rhs), operatorToFunction(operation.operator)).toFixed(10)
    );

    if (operation.rhs == 0 && operation.operator === "÷") {
      alert("Don't divide by zero!!");
      operation.lhs = NaN;
    }

    operation.operator = null;
    operation.rhs = null;

    return operation.lhs;
  }

  return null;
}

function operationToString(operation) {
  let string = "";
  if (operation.lhs !== null) string += operation.lhs;
  if (operation.operator !== null) string += " " + operation.operator;
  if (operation.rhs !== null) string += " " + operation.rhs;
  return string;
}

function onDigitClick(digit) {
  // Update operation.lhs or operation.rhs variable when user clicks on any of the digit buttons
  if (operation.operator === null) {
    if (operation.lhs === null) operation.lhs = "";
    if ((digit === "." && !operation.lhs.includes(".")) || digit !== ".") operation.lhs += digit;
  } else {
    if (operation.rhs === null) operation.rhs = "";
    if ((digit === "." && !operation.rhs.includes(".")) || digit !== ".") operation.rhs += digit;
  }

  displayContainer.textContent = operationToString(operation);
}

function onOperatorClick(operator) {
  // Try performing an operation if the user clicks on an operator button (only if we already have something like 1 + )
  if (operation.operator !== null) {
    const result = tryOperate(operation);
    if (result !== null) {
      displayContainer.textContent = result;
    }
  }

  operation.operator = operator;
  displayContainer.textContent = operationToString(operation);
}

function onEqualsClick() {
  // Forcefully perform an operation
  const result = tryOperate(operation, true);
  if (result !== null) {
    displayContainer.textContent = result;
  }
}

buttonsContainer.querySelectorAll(".digitButton, .operatorButton").forEach((button) => {
  button.addEventListener("click", () => {
    if (button.classList.contains("digitButton")) {
      onDigitClick(button.textContent);
    } else if (button.classList.contains("operatorButton")) {
      onOperatorClick(button.textContent);
    }
  });
});

document.querySelector("#equalsButton").addEventListener("click", () => {
  onEqualsClick();
});

document.querySelector("#clearButton").addEventListener("click", () => {
  displayContainer.textContent = "";
  operation.lhs = null;
  operation.operator = null;
  operation.rhs = null;
});

document.addEventListener("keydown", (event) => {
  if ("1234567890.".includes(event.key)) {
    onDigitClick(event.key);
  } else if ("/*-+".includes(event.key)) {
    onOperatorClick(event.key);
  } else if (event.key === "Enter") {
    onEqualsClick();
  }
});
