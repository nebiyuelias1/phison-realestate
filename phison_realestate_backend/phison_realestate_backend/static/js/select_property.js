import { debounce, closeDialog, renderDjangoTemplate } from "../../static/js/utils.js";

const fetchData = async (searchKey) => {
  const spinner = document.querySelector("#spinner");
  const searchResult = document.querySelector("#searchResult");

  spinner.classList.remove("hidden");

  let url = "/ajax/properties/";

  if (searchKey) {
    url += `?q=${searchKey}`;
  }

  const response = await fetch(url);

  if (response.ok) {
    spinner.classList.add("hidden");
    const data = await response.json();
    const propertyList = JSON.parse(data);
    let htmlContent = "";

    if (propertyList.length === 0) {
      searchResult.innerHTML =
        '<p class="text-sm text-gray-500 text-center mt-2">No result found!</p>';
      return;
    }

    propertyList.forEach((d) => {
      htmlContent += `
          <div class="property-card md:flex gap-2 mt-4 bg-white p-2 rounded-lg hover:bg-gray-100 cursor-pointer">
            <div class="relative basis-1/3 md:mr-4">
              <img class="object-cover rounded-2xl h-32 md:h-full w-full"
                src="https://cdn.pixabay.com/photo/2015/10/20/18/57/furniture-998265_960_720.jpg" alt="Property image">
              <span
                class="absolute left-2 bottom-2 text-xs backdrop-blur-lg text-white p-2 rounded-lg bg-orange-900">Villa</span>
            </div>
            <div class="mt-2 md:mt-0 flex flex-col flex-grow">
              <p class="font-bold text-sm">${d.name}</p>
              <p class="text-xs text-gray-500">Addis Ababa, Bole Beshale</p>

              <div class="mt-6 flex flex-wrap justify-between">
                <div class="flex flex-col md:basis:1/3 flex-grow md:flex-grow-0">
                  <div class="flex">
                    <img class="mr-2 w-6 h-6" src="/static/images/bedroom.svg" alt="bedroom icon">
                    <span class="text-xs font-semibold mr-1">${d.bed_room_count}</span>
                  </div>
                  <p class="text-xs text-gray-500">Bedrooms</p>
                </div>

                <div class="flex flex-col items-center md:basis:1/3 flex-grow md:flex-grow-0">
                  <div class="flex">
                    <img class="mr-2 w-6 h-6" src="/static/images/bathroom.svg" alt="bathroom icon">
                    <span class="text-xs font-semibold mr-1">${d.bath_room_count}</span>
                  </div>
                  <p class="text-xs text-gray-500">Bathrooms</p>
                </div>

                <div class="flex flex-col items-end md:basis:1/3 flex-grow md:flex-grow-0">
                  <div class="flex">
                    <img class="mr-2 w-5 h-5" src="/static/images/area.svg" alt="bathroom icon">
                    <span class="ml-1 text-xs font-semibold mr-1">${d.parking_count}</span>
                  </div>
                  <p class="text-xs text-gray-500">Parking</p>
                </div>
              </div>
            </div>
          </div>
        `;
    });

    searchResult.innerHTML = htmlContent;

    const propertyCard = document.querySelector('#propertyCard');
    const cards = document.getElementsByClassName("property-card");
    Array.prototype.forEach.call(cards, (c, index) => {
      c.addEventListener("click", async () => {
        const property = propertyList[index];
        document.querySelector("#selectProperty").classList.add("hidden");
        document.querySelector("#selectedPropertyContainer").classList.remove("hidden");

        propertyCard.innerHTML = await renderDjangoTemplate('_property_card.html');
        document.querySelector('#propertyCardName').textContent = property.name;
        document.querySelector('#propertyCardBedRoomCount').textContent = property.bed_room_count;
        document.querySelector('#propertyCardBathRoomCount').textContent = property.bath_room_count;
        document.querySelector('#propertyCardParkingCount').textContent = property.parking_count;

        document.querySelector("#propertyId").value = property.id;

        closeDialog();
      });
    });
  } else {
    searchResult.innerHTML =
      '<p class="text-sm text-red text-center mt-2">Something went wrong!</p>';
    return;
  }
};

export const initSelectProperty = async () => {
  await fetchData();

  const searchField = document.querySelector("#id_search");
  searchField.addEventListener("keyup", (event) => {
    const searchKey = event.target.value;
    debounce(() => fetchData(searchKey))();
  });
};
