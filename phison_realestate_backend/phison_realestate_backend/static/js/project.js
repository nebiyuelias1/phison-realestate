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

const toggleDropdown = (dropDown) => {
  const contains = dropDown.classList.contains('hidden');
  if (contains) {
    dropDown.classList.remove("hidden");
  } else {
    dropDown.classList.add('hidden');
  }
}

window.addEventListener('DOMContentLoaded', () => {
  const dropdownToggles = document.querySelectorAll('[data-dropdown-toggle]');
  dropdownToggles.forEach((e) => e.addEventListener('click', (event) => {
    const button = event.target.closest('[data-dropdown-toggle]');
    const dropDown = button.parentElement.querySelector(`#${button.dataset.dropdownToggle}`);
    toggleDropdown(dropDown);
  }));

  dropdownToggles.forEach((e) => e.addEventListener('blur', (event) => {
      const button = event.target.closest('[data-dropdown-toggle]');
      const dropDown = button.parentElement.querySelector(`#${button.dataset.dropdownToggle}`);
      setTimeout(() => toggleDropdown(dropDown), 200);
  }));
});
