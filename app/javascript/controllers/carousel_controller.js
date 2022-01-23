import { Controller } from "@hotwired/stimulus"
import Flickity from "flickity"

export default class extends Controller {
	static targets = ['container', 'cell', 'pageDots']
	static values = {
		dots: {
			type: Boolean,
			default: true
		},
		arrows: {
			type: Boolean,
			default: true
		}
	}

  connect() {
  	this.addClassToCells()
		this.carousel = new Flickity(this.containerTarget, {
		  // options
		  freeScroll: false,
		  cellAlign: 'left',
		  contain: true,
		  pageDots: this.dotsValue,
		  prevNextButtons: this.arrowsValue,
		  cellSelector: '.carousel-cell'
		});
		this.movePageDots()
  }

  disconnect() {
  	this.carousel.destroy()
  }

  addClassToCells() {
  	this.cellTargets.forEach(cell => {
  		cell.classList.add('carousel-cell')
  	})
  }

  movePageDots() {
  	if (this.hasPageDotsTarget) {
  		const flickityDots = document.querySelector('.flickity-page-dots')
  		if (flickityDots) {
  			this.pageDotsTarget.append(flickityDots)
  		}
  	}
  }
}