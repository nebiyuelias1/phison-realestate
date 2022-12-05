import { showDialog, renderDjangoTemplate } from "/static/js/utils.js";
import { initSelectProperty } from "/static/js/select_property.js";
import { initSelectCustomer } from "/static/js/select_customer.js";

const table = document.querySelector("#tableBody");
const hiddenFormControls = document.querySelector("#hiddenFormControls");
const selectedPropertyContainer = document.querySelector(
  "#selectedPropertyContainer"
);
const selectProperty = document.querySelector("#selectProperty");
const selectCustomer = document.querySelector("#selectCustomer");
const removePropertySelectionBtn = document.querySelector(
  "#removePropertySelection"
);
const selectedCustomerContainer = document.querySelector(
  "#selectedCustomerContainer"
);
const removeCustomerSelectionBtn = document.querySelector(
  "#removeCustomerSelection"
);
const paymentForm = document.querySelector("#paymentForm");
const totalFormsInput = document.querySelector("#id_schedules-TOTAL_FORMS");


selectProperty?.addEventListener("click", async () => {
  const template = await renderDjangoTemplate("_select_property.html");
  await showDialog("Select Property", template);
  initSelectProperty();
});

selectCustomer?.addEventListener("click", async () => {
  const template = await renderDjangoTemplate("_select_customer.html");
  await showDialog("Select Customer", template);
  initSelectCustomer();
});


removePropertySelectionBtn?.addEventListener("click", () => {
  selectProperty.classList.remove("hidden");
  selectedPropertyContainer.classList.add("hidden");
  document.querySelector("#propertyId").value = "";
});


removeCustomerSelectionBtn?.addEventListener("click", () => {
  selectCustomer.classList.remove("hidden");
  selectedCustomerContainer.classList.add("hidden");
  document.querySelector("#customerId").value = "";
});

const setPaymentScheduleHiddenFormControlValues = () => {
    const count = hiddenFormControls.querySelectorAll('.payment-schedule-form-controls').length;
    totalFormsInput.value = count;
}

paymentForm.addEventListener("submit", (event) => {
  event.preventDefault();

  const paymentTitle = document.querySelector("#payment_title").value;
  const paymentDeadline = document.querySelector("#payment_deadline").value;
  const paymentAmount = document.querySelector("#payment_amount").value;
  const paymentDescription = document.querySelector(
    "#payment_description"
  ).value;


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
          ${paymentDeadline}
        </td>
        <td class="py-4 px-6">
          ${paymentAmount}
        </td>
        <td class="py-4 px-6">
            <button id="removePaymentSchedule" class="flex items-center justify-center bg-white w-6 h-6 rounded-md">
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


    row.querySelector('#removePaymentSchedule').addEventListener('click', (event) => {
        event.preventDefault();

        const nodes = document.querySelectorAll('.payment-schedule-form-controls');
        nodes[rowsCount].remove();

        row.remove();

        setPaymentScheduleHiddenFormControlValues();
    });

    const newHiddenInput = document.createElement('div');
    newHiddenInput.classList.add('payment-schedule-form-controls');

    const index = document.querySelectorAll('.payment-schedule-form-controls').length;

    newHiddenInput.innerHTML = `
            <input type="text" name="schedules-${index}-title" maxlength="100" id="id_schedules-${index}-title" value="${paymentTitle}" hidden>
            <input type="date" name="schedules-${index}-deadline" maxlength="100" id="id_schedules-${index}-deadline" value="${paymentDeadline}" hidden>
            <input type="number" name="schedules-${index}-percentage" step="0.01" id="id_schedules-${index}-percentage" value="${paymentAmount}" hidden>
            <textarea name="schedules-${index}-description" cols="40" rows="10" id="id_schedules-${index}-description" hidden>${paymentDescription}</textarea>
        `;

    hiddenFormControls.append(newHiddenInput);

    setPaymentScheduleHiddenFormControlValues();

    paymentForm.reset();
});

document.querySelectorAll("#removeExistingPaymentSchedule").forEach((e) =>
  e.addEventListener("click", (event) => {
    event.preventDefault();

    const parentContainer = event.target.closest("tr");
    const index = parentContainer.dataset.index;

    parentContainer.remove();

    document.querySelector(`#id_schedules-${index}-DELETE`).value = "on";
  })
);
