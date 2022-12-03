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

window.addEventListener('DOMContentLoaded', () => {
  const dropdownToggle = document.querySelector('[data-dropdown-toggle]');
  dropdownToggle.addEventListener("click", (_) => {
    const dropdown = document.querySelector(`#${dropdownToggle.dataset.dropdownToggle}`);
    dropdown.classList.toggle("hidden");
  });

  dropdownToggle.addEventListener("blur", (_) => {
    const dropdown = document.querySelector(`#${dropdownToggle.dataset.dropdownToggle}`);
    setTimeout(() => dropdown.classList.toggle("hidden"), 200);
  });
});
