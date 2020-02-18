<template>
  <div class="watch_wiki">
    <a v-if="watchingWiki" class @click="toggleWatch()" data-turbolinks="false">
      <svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512">
        <path
          d="M474 74.2c-50.7-50.7-132.9-50.7-183.6 0-17.6 17.5-29 38.9-34.4 61.4-5.4-22.5-16.8-43.8-34.4-61.4-50.7-50.7-132.9-50.7-183.6 0-50.7 50.7-50.7 132.9 0 183.5l218 218 218-218c50.7-50.6 50.7-132.8 0-183.5z"
          fill="#fc7972"
        />
      </svg>
    </a>
    <a v-else class @click="toggleWatch()" data-turbolinks="false">
      <svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512">
        <path
          d="M474 74.2c-50.7-50.7-132.9-50.7-183.6 0-17.6 17.5-29 38.9-34.4 61.4-5.4-22.5-16.8-43.8-34.4-61.4-50.7-50.7-132.9-50.7-183.6 0-50.7 50.7-50.7 132.9 0 183.5l218 218 218-218c50.7-50.6 50.7-132.8 0-183.5z"
          fill="#d9d9d9"
        />
      </svg>
    </a>
    <p class="show-xl">このWikiをお気に入りに登録する</p>
  </div>
</template>

<script>
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
