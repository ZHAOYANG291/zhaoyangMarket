import Vue from "vue"
import VueRouter from "vue-router"
import store from "@/store"
Vue.use(VueRouter)


//导入组件
import Main from "../view/Main.vue"
import UserManagement from "../view/UserManagement.vue"
import Home from "../view/Home.vue"
import ProductManagement from "../view/ProductManagement.vue"
import Other from "../view/Other.vue"
import Login from "../view/Login.vue"
import ProductDetail from "../view/ProductDetail.vue"
//创建路由
const routes = [
    {
        path: "/",
        // component:Login,
        redirect:"/login"
    },
    {
        path:"/main",
        component:Main,
        name:"",
        // meta:["首页"],
        children: [
            {
                path:"home",
                component:Home,
                meta:[]
            },
            {
                path: "UserManagement",
                component: UserManagement,
                meta:["用户管理"]
            }, //子路由，要么这样写(不简写，要注意/的数量)
            {
                path: "a/b/c/home",
                component: () => import("../view/Home.vue")
            },
            /*这样写也是可以的，反正路由都是自己随便配的，只要路由
                        不是由/打头的，都是代表着要沿用父路由的地址的。  而这种加载组件的方法称为懒加载，当我们要访问这个路由的时候，才加载这个组件，
                        以便节省初次访问这个页面而使用的流量
                        子路由，要么就这样简写，注意前面一定不要再加/了   这里应该是vuerouter插件自动帮我们加了*/
            {
                path: "ProductManagement",
                component: ProductManagement,
                meta:["商品管理"]
            },
            {
                path: "other",
                component: Other,
                children: [{
                        path: "thank",
                        component: () => import("../view/Thank"),
                        meta:["其他","感谢"]
                    },
                    {
                        path: "/main/other/about",
                        component: () =>import("../view/About"),
                        meta:["其他","关于"]
                        
                    }
                ]
            },

        ]
    },
    {
        path:"/ProductDetail",
        component:ProductDetail,
    },
    {
        path:"/login",
        component: ()=>import("../view/Login.vue")
    }

]




//创建VueRouter的实例对象，并且导出
const router= new VueRouter({
    routes
})

// 守卫路由
router.beforeEach((to, from, next) => {
    // 获取当前的路由路径
    const currentPath = to.path
    if(from.path===to.path){
        return
    }
    //如果不是去登录页面的话，那就需要看看是否有登录状态了
    if(to.path!="/login"){

   if(sessionStorage.getItem("loginState") && localStorage.getItem("username") ){
    
    next()
   }else{
   console.log(sessionStorage.getItem("loginState") ,localStorage.getItem("username"))
    next("/login")
   }

    }
    // next(false)
    // 更新面包屑的值
    // 例如，可以使用 Vuex 存储面包屑的值
    // 并在这里调用 Vuex 的 action 修改面包屑的值
    store.dispatch('updateCurrentPath', currentPath)
    next()
  })

  export default router
// export let a=5
// export class cl{}
// export function a(){}
// export {router}