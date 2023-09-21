document.addEventListener("turbo:load", () => {
  const messageInputField = document.getElementById("messageInputField");
  const sendButton = document.querySelector(
    '[data-action="click->chatbot#sendMessage"]'
  );

  messageInputField.addEventListener("keydown", (event) => {
    if (event.keyCode === 13) {
      event.preventDefault();
      sendButton.click();
    }
  });
});
