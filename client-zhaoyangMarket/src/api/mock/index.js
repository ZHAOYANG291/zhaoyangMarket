import Mock from "mockjs"
import mockServerDataHome from "@/api/mock/mockServerData/home"   //导入返回数据的处理函数
/*这里就是mock的编写 */

/* 当我们对于每个api都要拦截并且写处理函数(服务器为了返回数据的处理函数)的时候，如果将所有的处理函数都写在这个文件夹，就会显得这个文件很臃肿，
所以我们可以在这个文件里面只负责对请求拦截，但是对应的处理函数都写在另一个文件(@/mockServerData/)。然后用es6的import语法导入即可
*/
Mock.mock("api/home/getOrderData",mockServerDataHome.getOrderData)

//使用import导入的 返回数据的处理函数 来作为处理函数
Mock.mock("api/home/getProductInfo",mockServerDataHome.getProductInfo)

Mock.mock("api/home/getSquare",mockServerDataHome.getSquare)
Mock.mock("api/home/getTotalSales",mockServerDataHome.getTotalSales)

