<template>
  <div id="markdown_editor" data-turbolinks="false">
    <editor
      :value="page_content"
      :options="editorOptions"
      previewStyle="vertical"
      height="500px"
      mode="wysiwyg"
      ref="tuiEditor"
      @change="transfer_to_textarea"
    />
    <div class="modal" id="attachments_modal">
      <span class="modal-overlay" onclick="toggleModal('attachments_modal')"></span>
      <div class="modal-container">
        <div class="modal-header">
          <span class="btn btn-clear float-right" onclick="toggleModal('attachments_modal')"></span>
          <div class="modal-title h5">アップロードファイル一覧</div>
        </div>
        <div class="modal-body">
          <div class="content">
            <div class="panel">
              <div class="panel-header">
                <div class="panel-title"></div>
              </div>
              <div class="panel-body">
                <img v-for="atc in attachments" :src="atc.thumbnail" @click="insertImage(atc.file)" />
              </div>
            </div>
          </div>
        </div>
        <!--modal-body-->
        <div class="modal-footer">
          <div class="columns">
            <div class="column">
              <form onsubmit="return false;" class="input-group">
                <span class="input-group-addon">Width</span>
                <input type="number" v-model.number="insertImgWidth" class="form-input" />
              </form>
            </div>
            <div class="column">
              <form onsubmit="return false;" class="input-group">
                <span class="input-group-addon">Height</span>
                <input type="number" v-model.number="insertImgHeight" class="form-input" />
              </form>
            </div>
          </div>画像クリックで挿入できます
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { csrfToken } from '@rails/ujs'
import axios from 'axios'
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

import { Editor } from '@toast-ui/vue-editor'
import 'tui-editor/dist/tui-editor.css'
import 'tui-editor/dist/tui-editor-contents.css'
import 'tui-editor/dist/tui-editor-extTable'
import 'codemirror/lib/codemirror.css'

export default {
  components: {
    editor: Editor
  },
  data: function() {
    return {
      page_content: gon.page_content,
      attachments: [],
      insertImgWidth: 50,
      insertImgHeight: 50,
      editorOptions: {
        initialEditType: 'wysiwyg',
        minHeight: '500px',
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
          addImageBlobHook: this.addImage.bind(this)
        }
      }
    }
  },
  methods: {
    addImage: function(blob, callback) {
      const data = new FormData()
      data.append('image', blob)
      axios
        .post(`/wikis/${gon.wiki_id}/upload`, data)
        .then(res => {
          // console.log(res)
          callback(res.data.filename, '')
          this.getAttachments()
        })
        .catch(error => {})
    },
    getAttachments: function() {
      axios.get(`/wikis/${gon.wiki_id}/attachments/all.json`).then(res => {
        this.attachments = res.data
      })
    },
    insertImage: function(el) {
      if (!el.match(gon.cloudinary_path)) {
        if (this.$refs.tuiEditor.editor.currentMode == 'wysiwyg') {
          let result = `<img src="${el}" alt="">`
          this.$refs.tuiEditor.editor.wwEditor.replaceSelection(result)
        } else {
          let result = `![](${el})`
          this.$refs.tuiEditor.editor.mdEditor.replaceSelection(result)
        }
        this.transfer_to_textarea()
        return null
      }

      let opt = []

      if (this.insertImgWidth.length !== 0) {
        opt.push('w_' + this.insertImgWidth)
      }
      if (this.insertImgHeight.length !== 0) {
        opt.push('h_' + this.insertImgHeight)
      }
      if (opt.length === 2) {
        opt.unshift('c_fit')
      }

      let path = el
      if (opt.length !== 0) {
        path = gon.cloudinary_path + opt.join(',') + '/' + path.replace(gon.cloudinary_path, '')
      }

      let result
      if (this.$refs.tuiEditor.editor.currentMode == 'wysiwyg') {
        result = `<img src="${path}" alt="">`
        this.$refs.tuiEditor.editor.wwEditor.replaceSelection(result)
      } else {
        result = `![](${path})`
        this.$refs.tuiEditor.editor.mdEditor.replaceSelection(result)
      }
      this.transfer_to_textarea()
    },
    transfer_to_textarea: function() {
      let content_area = document.getElementById('content_area')
      content_area.value = this.$refs.tuiEditor.editor.getMarkdown()
    }
  },
  mounted: function() {
    this.getAttachments()
    this.$refs.tuiEditor.editor.eventManager.addEventType('InsertAttachment')
    this.$refs.tuiEditor.editor.eventManager.listen('InsertAttachment', () => {
      let modal = document.getElementById('attachments_modal')
      modal.classList.toggle('active')
    })
  }
}
</script>

<style lang="scss">
</style>
