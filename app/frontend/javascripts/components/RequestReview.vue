<template>
  <div>
    <code-diff :oldString="oldStr" :newString="newStr" :context="10" :outputFormat="format" />
  </div>
</template>

<script>
import CodeDiff from 'vue-code-diff'

export default {
  components: { CodeDiff },
  data() {
    return {
      oldStr: gon.old_text,
      newStr: gon.new_text,
      format: 'side-by-side'
    }
  },
  methods: {
    setOutputFormat(width) {
      this.format = width >= 600 ? 'side-by-side' : 'line-by-line'
    }
  },
  mounted(){
    this.setOutputFormat(window.innerWidth)
  }
}
</script>
