import { renderDjangoTemplate } from "/static/js/utils.js";

const openImagePickerBtn = document.querySelector("#openImagePicker");
const propertyImagesContainer = document.querySelector("#propertyImages");
const hiddenFormControlContainer = document.querySelector('#propertyImageFormControls');
const csrfToken = document.querySelector("[name=csrfmiddlewaretoken]").value;
const totalFormInput = document.querySelector('#id_form-TOTAL_FORMS');
const totalPaymentInfoFormInput = document.querySelector('#id_payment_infos-TOTAL_FORMS');
const removeExistingImageBtns = document.querySelectorAll('#removePropertyImage');
const removeExistingPaymentInfoBtns = document.querySelectorAll('#removeExistingPaymentInfo');
const hiddenFormControls = document.querySelector("#hiddenFormControls");
const paymentForm = document.querySelector("#paymentForm");

let abortController;

const setHiddenFormControlValues = () => {
  const count = hiddenFormControlContainer.querySelectorAll('[type="text"]').length;
  totalFormInput.setAttribute('value', count);
}

const setPaymentInfoHiddenFormControlValues = () => {
  const count = hiddenFormControls.querySelectorAll('.payment-info-form-controls').length;
  totalPaymentInfoFormInput.value = count;
}

const removePropertyImage = (event) => {
  const parentContainer = event.target.closest('.image-container');
  const index = parentContainer.dataset.index;

  parentContainer.remove();
  if (abortController) {
    abortController.abort();
  }

  const hiddenInput = document.querySelector(`#id_form-${index}-image_id`);
  hiddenInput.remove();

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
    openImagePickerBtn.classList.remove("hidden");
  } else {
    openImagePickerBtn.classList.add("hidden");
  }
}



const onFileUploadCompleted = (childNode, jsonResponse) => {
  const imageTag = childNode.querySelector('#propertyImage');
  imageTag.classList.remove("blur-sm");

  const loadingSpinner = childNode.querySelector('#loadingSpinner');
  loadingSpinner.classList.add('hidden');
  maybeShowOpenImagePickerBtn();

  const count = hiddenFormControlContainer.querySelectorAll('[type="text"]').length;

  const hiddenInput = document.createElement('input');
  hiddenInput.setAttribute('type', 'text');
  hiddenInput.setAttribute('name', `form-${count}-image_id`);
  hiddenInput.setAttribute('hidden', true);
  hiddenInput.setAttribute('id', `id_form-${count}-image_id`);
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
    <td class="py-4 px-6">
      <button id="removePaymentInfo" class="flex items-center justify-center bg-white w-6 h-6 rounded-md">
        <svg width="11" height="11" viewBox="0 0 11 11" fill="none" xmlns="http://www.w3.org/2000/svg">
          <g clip-path="url(#clip0_114_11571)">
            <path
              d="M0.916748 2.74984H10.0834M4.58341 5.0415V7.33317M6.41675 5.0415V7.33317M1.83341 2.74984H9.16675L8.44258 9.26734C8.41776 9.49163 8.31107 9.69889 8.14295 9.84943C7.97482 9.99996 7.75708 10.0832 7.53141 10.0832H3.46875C3.24308 10.0832 3.02534 9.99996 2.85722 9.84943C2.68909 9.69889 2.5824 9.49163 2.55758 9.26734L1.83341 2.74984ZM3.36654 1.44221C3.44068 1.28499 3.55799 1.15209 3.70479 1.059C3.8516 0.965924 4.02184 0.916502 4.19566 0.916504H6.8045C6.9784 0.916415 7.14874 0.965796 7.29564 1.05888C7.44253 1.15197 7.55991 1.28492 7.63408 1.44221L8.25008 2.74984H2.75008L3.36654 1.44221V1.44221Z"
              stroke="#F04438" stroke-linecap="round" stroke-linejoin="round" />
          </g>
          <defs>
            <clipPath id="clip0_114_11571">
              <rect width="11" height="11" fill="white" />
            </clipPath>
          </defs>
        </svg>
      </button>
    </td>
  `;

  const index = document.querySelectorAll('.payment-info-form-controls').length;

  row.querySelector('#removePaymentInfo').addEventListener('click', (event) => {
    event.preventDefault();

    const nodes = document.querySelectorAll('.payment-info-form-controls');
    nodes[rowsCount].remove();

    row.remove();

    setPaymentInfoHiddenFormControlValues();
  });

  const newHiddenInput = document.createElement('div');
  newHiddenInput.classList.add('payment-info-form-controls');
  newHiddenInput.innerHTML = `
    <input type="text" name="payment_infos-${index}-title" maxlength="100" id="id_payment_infos-${index}-title" value="${paymentTitle}" hidden>
    <input type="text" name="payment_infos-${index}-time_period" maxlength="100" id="id_payment_infos-${index}-time_period" value="${paymentTimePeriod}" hidden>
    <input type="number" name="payment_infos-${index}-amount" step="0.01" id="id_payment_infos-${index}-amount" value="${paymentAmount}" hidden>
    <textarea name="payment_infos-${index}-description" cols="40" rows="10" id="id_payment_infos-${index}-description" hidden>${paymentDescription}</textarea>
  `;

  hiddenFormControls.append(newHiddenInput);

  paymentForm.reset();

  setPaymentInfoHiddenFormControlValues();
});

const imageInput = document.querySelector("#imageInput");
openImagePickerBtn.addEventListener("click", (_) => {
  imageInput.click();
});

imageInput.addEventListener("change", uploadImage);

removeExistingImageBtns.forEach((e) => e.addEventListener('click', (event) => {
  const parentContainer = event.target.closest('.image-container');
  const index = parentContainer.dataset.index;

  parentContainer.remove();

  document.querySelector(`#id_form-${index}-DELETE`).value = 'on';
  setHiddenFormControlValues();

  maybeShowOpenImagePickerBtn();
}));

removeExistingPaymentInfoBtns.forEach((e) => e.addEventListener('click', (event) => {
  event.preventDefault();

  const parentContainer = event.target.closest('tr');
  const index = parentContainer.dataset.index;

  parentContainer.remove();

  document.querySelector(`#id_payment_infos-${index}-DELETE`).value = 'on';

  setPaymentInfoHiddenFormControlValues();
}));
