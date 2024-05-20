const container = document.querySelector("#container");

{
  const paragraph = document.createElement("p");
  paragraph.style.color = "red";
  paragraph.textContent = "Hey I'm red!";
  const header = document.createElement("h3");
  header.style.color = "blue";
  header.textContent = "I'm a blue h3!";

  container.append(paragraph, header);
}

{
  const box = document.createElement("div");
  box.style.border = "4px solid black";
  box.style.backgroundColor = "pink";

  const header = document.createElement("h1");
  header.textContent = "I'm in a div";
  const paragraph = document.createElement("p");
  paragraph.textContent = "ME TOO!";

  box.append(header, paragraph);
  container.append(box);
}

function alertFunction() {
  alert("You did it!");
}

{
  const btn = document.querySelector("#btn");
  // btn.onclick = () => alert("Hello World");
  btn.addEventListener("click", (e) => {
    e.target.style.background = "blue";
  });
}

{
  const btn = document.querySelector("#btn1");
  // btn.onclick = alertFunction;
  btn.addEventListener("click", alertFunction);
}

{
  const buttons = document.querySelectorAll("#container button");
  buttons.forEach((button) => {
    button.addEventListener("click", () => {
      alert(button.id);
    });
  });
}
