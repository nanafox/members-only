import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "checkbox"];

  connect() {
    // clear the checkbox when the page is loaded
    this.checkboxTarget.checked = false;
  }

  toggle() {
    if (this.inputTarget.type === "password") {
      this.inputTarget.type = "text";
    } else {
      this.inputTarget.type = "password";
    }
  }
}
