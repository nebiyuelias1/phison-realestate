let timer;

export const debounce = (func, timeout = 500) => {
  return (...args) => {
    clearTimeout(timer);
    timer = setTimeout(() => {
      func.apply(this, args);
    }, timeout);
  };
};

export const renderDjangoTemplate = async (templateName) => {
  const result = await fetch(`/render_partial/${templateName}/`);

  return await result.text();
}

const modal = document.querySelector('#modal');

export const showDialog = async (title, template) => {
  const modalTitle = document.querySelector('#modalTitle');
  modalTitle.textContent = title;

  const modalBody = document.querySelector('#modalBody');
  modalBody.innerHTML = template;

  modal.showModal();
}

export const closeDialog = () => {
  modal.close();
}
