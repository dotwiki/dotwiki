<template>
  <div id="app">
    <div class="columns">
      <div class="column">
        <tree :data="tree1data" draggable="draggable" cross-tree="cross-tree" @drop="tree1Changed">
          <div slot-scope="{ data, store }">
            <template>
              <b v-if="data.children &amp;&amp; data.children.length">-&nbsp;</b>
              <span>{{ data.title }}</span>
            </template>
          </div>
        </tree>
      </div>
      <div class="column">
        <tree :data="tree2data" draggable="draggable" cross-tree="cross-tree">
          <div slot-scope="{ data, store }">
            <template>
              <b v-if="data.children &amp;&amp; data.children.length">-&nbsp;</b>
              <span>{{ data.title }}</span>
            </template>
          </div>
        </tree>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import { DraggableTree } from 'vue-draggable-nested-tree/dist/vue-draggable-nested-tree.js'

import { csrfToken } from '@rails/ujs'
import axios from 'axios'
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

Vue.component('tree', DraggableTree)

export default {
  data: function() {
    return {
      tree1data: gon.display_pages,
      tree2data: gon.non_display_pages
    }
  },
  methods: {
    tree1Changed() {
      let sd = []
      this.tree1data.forEach(function(parent) {
        console.log(parent)
        sd.push({ page_id: parent.page_id })
        if (parent.children.length >= 1) {
          let ch = []
          parent.children.forEach(function(children) {
            ch.push({ page_id: children.page_id })
          })
          sd.push(ch)
        }
      })
      axios.patch('/wikis/' + gon.wiki_id + '/nav', { tree: sd })
    },
    expandAll() {
      th.breadthFirstSearch(this.tree1data, node => {
        node.open = true
      })
    },
    collapseAll() {
      th.breadthFirstSearch(this.tree1data, node => {
        node.open = false
      })
    }
  }
}
</script>
