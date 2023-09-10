import http from "@/utils/request-axios";
/*我们将所有的请求都放在api这个文件夹下面，主要就是为了使得代码更简洁，方便代码的阅读以及后期维护 */
// http.defaults.baseURL="http://47.115.223.73:4561"
http.defaults.baseURL="http://127.0.0.1:4561"
//请求首页数据
export const getOrderData = () => http.get("query/selectCategory")
//请求商品信息
export const getProductInfo = () => http.get("/home/getProductInfo")

//查询用户最近上线情况
export const getNumberOfOnline= (searchDay)=>http.post("/query/numberOfOnline",{searchDay:searchDay})
//查询某日期注册人数
export const getNewUserRegistCount=(searchDay)=>http.post("/query/newUserRegistCount",{searchDay:searchDay})

//管理员登录请求
export const getAdministratorLoginCheck=(reqBody)=>http.post("/query/administratorLoginCheck",reqBody)
