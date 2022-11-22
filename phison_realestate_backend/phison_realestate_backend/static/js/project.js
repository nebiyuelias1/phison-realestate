/* Project specific Javascript goes here. */
const closeModalButton = document.querySelector("#closeModal");
const modal = document.querySelector("#modal");

closeModalButton.addEventListener("click", () => {
  modal.close();
});

// TODO: Find a better way of closing the modal dialog when the outside area is clicked.

const menuButton = document.querySelector('#menuButton');
const closeMenuButton = document.querySelector('#closeMenuButton');
const sideBar = document.querySelector('#sideBar');

menuButton.addEventListener('click', () => {
  sideBar.classList.remove('hidden');
  sideBar.classList.add('p-4', 'flex', 'flex-col');
});

closeMenuButton.addEventListener('click', () => {
  sideBar.classList.add('hidden');
  sideBar.classList.remove('p-4');
});
