import { renderDjangoTemplate } from "/static/js/utils.js";

const openImagePickerBtn = document.querySelector("#openImagePicker");
const propertyImagesContainer = document.querySelector("#propertyImages");
const hiddenFormControlContainer = document.querySelector('#propertyImageFormControls');
const csrfToken = document.querySelector("[name=csrfmiddlewaretoken]").value;
const totalFormInput = document.querySelector('#id_form-TOTAL_FORMS');
let abortController;

const setHiddenFormControlValues = () => {
  const count = hiddenFormControlContainer.childElementCount;
  totalFormInput.setAttribute('value', count);
  for (let index = 0; index < count; index++) {
    const child = hiddenFormControlContainer.children[index];
    child.setAttribute('name', `form-${index}-image_id`);
  }
}

const removePropertyImage = (event) => {
  const parentContainer = event.target.closest('.image-container');
  const index = Array.from(parentContainer.parentElement.children).indexOf(parentContainer);

  parentContainer.remove();
  if (abortController) {
    abortController.abort();
  }

  hiddenFormControlContainer.children[index].remove();
  setHiddenFormControlValues();
}

const onFileUploadStarted = async (file) => {
  openImagePickerBtn.classList.add("hidden");

  const imageUploadTemplate = await renderDjangoTemplate("_image_upload.html");
  const childNode = document.createElement('div');
  childNode.setAttribute('class', 'image-container');
  childNode.setAttribute('data-index', propertyImagesContainer.children.length);
  childNode.innerHTML = imageUploadTemplate;
  const imageTag = childNode.querySelector('#propertyImage');
  const url = URL.createObjectURL(file);
  imageTag.setAttribute('src', url);
  URL.revokeObjectURL(file);
  propertyImagesContainer.appendChild(childNode);
  const removePropertyImageBtn = childNode.querySelector('#removePropertyImage');
  removePropertyImageBtn.addEventListener('click', removePropertyImage);

  return childNode;
}

const maybeShowOpenImagePickerBtn = () => {
  if (propertyImagesContainer.childElementCount < 4) {
    openImagePickerBtn.classList.toggle("hidden");
  }
}



const onFileUploadCompleted = (childNode, jsonResponse) => {
  const imageTag = childNode.querySelector('#propertyImage');
  imageTag.classList.remove("blur-sm");

  const loadingSpinner = childNode.querySelector('#loadingSpinner');
  loadingSpinner.classList.add('hidden');
  maybeShowOpenImagePickerBtn();

  const hiddenInput = document.createElement('input');
  hiddenInput.setAttribute('hidden', true);
  hiddenInput.setAttribute('value', jsonResponse.id);
  hiddenFormControlContainer.appendChild(hiddenInput);
  setHiddenFormControlValues();
}

const onFileUploadFailed = (childNode) => {
  childNode.remove();
  maybeShowOpenImagePickerBtn();
}

const uploadImage = async (event) => {
  if (event.target.files.length === 0) {
    return;
  }

  const file = event.target.files[0];

  const childNode = await onFileUploadStarted(file);

  const formData = new FormData();
  formData.append("image", file);

  const request = new Request("/ajax/upload-property-image/", {
    method: "POST",
    headers: { "X-CSRFToken": csrfToken },
    mode: "same-origin",
    body: formData,
  });

  abortController = new AbortController();
  const signal = abortController.signal;
  const response = await fetch(request, {signal});
  if (response.status === 201) {
    const jsonResponse = await response.json();
    onFileUploadCompleted(childNode, jsonResponse);
  } else {
    onFileUploadFailed(childNode);
  }
};

const hiddenFormControls = document.querySelector("#hiddenFormControls");

const paymentForm = document.querySelector("#paymentForm");

paymentForm.addEventListener("submit", (event) => {
  event.preventDefault();

  const paymentTitle = document.querySelector("#payment_title").value;
  const paymentTimePeriod = document.querySelector(
    "#payment_time_period"
  ).value;
  const paymentAmount = document.querySelector("#payment_amount").value;
  const paymentDescription = document.querySelector(
    "#payment_description"
  ).value;

  const table = document.querySelector("#tableBody");

  const rowsCount = table.rows.length;
  const row = table.insertRow(rowsCount);
  row.classList.add("bg-white", "border-b");
  row.innerHTML = `
    <th scope="row" class="py-4 px-6 font-medium text-blue-600 whitespace-nowrap">
      ${paymentTitle}
    </th>
    <td class="py-4 px-6">
      ${paymentDescription}
    </td>
    <td class="py-4 px-6">
      ${paymentTimePeriod}
    </td>
    <td class="py-4 px-6">
      ${paymentAmount}
    </td>
  `;

  const totalFormsInput = document.querySelector(
    "#id_payment_infos-TOTAL_FORMS"
  );
  totalFormsInput.value = rowsCount + 1;

  hiddenFormControls.innerHTML =
    hiddenFormControls.innerHTML +
    `
    <input type="text" name="payment_infos-${rowsCount}-title" maxlength="100" id="id_payment_infos-${rowsCount}-title" value="${paymentTitle}" hidden>
    <input type="text" name="payment_infos-${rowsCount}-time_period" maxlength="100" id="id_payment_infos-${rowsCount}-time_period" value="${paymentTimePeriod}" hidden>
    <input type="number" name="payment_infos-${rowsCount}-amount" step="0.01" id="id_payment_infos-${rowsCount}-amount" value="${paymentAmount}" hidden>
    <textarea name="payment_infos-${rowsCount}-description" cols="40" rows="10" id="id_payment_infos-${rowsCount}-description" hidden>${paymentDescription}</textarea>
  `;

  paymentForm.reset();
});

const imageInput = document.querySelector("#imageInput");
openImagePickerBtn.addEventListener("click", (event) => {
  imageInput.click();
});

imageInput.addEventListener("change", uploadImage);
