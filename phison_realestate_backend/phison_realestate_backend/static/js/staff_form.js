export const onSubmit = (event) => {
    event.preventDefault();

    const data = new FormData(event.target);

    const value = Object.fromEntries(data.entries());


}
