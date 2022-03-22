// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction

// This example controller works with specially annotated HTML like:

// <div class="relative"
//      data-controller="dropdown"
//      data-action="click->dropdown#toggle click@window->dropdown#hide"
//      data-dropdown-active-target="#dropdown-button"
//      data-dropdown-active-class="bg-teal-600"
//      data-dropdown-invisible-class="opacity-0 scale-95"
//      data-dropdown-visible-class="opacity-100 scale-100"
//      data-dropdown-entering-class="ease-out duration-100"
//      data-dropdown-enter-timeout="100"
//      data-dropdown-leaving-class="ease-in duration-75"
//      data-dropdown-leave-timeout="75">
//  <div data-action="click->dropdown#toggle click@window->dropdown#hide" role="button" data-dropdown-target="button" tabindex="0" class="inline-block select-none">
//    Open Dropdown
//  </div>
//  <div data-dropdown-target="menu" class="absolute pin-r mt-2 transform transition hidden opacity-0 scale-95">
//    <div class="bg-white shadow rounded border overflow-hidden">
//      Content
//    </div>
//  </div>
// </div>

import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['menu', 'button']

  connect() {
  	this.menuTarget.classList.add('hidden')
  }

  disconnect() {
  	this.menuTarget.classList.add('hidden')
  }

  toggle() {
  	this.menuTarget.classList.toggle('hidden')
  }
}