<template>
  <div class="main">
    <el-container>
      <el-aside width="auto">
        <common-aside width="200px"></common-aside>
      </el-aside>
      <el-container>
        <el-header>
          <common-header></common-header>
        </el-header>
        <el-main>
          <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import CommonAside from "@/components/CommonAside.vue";
import CommonHeader from "@/components/CommonHeader.vue";
export default {
  data() {
    return {};
  },
  components: {
    CommonAside,
    CommonHeader
  },
};
</script>

<style lang="less" scoped>
.el-header {
  padding: 0;
}

.el-main {
  padding: 0;
  background-color: rgb(225, 223, 223);
}

.main {
  margin: 0 auto;
  background-color: rgba(144, 147, 153, 0.3);
  padding: 0;
  width: 100vw;
  height: 100vh;
  min-width: 1400px;
  max-width: 1700px;
  min-height: 600px;
  max-height: 800px;
  // overflow: hidden;
  // min-height: 700px;

}

// @media screen and (min-device-width: 1500px)  {
//  .main{
//   width: 100vw;
//   height: 100vh;
//   min-width: 1500px;
//   min-height: 700px;
//  }
// }</style>