<template>
  <div class="content">
    <el-row>
      <el-col :span="8">
        <el-card class="box-card-user">
          <!-- 个人信息 -->
          <div class="user">
           <div class="headPortraitContainer">
            <div class="headPortrait" :style="{background:'url('+headPortraitUrl+') no-repeat 0 0/100% 100%'}">
              <!-- <img
              :src="headPortraitUrl"
              alt="图片加载失败" /> -->
            </div>
           
           </div>
            <div class="userinfo">
              <H2 class="username">{{username}}</H2>
              <p class="useridentity">超级管理员--<i>{{nick_name}}</i></p>
               <p>权限等级【{{level}}】</p>
            </div>
          </div>
          <div class="loginfo">
            <p>上次登录-- 时间：<span>{{ lastOnline_date }}</span> &nbsp;&nbsp;地点：<span>{{ preLoginAddress?"":"暂无" }}</span></p>
            <p>本次登录-- 时间：<span>{{ currentOnline_date }}</span> &nbsp;&nbsp;地点：<span>{{ currentLoginAddress?"":"暂无" }}</span></p>
          </div>
        </el-card>
        <el-card class="box-card-product">
          <!-- 商品信息表格 -->
          <common-table :tableData="tableData" :tableCol="tableCol"></common-table>
        </el-card>
      </el-col>

      <el-col :span="16">
        <div class="content-right">

          <el-card >
            <!-- 用户上线情况 -->
            <div  style="height: 70px;padding-left: 20px;">
              <p style="color: rgb(179, 175, 175);font-weight: 600;">用户最近上线情况：</p>
              <el-input v-model="searchDay" placeholder="请输入要查询的日期,格式如(2001-01-18)" style="width: 300px;" @keypress.enter.native="searchOnlineUser(searchDay)"></el-input>
              <el-button plain @click="searchOnlineUser(searchDay)">查询</el-button>
              <span style="margin-left: 10px;">最近一次上线是在【{{ searchDay }}】的人数为：{{ onlineUserCount }}</span>
            </div>
            <hr>
            <div style="height: 300px;overflow-y: auto;padding-left: 20px;">
              <el-table :data="onlineUser" height="300px" style="width: 100%;">
                <el-table-column label="用户名" width="200" style="margin-left: 20px;">
                  <template slot-scope="scope">
                    <span>{{ scope.row.username }}</span>
                  </template>
                </el-table-column>
                <el-table-column label="爱心数量" width="180">
                  <template slot-scope="scope">
                    <span>{{ scope.row.heart }}</span>
                  </template>
                </el-table-column>
                <el-table-column label="昵称" width="180">
                  <template slot-scope="scope">
                    <span>{{ scope.row.nick_name }}</span>
                  </template>
                </el-table-column>
                <el-table-column label="注册时间" width="180">
                  <template slot-scope="scope">
                    <span>{{ scope.row.registration_date }}</span>
                  </template>
                </el-table-column>
              </el-table>

            </div>
            <hr style="color: aqua; font-size: large;">
          </el-card>
          
          <div class="graph">
            <!-- 坐标图 -->
            <el-card id="echartsBar"></el-card>
            <!-- 饼状图 -->
            <el-card id="echartsPie"></el-card>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import * as echarts from "echarts";
