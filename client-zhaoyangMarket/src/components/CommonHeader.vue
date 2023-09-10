<template>
  <div class="header-container">
    <div class="l-content">
      <el-button
        icon="el-icon-menu"
        size="mini"
        @click="clickHandler"
      ></el-button>
      <el-breadcrumb separator=">">
        <el-breadcrumb-item :to="{path:'/main/home'}" :replace="'/main/home' === $route.path">首页</el-breadcrumb-item>
        <el-breadcrumb-item v-for="(item,index) in currentRoteMeta" :key="index">{{item}}</el-breadcrumb-item>
        <!-- <el-breadcrumb-item>活动列表</el-breadcrumb-item>
                <el-breadcrumb-item>活动详情</el-breadcrumb-item> -->
      </el-breadcrumb>
    </div>
    <div class="R-content"  >
      <common-search  v-show="ifProductManagement"></common-search>
      <!-- <div class="theme" title="后面再完善">主题</div> -->
      <div @click="$router.push('/login')" class="chooseAdministrator"><i class="el-icon-sort"></i>切换用户</div>
    </div>
  </div>
</template>

<script>
import CommonSearch from './CommonSearch.vue';
export default {
  data() {
    return {
        // currentRoute:null,
    };
  },
  methods: {
    clickHandler() {
      this.$store.commit("tab/collapseMenu");
    },
  },
  computed: {
  currentRoteMeta(){
    return this.$route.meta
  },
  ifProductManagement(){
    return this.$route.fullPath=="/main/ProductManagement"
  }
  },
  watch:{
   
  },
  components:{
    CommonSearch
  }
};
</script>

<style lang="less" scoped >
.header-container {
  background-color: #333;
  padding: 0 20px;
  height: 60px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: relative;
}
.el-breadcrumb {
  display: inline-block;
  padding-left: 15px;
}
.l-content {
  display: flex;
  justify-content: flex-start;
  align-items: center;
}
.R-content{
  display: flex;
  .theme{
    border-radius: 6px;
    cursor: pointer;
    width: 60px;
    height: 30px;
    line-height: 30px;
    text-align: center;
    background-color: rgb(220, 212, 212);
  }
  .chooseAdministrator{
    cursor: pointer;
    width: 100px;
    height: 30px;
    line-height: 30px;
    text-align: center;
    border-radius: 15px;
    background-color:rgb(220, 212, 212);
    margin-left: 5px;
  }
}
</style>

<style lang="less">
.el-breadcrumb__inner {
  color: rgb(249, 249, 249) !important;
  font-size: 18px;
  a {
    color: rgb(249, 249, 249) !important;
  }
}
</style>