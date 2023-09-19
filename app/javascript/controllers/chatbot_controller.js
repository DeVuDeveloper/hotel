import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chatWindow", "chatContent", "messageInput"];

  connect() {
    this.hideChatWindow();
    this.displayWelcomeMessage();
  }

  toggleChat() {
    this.chatWindowTarget.classList.toggle("hidden");
  }

  hideChatWindow() {
    this.chatWindowTarget.classList.add("hidden");
  }

  sendMessage() {
    const userMessage = this.messageInputTarget.value.trim();

    if (userMessage !== "") {
      const chatContent = this.chatContentTarget;
      const userMessageElement = document.createElement("p");
      userMessageElement.innerHTML = `
        <span class="font-bold text-green-500">You:</span>
        <span class="ml-2 text-gray-600">${userMessage}</span>
      `;

      chatContent.appendChild(userMessageElement);
      chatContent.scrollTop = chatContent.scrollHeight;

      this.sendUserMessage(userMessage);
      this.messageInputTarget.value = "";
    }
  }

  sendUserMessage(userMessage) {
    fetch("/chatbot/receive_message", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
      },
      body: JSON.stringify({ message: userMessage }),
    })
      .then((response) => response.json())
      .then((data) => {
        const botMessageElement = `
      <p>
        <span class="font-bold text-blue-500"><i class="fas fa-robot"></i></span>
        <span class="ml-2 text-gray-600">${data.bot_response}</span>
      </p>
    `;

        this.addMessageToChat(botMessageElement);
      })
      .catch((error) => {
        console.error("Error sending message:", error);
      });
  }

  addMessageToChat(message) {
    const chatContent = this.chatContentTarget;
    chatContent.innerHTML += `<p>${message}</p>`;
    chatContent.scrollTop = chatContent.scrollHeight;
  }

  displayWelcomeMessage() {
    const userLoggedIn = true;
    const welcomeMessage = document.createElement("p");
    welcomeMessage.innerHTML = `
      <span class="font-bold text-blue-500"><i class="fas fa-robot"></i></span>
      <span class="ml-2 text-gray-600">Hello, how can I assist you?</span>
    `;
    this.chatContentTarget.appendChild(welcomeMessage);
    this.chatContentTarget.scrollTop = this.chatContentTarget.scrollHeight;
  }
}
