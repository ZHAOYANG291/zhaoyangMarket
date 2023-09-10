export default {
    namespaced: true,
    state: {
        //定义菜单展开还是收起的属性
        isCollapse: false,
        // //面包屑的数据
        // tabsList: [
        //     //初始数据
        //     {
        //     path: "/home",
        //     name: "home",
        //     label: "首页",
        //     icon: "el-icon-s-home",
        //     url: "Home/Home",
        // }]
    },
    mutations: {
        //定义菜单展开还是收起的方法
        collapseMenu(state) {
            state.isCollapse = !state.isCollapse
        },
        // //选择菜单
        // selectMenu(state, val) {
            
        //     state.tabsList.push(val)
        // }
    }
}