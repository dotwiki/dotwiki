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

window.toast = function toast(type, msg) {
  let toast = document.getElementById('toast')
  toast.classList.add(type)
  let toast_img = document.getElementById('toast_img')
  let ico = '👍'
  switch (type) {
    case 'alert':
      ico = '😭'
      break
    case 'success':
      ico = '🎉'
      break
  }
  toast_img.innerHTML = ico
  let toast_msg = document.getElementById('toast_msg')
  toast_msg.innerHTML = msg
  toast.classList.toggle('show')
  setTimeout(function() {
    toast.className = toast.className.replace('show', '')
  }, 5000)
}