import moment from "moment";
import { getOrderData, getProductInfo, getNumberOfOnline } from "../api/index";
import CommonTable from "../components/CommonTable.vue";
import { bar1, pie1 } from "@/utils/options-echarts"
export default {
  data() {
    return {
      preLoginDate: "",
      preLoginAddress: "",
      currentLoginDate: "",
      currentLoginAddress: "",
      tableData: [],
      tableCol: {
        category: "商品种类",
        todayBuy: "今日购买",
        monthBuy: "本月购买",
        totalBuy: "总购买",
      },
      orderData: [],
      searchDay: "",
      onlineUser: [],
      onlineUserCount: 0,
      username:"",
      nick_name:"",
      level:0,
      headPortraitUrl:""
    };
  },
  components: {
    CommonTable,
  },
  methods: {
    //搜索用户上线情况
    searchOnlineUser(searchDay) {
      if(searchDay){
        getNumberOfOnline(searchDay).then(res => {
        this.onlineUserCount = res.data.results.length
        this.onlineUser = res.data.results
  
      })
      }
     
    }
  },
  mounted() {
    //获取商品表格中的信息
    // getProductInfo().then((res) => {
    //   this.tableData = res.data.results;
    // });

    this.searchDay=moment(Date.now()).format("YYYY-MM-DD")
    //获取订单信息
    getOrderData().then((res) => {

      let arr = res.data.results;
      for (let i = 0; i < res.data.results.length; i++) {
        this.tableData.push({ category: arr[i].name, todayBuy: 0, monthBuy: 0, totalBuy: arr[i].total_sale })
      }

    });
    //获取用户上线情况
    // numberOfOnline().then((res) => {
    //   let myecharts1 = echarts.init(this.$refs.EchartsLine);
    //   myecharts1.setOption({
    //     title: {
    //       text: "近7日上线人数",
    //     },
    //     legend: {
    //       data: [
    //         res.data[0].product,
    //         res.data[1].product,
    //         res.data[2].product,
    //         res.data[3].product,
    //       ],
    //     },
    //     tooltip: {
    //       trigger: "axis",
    //     },
    //     xAxis: {
    //       type: "category",
    //       data: ["1", "2", "3", "4", "5","6","7"],
    //     },
    //     yAxis: {
    //       type: "value",
    //     },
    //     series: [
    //       {
    //         name: res.data[0].product,
    //         data: res.data[0].sales,

    //         type: "line",
    //       },
    //       {
    //         type: "line",
    //         name: res.data[1].product,
    //         data: res.data[1].sales,
    //       },
    //       {
    //         type: "line",
    //         name: res.data[2].product,
    //         data: res.data[2].sales,
    //       },
    //       {
    //         type: "line",
    //         name: res.data[3].product,
    //         data: res.data[3].sales,
    //         // stack:"Total",   这个stack代表数据堆叠的意思，如果这样设置了，那么就会将同一列的数据加起来显示
    //         lineStyle: {
    //           color: "red",
    //           width: 6,
    //           type: "solid",
    //           cap: "square",
    //           join: "miter",
    //         },
    //       },
    //     ],
    //   });
    // });    
    this.searchOnlineUser(this.searchDay)
    //获取用户数据 柱状图
    bar1(document.getElementById('echartsBar'))
    //饼状图
    pie1(document.getElementById("echartsPie"))
    //从localStorage里面获取用户信息
    this.username= localStorage.getItem("username")
    this.nick_name= localStorage.getItem("nick_name")
    this.level= localStorage.getItem("level")
    this.headPortraitUrl= localStorage.getItem("headPortraitUrl")
    this.lastOnline_date= localStorage.getItem("lastOnline_date")
    this.currentOnline_date= localStorage.getItem("currentOnline_date")
    // console.log(this.headPortraitUrl)
  }
};
</script>

<style lang="less" >
.content {
  .el-card:hover {
    box-shadow: 0px 0px 5px 2px rgba(222, 222, 222, 0.8);
  }

  .box-card-user {
    .user {
      display: flex;
      align-items: center;
      padding-bottom: 20px;
      border-bottom: 1px solid lightgray;
      margin-bottom: 20px;
      font-family: Microsoft YaHei;
.headPortraitContainer{
  width: 200px;
  height: 100px;
  .headPortrait{
    width: 100px;
    height: 100px;
    margin: 0 auto;
    border-radius: 50%;

  }
 

}
      
      .userinfo {
        margin-left: 10px;
     
        H2{
           text-align: center;
        }
        .useridentity {
          margin-top: 10px;
        }
      }
    }

    .loginfo {
      // span {
      //   margin-left: 40px;
      // }
    }
  }

  .box-card-product {
    margin-top: 20px;
    height: 400px;
  }

//   .el-card__body{
// padding: 0px;
//     }
  .content-right {
    padding-left: 10px;
    height: 100%;
.echartsBar{
  height: 500px;
}
 .el-card__body{
  padding: 5px;
 }
    .order {
      overflow: hidden;
      flex-wrap: wrap;
      display: flex;
      justify-content: space-between;
      align-items: center;

      .box-card-order {
        cursor: pointer;
        width: 30%;
        height: 65px;
        margin-bottom: 20px;

        //  好像也没用  display: block !important;
        .icon-info {
          margin-left: 10px;
          display: flex;
          flex-direction: column;
          justify-content: center;

          .price {
            font-size: 20px;
          }

          .desc {
            font-size: 14px;
            font-weight: 600;
            color: lightgray;
          }
        }

        .box-icon {
          width: 65px;
          height: 65px;
          display: flex;
          justify-content: center;
          align-items: center;
          background-color: aqua;
     

          .icon {
            font-size: 36px;
            color: white;
          }
        }
      }
    }

    .graph {
      margin: 0;
      padding: 0;
      // height: 40% !important;
      height: 240px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 20px;

      .el-card {
        height: 100%;
        width: 48%;
      }
    }
  }
}
</style>
