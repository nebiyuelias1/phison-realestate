import { closeDialog } from "../../static/js/utils.js";

export const onSubmit = async (event) => {
    event.preventDefault();

    const data = new FormData(event.target);

    const value = Object.fromEntries(data.entries());

    const request = new Request(
        '/users/add/',
        {
            method: 'POST',
            headers: {'X-CSRFToken': value.csrfmiddlewaretoken},
            mode: 'same-origin',
            body: data
        }
    );
    const response = await fetch(request);

    if (response.status === 201) {
        closeDialog();
    } else {
        const text = await response.text();
        const errorMessageContainer = document.querySelector('#errorMessage');
        errorMessageContainer.innerHTML = text;
    }
}
