<template>
  <div>
        
    <el-menu
      default-active="1-4-1"
      class="el-menu-vertical-demo"
      @open="handleOpen"
      @close="handleClose"
      :collapse="isCollapse"
      background-color="#545c64"
      text-color="#fff"
      active-text-color="#ffd04b"
    >
    <!-- <h3 class="projectName">{{isCollapse? "后台":"通用后台管理系统"}}</h3> -->
      <el-menu-item :index="item.name" v-for="item in noChildren" :key="item.name"  @click="routerGo(item)">
        <i :class="item.icon"></i>
        <span slot="title">{{item.label}}</span>
      </el-menu-item>

      <el-submenu :index="item.name" v-for="item in haveChildren" :key="item.name" >
        <template slot="title" >
          <div >
            <i :class="item.icon" style="margin-right: 20px;"></i>
             <span >{{item.name}}</span>
          </div>
        </template>
        <el-menu-item :index="childItem.name" v-for="childItem in item.children" :key="childItem.name" @click="routerGo(childItem)">
            <i :class="childItem.icon"></i>
           <span>{{childItem.name}}</span>
        </el-menu-item>
      </el-submenu>
    </el-menu>
  </div>
</template>

<script>
export default {
  data() {
    return {
      menuData: [
        {
          path: "/main/home",
          name: "home",
          label: "首页",
          icon: "el-icon-s-home",
          url: "Home/Home",
        },
        {
          path: "/main/ProductManagement",
          name: "mall",
          label: "商品管理",
          icon: "el-icon-s-goods",
          url: "ProductManagement/ProductManagement",
        },
        {
          path: "/main/UserManagement",
          name: "user",
          label: "用户管理",
          icon: "el-icon-s-custom",
          url: "UserManagement/UserManagement",
        },
        {
          path: "/main/other",
          name: "other",
          label: "其他",
          icon: "el-icon-help",
          url: "Other/Other",
          children: [
            {
              path: "/main/other/thank",
              name: "thank",
              label: "感谢",
              icon: "el-icon-warning",
              url: "Thank/Thank",
            },
            {
              path: "/main/other/about",
              name: "about",
              label: "关于",
              icon: "el-icon-info",
              url: "About/About",
            },
          ],
        },
      ],
    };
  },
  methods: {
    handleOpen(key, keyPath) {
      // console.log("展开",key, keyPath);
    },
    handleClose(key, keyPath) {
      // console.log("折叠",key, keyPath);
    },
    routerGo(item){
      //如果当前路由与要跳转的到的路由不一致，才允许跳转  （$route是当前路由，item是要跳转到的路由）
if(this.$route.path!=item.path ){
  // this.$store.commit("tab/selectMenu",item)
  this.$router.push(item.path)
}
  }
},
  computed: {
    haveChildren() {
      return this.menuData.filter((item) => item.children);
    },
    noChildren(){
       return this.menuData.filter(item=>{return !item.children})
    },
    isCollapse(){
      //这里不用写 this.$store.modules.tab.state.isCollapse
      // console.log(this.$store)
      return this.$store.state.tab.isCollapse
    }
  },
};
</script>

<style lang="less" scoped >
/*解决Element的子菜单展开比总菜单多1px*/

.el-menu-vertical-demo:not(.el-menu--collapse) {
    width: 200px;
  }
.el-menu-vertical-demo {
  height:100vh;
}
.el-menu-vertical-demo.el-menu--collapse{
width: 50px;
}
.el-menu-item{
    display: flex;
    justify-content: flex-start;
    align-items: center;
}
// .el-submenu_title{
//   display: flex;justify-content: flex-start;align-items: center;
   
// }
.el-menu{
    border-right: 0;
    height: 100vh;
    min-height: 725px;
    max-height: 900px;
}
.projectName{
    // width: 200px;
    height: 50px;
    line-height: 50px;
    text-align: center;
    margin: 0 10px;
    background-color: #545c64;
    color: #fff;
    font-size: 16px;
    font-weight: 400;
}

@media (orientation:portrait){
  .projectName{
    color: red;
  }
}

@media(orientation: landscape) {
        body {
          color: rebeccapurple;
        }
      }
</style>

<style lang="less">
.el-menu--collapse{
  .el-tooltip{
      padding-left: 0 !important;
      text-align: center;
      padding-right: 0 !important;
    }
    .el-submenu__title{
      padding: 0 !important;
      text-align: center;
      div{
        i{
          margin: 0 !important;
        }
      }
    }
}
   
</style>