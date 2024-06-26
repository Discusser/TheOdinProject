const GRID_SIZE_PIXELS = 960;

const createGridButton = document.querySelector("#createGridButton");
const container = document.querySelector("#container");

// Handle grid creation
createGridButton.addEventListener("click", () => {
  // Prompt user for the number of squares on one line of the grid
  let squaresPerLine = 0;
  do {
    squaresPerLine = parseInt(prompt("How many squares do you want on one line? (max 100)"));
  } while (squaresPerLine > 100 || squaresPerLine < 0);

  createGrid(squaresPerLine);
});

function createGrid(squaresPerLine) {
  // Reset grid container
  container.replaceChildren();

  const size = GRID_SIZE_PIXELS / squaresPerLine;

  for (let i = 0; i < squaresPerLine; i++) {
    for (let j = 0; j < squaresPerLine; j++) {
      // Create child div and add appropriate styles
      const div = document.createElement("div");
      div.classList.add("container-child");

      div.style.width = `${size}px`;
      div.style.height = `${size}px`;

      div.addEventListener("mouseenter", () => handleDivMouseEnter(div));

      container.append(div);
    }
  }
}

function generateRGB() {
  function randomChannel() {
    return Math.random() * 255;
  }

  return {
    r: randomChannel(),
    g: randomChannel(),
    b: randomChannel(),
  };
}

function handleDivMouseEnter(div) {
  const color = generateRGB();

  let brightness = parseFloat(div.style.filter.split("(").at(-1));
  console.log(brightness);
  if (Number.isNaN(brightness) || brightness == undefined) {
    brightness = 100;
  }
  brightness = Math.max(0, brightness - 10);

  div.style.background = `rgb(${color.r} ${color.g} ${color.b})`;
  div.style.filter = `brightness(${brightness}%)`;
  console.log(div.style.background, div.style.opacity);
}

// Default grid
createGrid(16);
