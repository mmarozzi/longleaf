import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "input", "btnConfirm", "btnNext", "progressBar"]

  connect() {
    this.index = 0
    this.showCurrentDiv()
    this.inputTargets.slice(0, -1).forEach((input) => {
      input.addEventListener("keydown", (event) => this.handleKeydown(event))
    })
    const lastInput = this.inputTargets[this.inputTargets.length - 1];
    lastInput.addEventListener("keydown", (event) => this.handleLastKeydown(event))
  }

  updateProgressBar() {
    const totalSteps = this.contentTargets.length - 1
    const currentStep = this.index

    const progressPercent = (currentStep / totalSteps) * 100
    this.progressBarTarget.style.width = `${progressPercent}%`
  }

  showCurrentDiv() {
    this.contentTargets.forEach((element, i) => {
      element.classList.toggle("hidden", i !== this.index)
      if (i === this.index) {
        const input = element.querySelector("input, select")
        if (input) {
          input.focus()
        }
      }
    })
    this.updateProgressBar()
  }

  next(event) {
    event.preventDefault()
    if (this.isCurrentInputValid() && this.index < this.contentTargets.length - 1) {
      this.index++
      this.showCurrentDiv()
    }
    if (this.index === this.contentTargets.length - 1) {
      this.btnConfirmTarget.classList.remove("hidden")
      this.btnNextTarget.classList.add("hidden")
    }
  }

  previous(event) {
    event.preventDefault()
    this.btnConfirmTarget.classList.add("hidden")
    this.btnNextTarget.classList.remove("hidden")

    if (this.index > 0) {
      this.index--
      this.showCurrentDiv()
    }
  }

  handleKeydown(event) {
    if (event.keyCode === 13 && this.index !== this.contentTargets.length - 1) {
      this.next(event)
    }
  }

  handleLastKeydown(event) {
    if (event.keyCode === 13) {
      event.preventDefault()
      if (this.isCurrentInputValid()){
        const form = event.target.closest('form')
        if (form) {
          form.requestSubmit()
        }
      }
    }
  }

  isCurrentInputValid() {
    const currentInput = this.contentTargets[this.index].querySelector("input, select")
    return currentInput && currentInput.value.trim() !== ""
  }
}
