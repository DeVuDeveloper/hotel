self.addEventListener('push', function(event) {
  const notificationData = JSON.parse(event.data.text());

  const options = {
    body: notificationData.body,
    icon: notificationData.icon,
  };

  event.waitUntil(
    self.registration.showNotification(notificationData.title, options)
  );
});
