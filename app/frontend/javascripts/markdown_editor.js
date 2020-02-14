import { csrfToken } from '@rails/ujs'
import axios from 'axios'
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

import Editor from 'tui-editor'
import 'tui-editor/dist/tui-editor.css'
import 'tui-editor/dist/tui-editor-contents.css'
import 'tui-editor/dist/tui-editor-extTable'
import 'codemirror/lib/codemirror.css'

const editor = new Editor({
  el: document.querySelector('#editorSection'),
  initialValue: gon.page_content,
  initialEditType: 'wysiwyg',
  previewStyle: 'vertical',
  height: '500px',
  usageStatistics: false,
  language: 'ja',
  toolbarItems: [
    'heading',
    'bold',
    'italic',
    'strike',
    'divider',
    'hr',
    'quote',
    'divider',
    'ul',
    'ol',
    'task',
    'indent',
    'outdent',
    'divider',
    'table',
    'image',
    'link',
    // 'code',
    // 'codeblock',
    'divider',
    {
      type: 'button',
      options: {
        name: 'Attachments',
        className: 'custom-button far fa-images',
        event: 'InsertAttachment',
        tooltip: 'アップロード一覧を表示'
      }
    }
  ],
  hooks: {
    addImageBlobHook: function(blob, callback) {
      const data = new FormData()
      data.append('image', blob)
      axios
        .post('/wikis/' + gon.wiki_id + '/upload', data)
        .then(response => {
          console.log(response)
          callback(response.data.filename, '')
        })
        .catch(error => {})
    }
  }
})

editor.eventManager.addEventType('InsertAttachment')
editor.eventManager.listen('InsertAttachment', () => {
  let modal = document.getElementById('attachments_modal')
  modal.classList.toggle('active')
})

window.tui = editor
