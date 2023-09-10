<template>
  <!-- 产品展示start -->
  <div class="products">
    <div class="productContainer">
      <el-card>
        <el-button @click="addProductHandler" style="font-size: 180px; border: 0" icon="el-icon-circle-plus"></el-button>
        <br />
        <p style="text-align: center">点击添加商品</p>
      </el-card>
      <el-card :body-style="{ padding: '0px' }" class="goods" v-for="(item, index) in allProducts" :key="item.name">
        <div class="container-left" @click="showDetail(item.id)">
          <div class="coverContainer">
            <img :src="item.coverImage_url" alt="该商品没有提供图片哦" class="image no-select" style="width: 100%" />
          </div>
          <div class="item-title" :title="item.title">
            <span>{{ item.title }}</span>
          </div>
          <div class="item-price">
            <i class="bi bi-heart-fill"></i>
            <span class="newPrice">{{ item.new_price }}</span>
            <!-- <span class="prePrice">￥{{ item.pre_price }}</span> -->
          </div>
          <div class="item-sales">
            <span>已售{{ item.already_sale }}</span>
          </div>
        </div>

        <div class="container-right">
          <el-button type="primary" icon="el-icon-edit" @click="editHandler(index)">编辑</el-button>
          <el-button type="primary" icon="el-icon-sell" @click="changeSaleStateHandler(index)">{{ item.on_sale == 1 ? "在售"
            : "停售" }}</el-button>
          <el-button type="primary" icon="el-icon-s-release" @click="delistingHandler(index)">下架</el-button>
          <div>
            <el-button class="saleState" :class="item.on_sale == 1 ? 'bc_green' : 'bc_gray'" type="info">{{ item.on_sale
              == 1 ? "在售" : "停售" }}</el-button>
          </div>
        </div>
      </el-card>



    </div>
    <!-- 产品展示end -->

    <!-- 产品dialog--start -->
    <el-dialog :title="dialogModelIsEdit ? '编辑商品' : '添加商品'" :visible.sync="dialogVisible" top="10"  width="45%" style=" max-width: 1500px; margin:10px auto"
      id="productDialog" :close-on-press-escape="true" @close="dialogCloseHandler" @open="dialogOpenHandler">
      <el-card class="editMenu">
        <el-form ref="ref_currentform" :model="currentForm" :rules="formRules">
          <el-form-item label="标题" prop="title">
            <el-input v-model="currentForm.title" placeholder="商品标题" style="width: 70%"
              :title="currentForm.title"></el-input>
          </el-form-item>
          <el-form-item label="资源" prop="resource">
            <el-input type="textarea" v-model="currentForm.resource" class="placeholderLineHeight" :rows="4"
              style="width: 80%" placeholder="推荐格式--- 百度网盘地址:...  提取码:... " maxlength="10000" show-word-limit>
            </el-input>
          </el-form-item>
          <el-form-item label="分类" prop="category_id">
            <el-select v-model="currentForm.category_id" style="width: 200px" placeholder="请选择资源种类">
              <el-option v-for="item in category_options" :key="item.label" :label="item.label" :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="现价(爱心)" prop="new_price">
            <el-input v-model="currentForm.new_price" placeholder="商品现价" style="width: 100px"></el-input>
            <i class="bi bi-heart-fill" style="color: red; font-size: 20px;padding-left: 5px;"></i>
          </el-form-item>

          <el-form-item label=" 封面" prop="coverImage_url">
            <el-input v-model="currentForm.coverImage_url" placeholder="图片url地址(300字以内)" style="width: 50%"
              :title="currentForm.coverImage_url"></el-input>
            <div @click="chooseCoverImageFile" class="chooseImageFile">选择图片</div>
            <input type="file" style="display: none" id="coverImageFile" accept=".jpg,.jpeg,.png,.gif" />
            <div class="showCoverImg" :style="{ background: 'url(' + currentForm.coverImage_url + ') no-repeat 0/100% auto' }">
            </div>
          </el-form-item>

          <el-form-item label="图片说明" prop="explainImage_urls">
             <div @click="chooseExplainImageFile"  class="chooseImageFile" style="width: 200px;">选择图片(不超过8张)</div>
              <input type="file" style="display:none" id="explainImageFile" multiple accept=".jpg,.jpeg,.png,.gif"/>
             <ul class="explainImgContainer"> 
             <li v-for="item in currentForm.explainImage_urls?JSON.parse(currentForm.explainImage_urls):''" :key="item" style="overflow: hidden;">
            <img :src="item" alt="" style="width:100%">
            </li>
            </ul>
          </el-form-item>

          <el-form-item label="描述" prop="description">
            <el-input v-model="currentForm.description" placeholder="商品描述(300字以内)" style="width: 70%"
              :title="currentForm.description"></el-input>
          </el-form-item>
          <!-- <el-form-item label="原价(元)" prop="pre_price">
            <el-input v-model="currentForm.pre_price" placeholder="商品原价(若为-1则说明该商品未设置原价)" title="商品原价(若为-1则说明该商品未设置原价)"
              style="width: 70%"></el-input>
          </el-form-item> -->
          <el-form-item label="已售" prop="already_sale">
            <el-input v-model="currentForm.already_sale" placeholder="已售(不建议自主修改)" style="width: 200px"
              disabled></el-input>
          </el-form-item>
          <el-form-item label="库存" prop="stock_quantity">
            <el-input v-model="currentForm.stock_quantity" placeholder="商品库存(若为-1则说明该商品未设置库存量)"
              title="商品库存(若为-1则说明该商品未设置库存量)" style="width: 350px"></el-input>
          </el-form-item>
          <el-form-item label="是否显示出售" prop="on_sale">
            <el-radio v-model="currentForm.on_sale" :label="0">停售</el-radio>
            <el-radio v-model="currentForm.on_sale" :label="1">在售</el-radio>
          </el-form-item>
          <el-form-item label="展现优先级(0-255)" prop="level">
            <el-input-number v-model="currentForm.level" size="medium" :min="0" :max="255" label="描述文字"
              title="优先级越大则越是靠前展示，100为默认值"></el-input-number>
          </el-form-item>
          <p style="margin-top: 10px;">
            商品id: {{ currentForm.id }}
          </p>
          <p class="created_at" v-show="currentForm.created_at">
            商品创建时间：{{ currentForm.created_at }}
          </p>
          <p class="updated_at" v-show="currentForm.updated_at">
            商品更新时间：{{ currentForm.updated_at }}
          </p>
        </el-form>
      </el-card>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialgCancel">取 消</el-button>
        <el-button type="primary" @click="dialgConfirm">确定</el-button>
      </span>
    </el-dialog>
    <!-- 产品dialog--end -->

    <!-- 警告--start -->
    <el-alert :class="sqlAlert == 'success' ? 'showAlert' : ''" title="操作成功" type="success" show-icon center
      @close="closeAlertHandler">
    </el-alert>

    <el-alert :class="sqlAlert == 'error' ? 'showAlert' : ''" title="出错啦" type="error" show-icon center
      @close="closeAlertHandler">
    </el-alert>
    <!-- 警告--end -->

    <!-- 页签--start -->
    <div class="selectPageContainer">
      <span style="margin-right: 50px; font-weight: 700" class="no-select">目前在第：{{ pageNumber + "/" + pageTotalNumber
      }}页</span>
      <el-button type="primary" @click="getProductPage('-')">上一页</el-button>
      <ul class="choosePage">
        <li @click="getProductPage(item)" class="no-select" :class="pageNumber == item ? 'currentPage' : ''"
          v-for="item in paginationFront" :key="item + 94">
          {{ item }}
        </li>
        <span class="no-select" v-if="pageTotalNumber > 10">....</span>
        <li @click="getProductPage(item)" class="no-select" :class="pageNumber == item ? 'currentPage' : ''"
          v-for="item in paginationBack" :key="item + 156">
          {{ item }}
        </li>
      </ul>
      <el-button type="primary" @click="getProductPage('+')">下一页</el-button>
      <input type="text" placeholder="要跳转的页数" size="8" class="goPageNumberInput no-select" v-model="goPageNumber"
        @keydown.enter="getProductPage(goPageNumber)" />
    </div>

    <!-- 页签--end -->
  </div>
