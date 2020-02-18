<template>
  <div id="notice" class>
    <transition-group name="notice-list" tag="ul">
      <li v-for="(notice, idx) in notices" :key="notice.date" class="notice-list-item">
        <a :href="notice.path">{{ notice.title }}</a>
        <i class="icon-trash" @click="removeNotice(idx)"></i>
      </li>
    </transition-group>
  </div>
</template>

<script>
console.log(gon.notices)

import { csrfToken } from '@rails/ujs'
import axios from 'axios'
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

export default {
  data: function() {
    return {
      notices: gon.notices
    }
  },
  methods: {
    removeNotice(idx) {
      axios.delete(`/users/${gon.current_user}/notices/${idx}`).then(res => {
        if (res.status == 200) {
          this.notices.splice(idx, 1)
        } else {
          Toastify({
            text: 'エラーが発生しました',
            duration: 3000,
            newWindow: true,
            close: true,
            gravity: 'top',
            position: 'right',
            backgroundColor: 'linear-gradient(to right, #00b09b, #96c93d)',
            stopOnFocus: true
          }).showToast()
        }
      })
    },
    tree1Changed(idx) {}
  }
}
</script>

<style lang="scss">
#notice {
  margin: 0;
  ul {
    &:last-child {
      border-bottom: 1px solid #ddd;
    }
    li.notice-list-item {
      display: flex;
      align-items: center;
      transition: all 0.5s;
      border-top: 1px solid #ddd;
      list-style: none;
      padding: 0.5rem 0.8rem;
      width: auto;
      margin: 0;
      a {
        display: inline-flex;
        flex: 1 1 auto;
        margin: 0;
      }
      i {
        display: inline-flex;
        line-height: 2.2rem;
        width: 2rem;
        cursor: pointer;
        color: #65f;
        font-size: 0.8rem;
      }
    }
  }
}

.notice-list-leave-to
/* .notice-list-leave-active for below version 2.1.8 */ {
  opacity: 0;
}
.notice-list-leave-active {
  position: absolute;
  i {
    display: none;
  }
}
</style>
