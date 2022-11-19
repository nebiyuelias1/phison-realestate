import { debounce, fetchData, closeDialog } from "/static/js/utils.js";

const fetchCustomers = (url) => {
  fetchData(
    url,
    () => {
      const spinner = document.querySelector("#spinner");
      spinner.classList.remove("hidden");
    },
    (customers) => {
      const spinner = document.querySelector("#spinner");
      spinner.classList.add("hidden");
      const searchResult = document.querySelector("#searchResult");


      if (customers.length === 0) {
        searchResult.innerHTML =
          '<p class="text-sm text-gray-500 text-center mt-2">No result found!</p>';
        return;
      } else {
        let htmlContent = '';
          customers.forEach((c) => {
            htmlContent += `
              <div class="customer-card md:flex gap-2 mt-4 bg-white p-2 rounded-lg hover:bg-gray-100 cursor-pointer">
                <div class="mb-2 flex-shrink-0">
                  <img class="object-cover rounded-lg h-32 w-full" src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80" alt="Customer picture">
                </div>
                <div class="ml-2 break-all">
                  <p class="font-semibold">${c.name}</p>
                  <p class="text-sm text-gray-500 font-semibold">${c.phone_number}</p>
                  <p class="text-sm text-gray-500">${c.email}</p>
                </div>
              </div>
            `;
          });
          searchResult.innerHTML = htmlContent;
          const cards = document.getElementsByClassName("customer-card");
          Array.prototype.forEach.call(cards, (c, index) => {
            c.addEventListener("click", async () => {
              const customer = customers[index];
              document.querySelector("#selectCustomer").classList.add("hidden");
              document.querySelector("#selectedCustomerContainer").classList.remove("hidden");

              const customerCard = document.querySelector('#customerCard');
              customerCard.innerHTML = `
              <div class="gap-2 bg-white p-2 rounded-lg hover:bg-gray-100 cursor-pointer">
                <div class="mb-2 flex-shrink-0">
                  <img class="object-cover rounded-lg h-32 w-full" src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80" alt="Customer picture">
                </div>
                <div class="ml-2 break-all">
                  <p class="font-semibold">${customer.name}</p>
                  <p class="text-sm text-gray-500 font-semibold">${customer.phone_number}</p>
                  <p class="text-sm text-gray-500">${customer.email}</p>
                </div>
              </div>
              `;

              document.querySelector("#customerId").value = customer.id;

              closeDialog();
            });
          });
      }
    },
    () => {
      const spinner = document.querySelector("#spinner");
      spinner.classList.add("hidden");
      const searchResult = document.querySelector("#searchResult");
      searchResult.innerHTML =
        '<p class="text-sm text-red-500 text-center mt-2">Something went wrong!</p>';
    }
  );
};
export const initSelectCustomer = () => {
  const baseUrl = "/users/ajax/customers/";

  fetchCustomers(baseUrl);

  const searchField = document.querySelector("#id_search");
  searchField.addEventListener("keyup", (event) => {
    const searchKey = event.target.value;
    let url = baseUrl;
    if (searchKey) {
      url += `?q=${searchKey}`;
    }
    debounce(() => fetchCustomers(url))();
  });
};
