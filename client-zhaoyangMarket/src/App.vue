<template>
  <div id="app">
 <router-view></router-view>
  </div>
</template>

<script>
import 'element-ui/lib/theme-chalk/index.css';

export default {
  name: 'App',
  components: {
  }
}
</script>

<style lang="less">

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
body{
margin: 0;
padding: 0;
background-color: rgb(185, 189, 189);
}
</style>
