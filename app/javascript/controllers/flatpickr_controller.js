import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
	connect() {
		const options = {
			dateFormat: "d/m/Y",
		}
		flatpickr(this.element, options);
	}
}