// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start()
// require('@rails/activestorage').start()
// require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('./images', true)
// const imagePath = (name) => images(name, true)

import './stylesheets/application.scss'
import './javascripts/src/sortable'

import Turbolinks from 'turbolinks'
Turbolinks.start()

window.toggleModal = function(target) {
  document.getElementById(target).classList.toggle('active')
}

import Marked from 'marked'
const renderer = new Marked.Renderer()
renderer.table = function(header, body) {
  const regex = /\:(.*?)\:/
  const addon = header.match(regex) ? header.match(regex)[1] : ''
  header = header.replace(/(\:.*?\:)/, '')

  return `
    <table class="table ${addon}">
      <thead>
        ${header}
      </thead>
      ${body}
    </table>`
}
window.addEventListener('turbolinks:load', () => {
  let md = document.getElementById('markdown')
  if (md != null) {
    md.innerHTML = Marked(md.innerHTML, { renderer: renderer })
  }
})

import hoverintent from 'hoverintent'
document.addEventListener('turbolinks:load', () => {
  var hoverIntentOptions = {
    interval: 50,
    sensitivity: 5
  }

  document.querySelectorAll('a').forEach(node => {
    if (node.dataset.turbolinks === 'false') {
      return
    }
    var prefetcher
    hoverintent(
      node,
      function() {
        var href = this.getAttribute('href')
        if (!href.match(/^\//)) {
          return
        }

        if (prefetcher) {
          if (prefetcher.getAttribute('href') != href) {
            prefetcher.getAttribute('href', href)
          }
        } else {
          var link = document.createElement('link')
          link.setAttribute('rel', 'prefetch')
          link.setAttribute('href', href)

          prefetcher = document.body.appendChild(link)
        }
      },
      function() {}
    ).options(hoverIntentOptions)
  })
})

import Toastify from 'toastify-js'
import 'toastify-js/src/toastify.css'
window.addEventListener('turbolinks:load', () => {
  let toast_els = document.querySelectorAll('.toast')
  toast_els.forEach(tst => {
    Toastify({
      text: tst.dataset.toastMsg,
      duration: 3000,
      newWindow: true,
      close: true,
      gravity: 'top', // `top` or `bottom`
      position: 'right', // `left`, `center` or `right`
      backgroundColor: 'linear-gradient(to right, #00b09b, #96c93d)',
      stopOnFocus: true // Prevents dismissing of toast on hover
      // onClick: function() {} // Callback after click
    }).showToast()
  })
})
