const GRID_SIZE_PIXELS = 960;

const createGridButton = document.querySelector("#createGridButton");
const container = document.querySelector("#container")

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

            div.addEventListener("mouseenter", () => {
                div.classList.add("colored-background");
            })

            container.append(div);
        }
    }
}

// Default grid
createGrid(16);