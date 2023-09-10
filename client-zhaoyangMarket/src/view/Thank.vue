<template>
  <div>
   <div style="height: 100px;">
    <div class="thankInfo">
      <span>...</span>
    </div>
   </div>
    <!-- 打赏方式 -->
    <div style="margin-top: 60px;">
      <el-row style="display: flex; justify-content: center;">
   
          <el-card class="reward" :body-style="{ padding: '0px' }"  v-for="(indexValue) in 3" :key="indexValue">
            <img
              :src="words[indexValue-1].imgUrl"
              class="bigImage"
            />
            <div style="padding: 14px">
              <span>{{words[indexValue-1].title1}}</span><br>
              <span style="vertical-align: bottom;">{{words[indexValue-1].title2}} 
                <img :src="words[indexValue-1].emotionUrl" alt="Image" style="width: 20px;vertical-align:bottom">
               </span>
              <div class="bottom clearfix">
                <!-- <time class="time">{{ currentDate }}</time> -->
                <el-button type="text" class="button">{{words[indexValue-1].buttonMessage}}</el-button>
              </div>
            </div>
          </el-card>
      </el-row>
    </div>
  </div>
</template>

<script>

// baseLocalUrl="E:\VScode_programfile\yq_CodeNote\Vue\案例\backstage-management-system\src\assets"
export default {
  
  data() {
    return {
        words:[
            {
                title1:"千山鸟飞绝",
                title2:"万径人踪灭",
                imgUrl:require("@/assets/ratEating.gif"),
                emotionUrl:require("@/assets/emotions/image_emoticon_anger.png"),
                buttonMessage:"..."
            },
            {
                title1:"孤舟一蓑翁",
                title2:"独钓寒江雪",
                imgUrl:require("@/assets/ratEating.gif"),
                emotionUrl:require("@/assets/emotions/image_emoticon_happy.png"),
                buttonMessage:"..."
            },
            {
                title1:"落霞与孤鹜齐飞",
                title2:"秋水共长天一色",
                imgUrl:require("@/assets/ratEating.gif"),
                emotionUrl:require("@/assets/emotions/image_emoticon_shy.png"),
                buttonMessage:"..."
            }
        ]
    };
  },
  mounted(){
    // console.log(this.words[0])
  },
  methods:{
  }
};
</script>

<style lang="less" scoped>
.thankInfo {
  height: 100px;
  width: 600px;
  border: lightgray 3px solid;
  background-color: #303133;
  color: aliceblue;
  line-height: 40px;
  padding-left: 30px;
//   position: absolute;
//   left: 0;
//   right: 0;
  margin: 0 auto;
}

.reward{
    width: 250px;
    margin: 0 20px;
    .bigImage{
        width: 100%;
        height: 200px;
    }
}

</style>