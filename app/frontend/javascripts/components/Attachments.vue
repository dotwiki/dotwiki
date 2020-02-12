<template>
  <div id="attachments">
    <table>
      <tbody>
        <tr v-for="atc in attachments">
          <td>
            <img :src="atc.file" style="width: 100px;" />
          </td>
          <td>
            <form @submit.prevent>
              <div class="input-group">
                <span class="input-group-addon">shortcode</span>
                <input
                  type="text"
                  class="form-input"
                  :value="atc.shortcode"
                  :data-record="atc.id"
                  @keydown.enter="change_shortcode"
                />
              </div>
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
      attachments: []
    }
  },
  mounted() {
    this.sync_attachments()
  },
  methods: {
    sync_attachments: function() {
      axios.get(`/wikis/${gon.wiki_id}/attachments/all.json`).then(res => {
        console.log(res.data)

        this.attachments = res.data
      })
    },
    change_shortcode: function(e) {
      let params = { shortcode: e.target.value }
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
    }
  }
}
</script>

<style lang="scss" scoped>
#attachments {
}
</style>