</template>

<script>
import moment from "moment";
import { mapState } from "vuex";
import commonFunc from "../utils/commonFunc.js"


export default {
  data() {
    //数字验证的vilidator
    let numberVilidator = {
      validator: (rule, value, callback) => {
        if (value) {
          if (isNaN(Number(value))) {
            callback(new Error("必须填数字"));
          } else {
            callback();
          }
        } else {
          callback();
        }
      },
      trigger: "blur",
    };

    return {
      goPageNumber: "",
      category_options: [
        //       种类 对应Category表：
        // 1、游戏；2、小说；3、影视；4、漫画；5、音频；6、图片；7、神奇软件；8、神秘信息
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
      formRules: {
        title: { required: true, message: "商品的标题为必填，且在120字以内", min: 1, max: 120 },
        new_price: [
          { required: true, message: "商品的现价为必填", trigger: "blur" },
          // { type:"number", message: "必须填数字",trigger:"blur" }, 没用，input输入的始终为字符串类型的数据
          numberVilidator,
        ],
        category_id: { required: true, message: "商品的分类为必选" },
        resource: {
          required: true,
          max: 10000,
          message: "资源为必填项，请在10000字以内对商品的资源进行说明",
        },
        description: { max: 300, message: "字数不能超过300字", trigger: blur },
        coverImage_url: { max: 300, message: "字数不能超过300字", trigger: blur },
        // pre_price: numberVilidator,
        stock_quantity: numberVilidator,
      },
      sqlAlert: "",
      dialogModelIsEdit: true,
      allProducts: [],
      dialogVisible: false,
      currentIndex: -1,
      currentForm: {
        title: "",
        new_price: 0,
        category_id: 0,
        resource: "",
        id: 0,
        description: "",
        coverImage_url: null,
        explainImage_urls:null,
        // pre_price: 0,
        already_sale: null,
        stock_quantity: null,
        on_sale: "1",
        level: 100,
        created_at: "",
        updated_at: "",
      },
      coverImgFormData: null,
      lowerLimit: 0, //要查询页面的起始商品的位置
      pageNumber: 1, //当前页码
      pageProductCount: 7, //每页的商品数量
      productTotalNumber: 0, //商品总量
      pageTotalNumber: 0, //商品总页数
      paginationFront: [], //页码选择器的前置页码最多5个
      paginationBack: [], //页码选择器的后置页码最多5个
      paginationFrontTemp: [], //页码选择器的前置页码临时存放点
      paginationBackTemp: [], //页码选择器的后置页码临时存放点
    };
  },
  computed: {
    ...mapState(["searchProducts", "ifSearchModel"]),
  },
  watch: {
    searchProducts(newValue, oldValue) {
      this.allProducts = newValue;
    },
    ifSearchModel(newValue, oldValue) {
      if (!newValue) {
        this.getProductPage(this.pageNumber);
      }
    },
  },
  methods: {
    ...commonFunc,
    //选封面
    chooseCoverImageFile() {
      //获取真正的input file标签
      let inputFile = document.getElementById("coverImageFile");
      //模仿点击事件，触发选择文件
      inputFile.click();

      inputFile.onchange = () => {
        let formData = new FormData();
        let file = inputFile.files[0];
        if (file) {//如果选择了文件的话，就封装这个formData
          if (file.size > 10485760) {//文件大于10MB  10485760 的话 1024*1024*10B
            alert("图片大小不能超过10MB，请重新选择");
            inputFile.value = "";
            return;
          }
          this.$set(this.currentForm, "coverImage_url", URL.createObjectURL(file))
          // this.currentForm.coverImage_url = URL.createObjectURL(file)
          // console.log(this.currentForm.coverImage_url)
          formData.append("coverImg", file);
          formData.append("id", this.currentForm.id)
          this.coverImgFormData = formData
        } else {
          this.coverImgFormData = null
          document.getElementById("coverImageFile").value = "";
        }

      };
    },
    //选择说明图片
   async chooseExplainImageFile(){
      let inputFile=document.getElementById('explainImageFile')
      //模仿点击事件，触发文件选择
      inputFile.click()
      inputFile.onchange=async ()=>{
        //创建表单对象
        let formData=new FormData()
        // console.log(inputFile.files instanceof FileList)
        if( inputFile.files instanceof FileList){
    
          if(inputFile.files.length>8){
            alert("图片数量请勿超过8张")
            return;
          }
          for(let i=0;i<inputFile.files.length;i++){

          if(inputFile.files[i].size>10485760){
            alert("不能有大于10MB的图片，请重新选择")
            inputFile.value
            return;
          }
          formData.append("explainImg",inputFile.files[i])
          }
          
        }else{
          console.log("选择的不是文件数组")
          return;
        }

formData.append("id",this.currentForm.id)
      let result= await this.$http.post("/upload/explainImg",formData)
      // console.log(result)
       if(result.data.status){
        this.currentForm.explainImage_urls=result.data.imgUrls
       }
      }
    },

    // 获取一整页的商品信息
    getProductPage(index) {
      if (index == "-" && this.pageNumber > 1) {
        this.pageNumber--;
        this.$store.state.ifSearchModel = false;
        //发送axios请求，获取一整页的商品信息
        this.getNextPageCommonFunc(() => {
          this.pageNumber++;
        })();
      } else if (index == "+" && this.pageNumber < this.pageTotalNumber) {
        this.pageNumber++;
        this.$store.state.ifSearchModel = false;
        this.getNextPageCommonFunc(() => {
          this.pageNumber--;
        })();
      } else {
        let pageNumber = Number(index);
        if (
          !isNaN(pageNumber) &&
          pageNumber > 0 &&
          pageNumber <= this.pageTotalNumber
        ) {
          let pageNumberTemp = this.pageNumber;
          this.pageNumber = pageNumber;
          this.$store.state.ifSearchModel = false;
          this.getNextPageCommonFunc(() => {
            this.pageNumber = pageNumberTemp;
          })();

          this.goPageNumber = "";
        }
      }
    },
    //根据category_id获取商品种类名称
    currentCategoryName(category_id) {
      let category = this.category_options.find((item) => {
        if (item.value == category_id) return item.value;
      });
      if (category) {
        return category.value;
      }
      return "请选择商品类型";
    },

    //开始添加商品（增）
    addProductHandler() {
      this.dialogModelIsEdit = false;
      this.dialogVisible = true;
      this.currentForm = {};
      this.$nextTick(() => {
        this.$refs.ref_currentform.clearValidate();
      });
    },
    //商品下架（删）
    delistingHandler(index) {
      if (
        confirm("你确定要下架这款商品吗？下架后这款商品的所有信息将被清空！")
      ) {
        this.$http
          .post("/delete/deleteProduct", {
            id: this.allProducts[index].id,
          })
          .then(
            this.commonResolveFunc(() => {
              //下架当前页面的这个商品
              let delistedProduct = this.allProducts.splice(index, 1);
              // console.log("下架商品:", delistedProduct);
            }),
            this.commonRejectFunc
          )
          .catch(this.commonErrorFunc);
      }
    },
    //开始编辑商品（改）
    editHandler(index) {
      this.dialogModelIsEdit = true;
      this.dialogVisible = true;
      this.currentIndex = index;

      let currentProduct = { ...this.allProducts[index] };

      if (!this.dialogModelIsEdit) {
        currentProduct["created_at"] = moment(Date.now()).format(
          "YYYY-MM-DD HH:mm:ss"
        );
      }
      //把不必要的字段给去掉
      //把js的日期格式转化为MySQL的datetime类型的格式（主要是因为js在解析从MySQL中获取到的日期格式时，是按照另外一种格式解析的，所以我们才需要这样做）
      if (currentProduct["created_at"]) {
        currentProduct["created_at"] = moment(
          currentProduct["created_at"]
        ).format("YYYY-MM-DD HH:mm:ss");
      } else {
        delete currentProduct.created_at;
      }

      if (currentProduct["updated_at"]) {
        currentProduct["updated_at"] = moment(
          currentProduct["updated_at"]
        ).format("YYYY-MM-DD HH:mm:ss");
      }

      if (!currentProduct.stock_quantity) delete currentProduct.stock_quantity;

      this.currentForm = currentProduct;
      this.$nextTick(() => {
        this.$refs.ref_currentform.clearValidate();
      });
    },
    dialogOpenHandler() {
      this.$nextTick(() => {
        // this.$refs.productDialog.scrollTop=0  这样不行！
        //每次打开dialog，就让滚动条的位置初始为0
        document.getElementById("productDialog").scrollTop = 0;
      });
    },
    dialogCloseHandler() { },
    dialogBeforeCloseHandler() { },
    dialgCancel() {
      this.dialogVisible = false;
      this.coverImgFormData = null;
      document.getElementById("coverImageFile").value = "";
    },
    //确定编辑/添加商品（改/增）
    dialgConfirm() {
      this.$refs["ref_currentform"].validate(async (ifvalid) => {
        //如果表单的验证通过:
        if (ifvalid) {

          if (this.coverImgFormData) {
            await this.$http
              .post("/upload/coverImg", this.coverImgFormData)
              .then((res) => {
                //如果封面图片上传到服务器成功
                if (res.data.status && res.data.imgUrl) {
                  this.currentForm.coverImage_url = res.data.imgUrl + "?t=" + Date.now()
                }
              });
          }

          //如果是el-dialog的编辑商品模式那么就走这条分支
          if (this.dialogModelIsEdit) {
            this.dialogVisible = false;

            this.currentForm.updated_at = moment(Date.now()).format(
              "YYYY-MM-DD HH:mm:ss"
            );


            //修改数据库的数据
            this.$http
              .post("/update/updateProduct", this.currentForm)
              .then(
                this.commonResolveFunc(() => {
                  //修改当前页面的数据
                  this.allProducts[this.currentIndex] = { ...this.currentForm };
                }),
                this.commonRejectFunc
              )
              .catch(this.commonErrorFunc);
          } else {//如果是el-dialog的添加商品模式 那么就走这条分支

            this.currentForm.created_at = moment(Date.now()).format(
              "YYYY-MM-DD HH:mm:ss"
            );
            this.currentForm.updated_at = moment(Date.now()).format(
              "YYYY-MM-DD HH:mm:ss"
            );

            this.$http
              .post("insert/InsertProduct", this.currentForm)
              .then(this.commonResolveFunc(), this.commonRejectFunc)
              .catch(this.commonErrorFunc);
          }

          this.dialogVisible = false;
        } else {
          //如果表单的验证没有通过
          alert("请按需求填写表单");
        }
        //清空coverImgFormData的数据
        this.coverImgFormData = null
        document.getElementById("coverImageFile").value = "";
      });
    },

    //改变商品销售状态（改）
    changeSaleStateHandler(index) {
      this.allProducts[index].on_sale =
        this.allProducts[index].on_sale == 0 ? 1 : 0;
      let obj = this.allProducts[index];
      this.$http
        .post("/update/updateProduct", {
          id: obj.id,
          on_sale: obj.on_sale,
        })
        .then(this.commonResolveFunc(), this.commonRejectFunc)
        .catch(this.commonErrorFunc);
    },
    closeAlertHandler() {
      this.sqlAlert = "";
    },
    //跳转到商品的展示页面
    showDetail(id) {
      this.$router.push("/ProductDetail?id=" + id)
    }
  },
  mounted() {
    this.$store.commit("setIfSearchModel", false);

    //获取某一页的数据,15条（查）
    this.$http
      .post("/query/selectNextPage", {
        lowerLimit: this.lowerLimit,
        pageProductCount: this.pageProductCount,
      })
      .then((res) => {
        this.allProducts = res.data.results;
        // console.log(res.data);
        // console.log(this.allProducts)
      });

    this.$http.get("/query/selectAllCount").then((res) => {
      try {
        //获取到总共有多少个商品
        this.productTotalNumber = Number(res.data.results[0]["COUNT(*)"]);
        //获取到总共有多少页
        this.pageTotalNumber = Math.ceil(
          this.productTotalNumber / this.pageProductCount
        );
        if (this.pageTotalNumber <= 10) {
          for (let i = 0; i < this.pageTotalNumber; i++) {
            this.paginationFront[i] = i + 1;
          }
        } else if (this.pageTotalNumber > 10) {
          this.paginationFront = [1, 2, 3, 4, 5];
          this.paginationBack = [
            this.pageTotalNumber - 4,
            this.pageTotalNumber - 3,
            this.pageTotalNumber - 2,
            this.pageTotalNumber - 1,
            this.pageTotalNumber,
          ];
        }
      } catch (error) {
        // console.log(error);
      }
    });
  },
};
</script>

<style lang="less"  scoped>
@import "../../node_modules/bootstrap-icons/font/bootstrap-icons.css";

.products {
  position: relative;
  height: calc(100vh - 80px);
    min-height: 650px;
    max-height: 700px;
    width: 100%;
  // height: ;
  // overflow: hidden;
  text-align: start;

  .el-alert {
    position: fixed;
    transition: all 0.5s ease 0.5s;
    width: 60%;
    opacity: 0;
    right: 100px;
    top: -60px;
    display: flex;
  }

  .el-alert.showAlert {
    top: 60px;
    opacity: 1;
  }

  #productDialog {
    
    min-width: 1500px;
    
    .explainImgContainer{
      display:flex;
      padding: 0;
      margin-top: 10px;
      li{
        width: 60px;
        height: 60px;
        display: flex;
        overflow: hidden;
        border: #9b9b9b 1px solid;
        img{
          min-width: 60px;
        }
      }
      li:hover{
        transform: scale(1.5);
      }
    }
    /deep/.el-dialog__body {
      padding-top: 0px;

      .el-card__body {
        padding-top: 0px;
      }
    }
  }

  .productContainer {
    margin: 0 auto;
    margin-bottom: 50px;
    margin-top: 15px;
    background-color: rgb(225, 223, 223);
    // min-height: 92%;
    // max-height: 92%;
    min-height: 80%;
    max-height: 80%;
    // overflow: hidden;
    display: flex;
    flex-wrap: wrap; /* 允许换行 */
    justify-content: space-around;
    // align-items:start;
    .el-card {
      // flex: 0 0 25%; 
      align-self: flex-start;
      display: inline-block;
      position: relative;
      width: 20%;
      // min-width: 240px;
      // max-width: 300px;
      // min-width: 250px;
      height: 270px;
      padding-top: 0%;
      margin: 10px 20px;
      background-color: #fff;
      margin-bottom: 5px;
      //   border: transparent 2px solid;
      vertical-align: top;


      .container-left {
        display: inline-block;
        cursor: pointer;
        width: 75%;
        border: 1px rgba(97, 94, 94, 0.3) solid;
        overflow: hidden;

        .coverContainer {
          width: 100%;
          height: 180px;
          overflow: hidden;
          position: relative;

          .image {
            position: absolute;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
            margin: auto;
            display: block;
            // margin:  auto;
            // display: inline-block;
          }
        }

        .item-title {
          display: -webkit-box;
          -webkit-line-clamp: 2;
          -webkit-box-orient: vertical;
          height: 40px;
          overflow: hidden;
          //   text-align: center;
          vertical-align: center;
          box-sizing: border-box;
          padding-left: 5px;

          span {
            line-height: 20px;
          }
        }



        .item-price {
          .bi-heart-fill {
            margin: 0;
            padding: 0;
            padding-left: 10px;
            font-size: 20px;
            color: red;
          }

          .newPrice {
            color: #c40c0c;
            font-size: 24px;
            padding-left: 5px;
          }


          .prePrice {
            padding-left: 10px;
            color: #9b9b9b;
            font-size: 14px;
            text-decoration: line-through;
          }
        }

        .item-sales {
          border-top: 1px #f2f2f2 solid;
          height: 30px;
          text-align: right;

          span {
            padding-right: 10px;
            line-height: 40px;
            font-size: 12px;
            color: #9b9b9b;
          }
        }
      }

      .container-right {
        // border: 1px red solid;
        display: inline-block;
        width: 25%;
        margin-top: 0;
        vertical-align: top;
        text-align: center;

        .saleState {
          cursor: default;
        }

        .el-button {
          font-size: small;
          margin: 0 auto;
          padding: 12px 5px;
          display: block;
        }

        .el-button:not(.saleState) {
          margin: 10px auto;
        }

        .saleState {
          position: absolute;
          width: 25%;
          bottom: 1px;
          right: 1px;
        }
      }
    }

    .goods{
      background-color: rgba(244, 240, 229, 0.2);
    }
    .goods:hover {
      border-color: rgb(12, 252, 244);
      transform: scale(1.01, 1.01);
    }
  }

  .editMenu {
    .el-form-item {
      margin: 10px 0;
      position: relative;
      margin-top: 18px;

      /deep/.el-form-item__error {
        position: absolute;
        top: -14px;
        left: 90px;
        padding-top: 0px;
      }

      .chooseImageFile {
        display: inline-block;
        width: 60px;
        height: 100%;
        margin-left: 5px;
        background-color: rgba(44, 47, 50, 0.9);
        text-align: center;
        border-radius: 10px;
        // border: 2px blue solid;
        color: #ffffff;
        cursor: pointer;
        user-select: none;
      }

      .chooseImageFile:active {
        background-color: rgb(6, 6, 6);
      }

      .showCoverImg {
        width: 100px;
        height: 100px;
        position: absolute;
        right: -15px;
        top: 5px;
        background-color: red;
        transform: scale(1);
        transition: all ease 0.6s;
        z-index: 99;
        cursor: zoom-in; // crosshair
      }

      .showCoverImg:hover {
        transform: scale(3);
        right: 80px;
        border: 1px rgba(21, 244, 244, 0.35) solid
      }
    }
  }

  //  .el-card__body{
  //     padding: 0px;
  //   }

  .selectPageContainer {
    width: 100%;
    max-width: 1500px;
    min-width: 700px;
    height: 40px;
    position: absolute;

    bottom: 30px;

    // background: rgba(18, 229, 224, 0.3);
    background: rgba(83, 56, 56, 0.09);
    line-height: 40px;
    text-align: center;

    .el-button {
      padding: 5px;
      font-size: 14px;
    }

    .choosePage {
      display: inline-block;
      list-style: none;

      li {
        display: inline-block;
        margin: 0 5px;
        height: 20px;
        padding: 0 5px;
        line-height: 20px;
        background-color: rgba(82, 82, 82, 0.6);
        cursor: pointer;
      }

      li:hover {
        background-color: red;
      }
    }

    .goPageNumberInput {
      margin-left: 10px;
      height: 30px;
      text-align: center;
    }
  }
}

.bc_blue {
  background-color: blue;
}

.bc_gray {
  background-color: #9b9b9b;
}

.bc_green {
  background-color: rgba(5, 170, 19, 0.8);
}

.selectPageContainer .choosePage li.currentPage {
  background-color: yellow;
}

.no-select {
  -webkit-user-select: none;
  /* Safari */
  -moz-user-select: none;
  /* Firefox */
  -ms-user-select: none;
  /* IE 10+ */
  user-select: none;
}

textarea::placeholder {
  color: red;
}

// .placeholderLineHeight::first-line{
//   line-height: 40px;
// vertical-align: bottom;
// }
</style>
<style lang="less">
.el-textarea .el-input__count {
  right: 20px;
}
</style>