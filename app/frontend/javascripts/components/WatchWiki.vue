<template>
  <div>
    <button v-if="watchingWiki" class="btn btn-full active" @click="toggleWatch()">ウォッチ中</button>
    <button v-else class="btn btn-full" @click="toggleWatch()">このwikiをウォッチする</button>
  </div>
</template>

<script>
import Vue from 'vue'
import { csrfToken } from '@rails/ujs'
import axios from 'axios'
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

export default {
  data: function() {
    return {
      watchingWiki: gon.wathing_wiki
    }
  },
  methods: {
    toggleWatch() {
      axios.patch(`/users/${gon.current_user}/watches/${gon.wiki_id}`).then(res => {
        if (res.status == 201) {
          this.watchingWiki = true
        } else {
          this.watchingWiki = false
        }
      })
    }
  }
}
</script>
