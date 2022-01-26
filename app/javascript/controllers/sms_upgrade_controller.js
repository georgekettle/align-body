import { Controller } from "@hotwired/stimulus"
import { isNative } from "helpers/native"

export default class extends Controller {
	static values = {
		locked: {
			type: Boolean,
			default: false
		},
		url: String,
		upgradeSmsSent: {
			type: Boolean,
			default: true
		},
	}

  connect() {
  	if (this.userEligibleForUpgradeSMS()) {
	  	this.sendUpgradeSMS()
  	}
  }

  userEligibleForUpgradeSMS() {
  	return(isNative() && this.lockedValue && this.hasUrlValue && !this.upgradeSmsSentValue)
  }

  sendUpgradeSMS() {
  	const csrfToken = document.head.querySelector('meta[name="csrf-token"]').content;
  	fetch(this.urlValue, {
			method: 'POST',
			headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
		})
		.then(res => res.json())
		.then(data => {
			// Handle response
			console.log('Data: ', data);
		})
		.catch(err => {
			// Handle error
			console.log('Error message: ', error);
		});

  }
}