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
    case "÷":
      return divide;
    case "×":
      return multiply;
    case "−":
      return subtract;
    case "+":
      return add;
  }
}

function tryOperate(operation, force = true) {
  let condition = operation.lhs !== null && operation.operator !== null;
  if (!force) {
    condition = condition && operation.rhs !== null;
  } else if (force && operation.rhs === null) {
    operation.rhs = operation.lhs;
  }

  if (condition) {
    if (operation.rhs === 0 && operation.operator === "÷") alert("Don't divide by zero!!");

    operation.lhs = Number(
      operate(Number(operation.lhs), Number(operation.rhs), operatorToFunction(operation.operator)).toFixed(10)
    );
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

buttonsContainer.querySelectorAll(".digitButton, .operatorButton").forEach((button) => {
  button.addEventListener("click", () => {
    if (button.classList.contains("digitButton")) {
      // Update operation.lhs or operation.rhs variable when user clicks on any of the digit buttons
      if (operation.operator === null) {
        if (operation.lhs === null) operation.lhs = "";
        if ((button.textContent === "." && !operation.lhs.includes(".")) || button.textContent !== ".")
          operation.lhs += button.textContent;
      } else {
        if (operation.rhs === null) operation.rhs = "";
        if ((button.textContent === "." && !operation.rhs.includes(".")) || button.textContent !== ".")
          operation.rhs += button.textContent;
      }
    } else if (button.classList.contains("operatorButton")) {
      // Try performing an operation if the user clicks on an operator button (only if we already have something like 1 + )
      if (operation.operator !== null) {
        const result = tryOperate(operation);
        if (result !== null) {
          displayContainer.textContent = result;
        }
      }

      operation.operator = button.textContent;
    }

    displayContainer.textContent = operationToString(operation);
  });
});

document.querySelector("#equalsButton").addEventListener("click", () => {
  // Forcefully perform an operation
  const result = tryOperate(operation, true);
  if (result !== null) {
    displayContainer.textContent = result;
  }
});

document.querySelector("#clearButton").addEventListener("click", () => {
  displayContainer.textContent = "";
  operation.lhs = null;
  operation.operator = null;
  operation.rhs = null;
});
