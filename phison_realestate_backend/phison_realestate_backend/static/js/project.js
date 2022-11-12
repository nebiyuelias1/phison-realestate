/* Project specific Javascript goes here. */
const closeModalButton = document.querySelector("#closeModal");
const modal = document.querySelector("#modal");

closeModalButton.addEventListener("click", () => {
  modal.close();
});

modal.addEventListener("click", (e) => {
  var rect = e.target.getBoundingClientRect();
  var minX = rect.left + e.target.clientLeft;
  var minY = rect.top + e.target.clientTop;
  if (
    e.clientX < minX ||
    e.clientX >= minX + e.target.clientWidth ||
    e.clientY < minY ||
    e.clientY >= minY + e.target.clientHeight
  ) {
    modal.close();
  }
});
