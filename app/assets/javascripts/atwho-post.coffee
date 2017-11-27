jQuery ->
  $('[data-behavior="autocomplete"]').atwho({
    at: "@",
    data: "/users.json",
    insertTpl: '${username}',
    displayTpl: '<li data-id="${id}"><span>${username}</span></li>',
    limit: 15,
  });