document.addEventListener("turbo:load", () => {
  const messageInputField = document.getElementById("messageInputField");
  const sendButton = document.querySelector(
    '[data-action="click->chatbot#sendMessage"]'
  );

  if (messageInputField) {
    messageInputField.addEventListener("keydown", (event) => {
      if (event.keyCode === 13) {
        event.preventDefault();
        sendButton.click();
      }
    });
  }
});
