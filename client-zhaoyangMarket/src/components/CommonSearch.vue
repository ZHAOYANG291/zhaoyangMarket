<template>
  <div class="containner">
    <div
      class="searchModelSign"
      :class="ifSearchModel ? '' : 'hidden'"
      @click="cancelSearchModel"
    >
      当前处于查询页面 <br />
      点击查看全部页面
    </div>

    <div>
      <input
        class="searchBox"
        id="searchKeyWords"
        size="40"
        placeholder="输入商品名--按enter开始搜索"
        type="text"
        autocomplete="off"
        @keydown.enter="doSearch"
      />
      <input
        class="searchButton"
        type="button"
        value="点击搜索"
        @click="doSearch"
      />

      <el-select
        v-model="category_id"
        placeholder="请选择"
        style="width: 100px;margin-left: 20px;"
        size="small"
      >
        <el-option
          v-for="item in category_options"
          :key="item.value"
          :label="item.label"
          :value="item.value"
          style="user-select:none;"
        >
        </el-option>
      </el-select>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";
export default {
  data() {
    return {
      category_options: [
        //       种类 对应Category表：
        //0、全部 1、游戏；2、小说；3、影视；4、漫画；5、音频；6、图片；7、神奇软件；8、神秘信息
        { 
          value: 0, 
          label: "全部" },
        {
          value: 1,
          label: "游戏",
        },
        {
          value: 2,
          label: "小说",
        },
        {
          value: 3,
          label: "影视",
        },
        {
          value: 4,
          label: "漫画",
        },
        {
          value: 5,
          label: "音频",
        },
        {
          value: 6,
          label: "图片",
        },
        {
          value: 7,
          label: "神奇软件",
        },
        {
          value: 8,
          label: "神秘信息",
        },
        {
          value: 9,
          label: "其他",
        },
      ],
      category_id: 0,
    };
  },
  computed: {
    ...mapState(["ifSearchModel"]),
  },
  watch: {
    ifSearchModel(newValue, oldValue) {},
  },
  methods: {
    doSearch() {
      let title = document.getElementById("searchKeyWords").value;
      let searchResults = null;

      if (title || this.category_id!=0) {
        this.$http
          .post("/query/productSearch", { title: title,category_id:this.category_id })
          .then((res) => {
            searchResults = res.data.results;
            this.$store.commit("setSearchProducts", searchResults);
            this.$store.commit("setIfSearchModel", true);
          })
          .catch((err) => {
            console.log(err);
          });
      } else {
        this.$store.commit("setIfSearchModel", false);
      }
    },
    cancelSearchModel() {
      this.$store.commit("setIfSearchModel", false);
    },
  },
  props: [],
};
</script>


<style lang="less" scoped>
.searchModelSign {
  width: 15%;
  height: 46px;
  background-color: rgba(49, 253, 226, 0.9);
  position: absolute;
  font-size: 14px;
  font-family: Arial, Helvetica, sans-serif;
  font-weight: 700;
  color: rgba(232, 28, 28, 0.8);
  z-index: 8;
  top: 5px;
  right: 55%;
  text-align: center;
  // line-height: 20px;
  border-radius: 10px;
  border: aqua 3px solid;
  box-shadow: 0px 0px 5px 1px rgba(152, 251, 152, 0.8);
  cursor: pointer;
  transition: border 3s linear, box-shadow 3s ease, background-color 0.1s ease;
  user-select: none;
}
.searchModelSign:hover {
  box-shadow: 0px 0px 10px 3px rgb(152, 251, 152);
  border: yellow 3px solid;
}
.searchModelSign:active {
  background-color: antiquewhite;
}

.hidden {
  display: none;
}
.searchButton {
  border-radius: 5px;
  margin-left: 10px;
  padding: 0 3px;
  height: 30px;
  background-color: rgba(251, 235, 214,0.9);
  cursor: pointer;
}
.searchButton:active{
  background-color: antiquewhite;
  font-weight: 600;
}
.containner {
  margin-right: 10px;

}
.searchBox {
  height: 30px;
  padding-left: 5px;
  vertical-align: middle;
}
input::-webkit-input-placeholder {
  color: rgba(105, 102, 102, 0.5);
}
</style>
