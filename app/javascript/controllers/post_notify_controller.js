import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer";

// Connects to data-controller="room"
export default class extends Controller {
  connect() {
    console.log("Hello, Notify Stimulus!");
    this.sub = this.createActionCableChannel();
    console.log(this.sub);
  }

  createActionCableChannel() {
    return consumer.subscriptions.create(
      { channel: "PostNotifyChannel" },
      {
        connected() {
          // Called when the subscription is ready for use on the server
          //this.perform("get_user_data");
         
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
        },

        received(data) {
          // Called when there's incoming data on the websocket for this channel
          //console.log(data.user.email);
          this.displayNotification(data);
         
        },
        displayNotification(data) {
          if (!("Notification" in window)) {
            console.warn("This browser does not support desktop notification");
          } else if (Notification.permission === "granted") {
            console.log("notification granted");
            var notification = new Notification(data.title, { body: data.body });
          } else if (Notification.permission !== "denied") {
            console.log("notification permissions need to be requested");
          } else {
            console.warn("notification denied");
          }
        },
      }
    );
  }
}

