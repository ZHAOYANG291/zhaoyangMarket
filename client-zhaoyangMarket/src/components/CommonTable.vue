<template>
    <!-- 在属性中去掉width属性，级代表着每一列都自适应宽度 -->
    <el-table
      :data="tableData"
      style="width: 100%"
      height="300"
      >
      <el-table-column 
        v-for="(val,key) in tableCol" 
        :key="key"
        :prop="key"
        :label="val">
      </el-table-column>
     
    </el-table>
  </template>

  <script>
  import {getProductInfo} from "@/api/index"
    export default {
      data() {
        return {
          
        }
      },
      props:["tableData","tableCol"],
      mounted(){
       
      }
    }
  </script>