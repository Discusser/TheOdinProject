const ACCEPTED_VALUES = ["rock", "paper", "scissors"];

function getComputerChoice() {
  // Pick a random value from "rock", "paper", or "scissors"
  return ACCEPTED_VALUES[Math.floor(Math.random() * ACCEPTED_VALUES.length)];
}

function getHumanChoice() {
  // Get choice from user
  const choice = prompt("What do you choose to play? (rock, paper, scissors)").toLowerCase();

  // Ensure that it is valid, or else try again
  if (!ACCEPTED_VALUES.includes(choice)) {
    return getHumanChoice();
  } else {
    return choice;
  }
}

// Initialize both scores
let humanScore = 0;
let computerScore = 0;

// Play a single round, increment the winner's score and announce the winner
function playRound(humanChoice, computerChoice) {
  // Check all combinations where human loses
  if (
    (humanChoice == "rock" && computerChoice == "paper") ||
    (humanChoice == "paper" && computerChoice == "scissors") ||
    (humanChoice == "scissors" && computerChoice == "rock")
  ) {
    computerScore++;
    console.log("You lose! " + computerChoice + " beats " + humanChoice);
  }
  // Check all combinations where computer loses
  else if (
    (computerChoice == "rock" && humanChoice == "paper") ||
    (computerChoice == "paper" && humanChoice == "scissors") ||
    (computerChoice == "scissors" && humanChoice == "rock")
  ) {
    humanScore++;
    console.log("You win! " + humanChoice + " beats " + computerChoice);
  }
  // Check for a tie
  else if (computerChoice === humanChoice) {
    console.log("Tie! " + computerChoice);
  }
}

function playGame() {
  // Play 5 rounds
  for (let i = 0; i < 5; i++) {
    const humanSelection = getHumanChoice();
    const computerSelection = getComputerChoice();
    playRound(humanSelection, computerSelection);
  }

  if (computerScore > humanScore) {
    console.log("You lose! " + computerScore + "-" + humanScore);
  } else if (humanScore > computerScore) {
    console.log("You win! " + humanScore + "-" + computerScore);
  } else {
    console.log("It's a tie! " + humanScore + "-" + computerScore);
  }
}

playGame();
