import { getTotalSales } from "@/api"
import Mock from "mockjs"

export default {
    getStatisticalData: () => {

    },
    getProductInfo(options) {
        return [{
                course: "人类简史",
                todayBuy: 15,
                monthBuy: 66,
                totalBuy: 681
            },
            {
                course: "平凡的世界",
                todayBuy: 50,
                monthBuy: 623,
                totalBuy: 1967
            },
            {
                course: "醉古堂剑扫",
                todayBuy: 45,
                monthBuy: 945,
                totalBuy: 6324
            },
            {
                course: "高等数学A2",
                todayBuy: 7,
                monthBuy: 37,
                totalBuy: 311
            }
        ]
    },
    getOrderData(options){
       return[
            {
                value:12,
                name:"今日支付订单",
                icon:"success"
            },
            {
                value:66,
                name:"今日收藏订单",
                icon:"star-on"
            },
            {
                value:7,
                name:"今日未支付订单",
                icon:"s-goods"
            },
            {
                value:611,
                name:"本月支付订单",
                icon:"success"
            },
            {
                value:6751,
                name:"本月收藏订单",
                icon:"star-on"
            },
            {
                value:754,
                name:"本月未支付订单",
                icon:"s-goods"
            },
        ]
    },
    getSquareMockFunc(options) {
        let num = options.body
    },
    getTotalSales(){
       let randomArr=Array.from({length:5},()=>Math.floor(Math.random() * 46) + 5)
        return [
            {product:"人类简史",sales:[33,37,44,21,6]},
            {product:"平凡的世界",sales:[12,54,33,67,12]},
            {product:"醉古堂剑扫",sales:[26,42,33,14,33]},
            {product:"高等数学A2",sales:randomArr},
        ]
    }
}