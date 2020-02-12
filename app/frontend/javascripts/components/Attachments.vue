<template>
  <div id="attachments">
    <div
      id="dragzone"
      :class="{'dragover': isDrag == 'new'}"
      @dragover.prevent="checkDrag($event, 'new', true)"
      @dragleave.prevent="checkDrag($event, 'new', false)"
      @drop.prevent="onDrop"
    >
      <div class="drop">
        <p class="drag-drop-info">ここにファイルをドロップ</p>
        <p>または</p>
        <label class="btn btn-primary">
          ファイルを選択
          <input type="file" class="drop__input" style="display:none;" @change="onDrop" />
        </label>
      </div>
    </div>
    <table>
      <tbody>
        <tr v-for="atc in attachments">
          <td>
            <img :src="atc.file" class="fit_image" />
          </td>
          <td class="shortcode_td">
            <form @submit.prevent>
              <label for>
                shortcode:
                <input
                  type="text"
                  class="form-input"
                  :value="atc.shortcode"
                  :data-record="atc.id"
                  @keydown.enter="change_shortcode"
                />
              </label>
            </form>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import { csrfToken } from '@rails/ujs'
import axios from 'axios'
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

export default {
  data: function() {
    return {
      attachments: [],
      isDrag: null
    }
  },
  mounted() {
    this.sync_attachments()
  },
  methods: {
    sync_attachments: function() {
      axios.get(`/wikis/${gon.wiki_id}/attachments/all.json`).then(res => {
        this.attachments = res.data
      })
    },
    change_shortcode: function(e) {
      if (e.keyCode !== 13) return
      let sc = e.target.value
      if (!sc.match(/^[0-9a-zA-Z\_]*$/)) {
        toast('alert', '利用できない文字が含まれています')
        return
      }
      let params = { shortcode: sc }
      axios
        .patch(`/wikis/${gon.wiki_id}/attachments/${e.target.dataset.record}`, params)
        .then(res => {
          if (res.status == 200) {
            this.sync_attachments()
            toast('notice', 'shortcodeを更新しました')
            // TODO いつか重複だけは教えてあげたい
            // } else if (res.status == 204) {
            //   this.sync_attachments()
            //   toast('alert', '既に登録されているshortcodeです')
          }
        })
        .catch(err => {
          this.sync_attachments()
          toast('alert', 'エラーが発生しました')
        })
    },
    checkDrag: function(event, key, status) {
      if (status && event.dataTransfer.types == 'text/plain') {
        return false
      }
      this.isDrag = status ? key : null
    },
    onDrop: function(event, key = '', image = {}) {
      this.isDrag = null
      let fileList = event.target.files ? event.target.files : event.dataTransfer.files
      if (fileList.length == 0) {
        return false
      }
      let files = []
      for (let i = 0; i < fileList.length; i++) {
        files.push(fileList[i])
      }
      let file = files.length > 0 ? files[0] : []
      let fd = new FormData()
      fd.append('file', file)

      axios
        .post(`/wikis/${gon.wiki_id}/attachments/`, fd)
        .then(res => {
          if (res.status == 200) {
            this.sync_attachments()
            toast('notice', 'ファイルを追加しました')
          }
        })
        .catch(err => {
          this.sync_attachments()
          toast('alert', 'エラーが発生しました')
        })
    }
  }
}
</script>

<style lang="scss" scoped>
#dragzone {
  background-color: #ddf1fb;
  padding: 10px;
  margin-bottom: 1rem;
  &.dragover {
    background-color: #ddfbe2;
  }
  .drop {
    border: 2px dashed #fff;
    padding: 10px;
  }
}

.fit_image {
  width: 100px;
  height: 100px;
  object-fit: contain;
}

.shortcode_td {
  text-align-last: left;
}
</style>
