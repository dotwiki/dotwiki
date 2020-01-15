import Rails from '@rails/ujs'
import SimpleMDE from 'simplemde'
import 'simplemde/dist/simplemde.min.css'
import './src/inline-attachment'
import './src/codemirror-4.inline-attachment'

let mdeditor = document.getElementById('mdeditor')
let simplemde = new SimpleMDE({ element: mdeditor, showIcons: ['table'] })
inlineAttachment.editors.codemirror4.attach(simplemde.codemirror, {
  uploadUrl: '/wikis/' + mdeditor.dataset.wikiId + '/upload',
  extraHeaders: { 'X-CSRF-Token': Rails.csrfToken() }
})
