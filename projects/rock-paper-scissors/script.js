const ACCEPTED_VALUES = ["rock", "paper", "scissors"];

const roundOutcome = document.querySelector("#roundOutcome");
const humanScoreSpan = document.querySelector("#humanScore");
const computerScoreSpan = document.querySelector("#computerScore");
const winnerMessage = document.querySelector("#winnerMessage");

function getComputerChoice() {
  // Pick a random value from "rock", "paper", or "scissors"
  return ACCEPTED_VALUES[Math.floor(Math.random() * ACCEPTED_VALUES.length)];
}

// Initialize both scores and state variables
let humanScore = 0;
let computerScore = 0;
let gameOver = false;

// Play a single round, increment the winner's score and announce the winner
function playRound(humanChoice, computerChoice) {
  if (gameOver) {
    roundOutcome.textContent = "The game has ended. Stop clicking these buttons, or refresh the page to play again.";
    return;
  }

  // Check all combinations where human loses
  if (
    (humanChoice == "rock" && computerChoice == "paper") ||
    (humanChoice == "paper" && computerChoice == "scissors") ||
    (humanChoice == "scissors" && computerChoice == "rock")
  ) {
    computerScore++;
    computerScoreSpan.textContent = computerScore;
    roundOutcome.textContent = `You lose! You played ${humanChoice} against ${computerChoice}`;
  }
  // Check all combinations where computer loses
  else if (
    (computerChoice == "rock" && humanChoice == "paper") ||
    (computerChoice == "paper" && humanChoice == "scissors") ||
    (computerChoice == "scissors" && humanChoice == "rock")
  ) {
    humanScore++;
    humanScoreSpan.textContent = humanScore;
    roundOutcome.textContent = `You win! You played ${humanChoice} against ${computerChoice}`;
  }
  // Check for a tie
  else if (computerChoice === humanChoice) {
    roundOutcome.textContent = `It's a tie! You played ${humanChoice} against ${computerChoice}`;
  }

  // Announce winner after one of the players reaches 5 points
  if (humanScore >= 5 && computerScore < 5) {
    winnerMessage.textContent = "You win the game!";
    gameOver = true;
  } else if (computerScore >= 5 && humanScore < 5) {
    winnerMessage.textContent = "You lose the game!";
    gameOver = true;
  } else if (computerScore >= 5 && humanScore >= 5) {
    winnerMessage.textContent = "Both you and the computer have atleast 5 points. How is this possible?";
    gameOver = true;
  }
}

document.querySelectorAll(".selection-button").forEach((button) => {
  button.addEventListener("click", () => {
    playRound(button.id, getComputerChoice());
  });
});