<template>
    <div class="container bkc-lightgray">
        <div class="backButton" @click="goBack" title="点击返回"> <i class="bi-chevron-double-left bkc-gray ftc-wite "></i></div>
        <!-- 商品id:{{productID}} -->


        <div class="content">
            <div class="content-left">
                <el-carousel :autoplay="false" trigger="click" height="600px">
                    <el-carousel-item v-for="item in image_urls" :key="item"
                        :style="{ background: ' url(' + item + ') 0px/100% auto  no-repeat' }">
                        <h3 class="medium"></h3>
                    </el-carousel-item>
                </el-carousel>
            </div>

            <div class="content-right">

                <div class="title">
                    <p><i>标题：</i>{{ this.product.title }}</p>
                </div>


                <hr>
                <div class="description">
                    <p><i>描述：</i>{{ this.product.description }}</p>
                </div>
                <hr>
                <div class="resource"><i>资源：</i>{{ this.product.resource }}</div>
                <hr>
                <div class="otherInformation">
                    <p><i>价格：</i> {{ this.product.new_price }}<i class="bi bi-heart-fill"
                            style="color: red; font-size: 16px;padding-left: 5px;"></i></p>
                    <p><i>商品创建时间：</i>{{ this.product.created_at }}</p>
                    <p><i>商品更新时间：</i>{{ this.product.updated_at }}</p>
                    <p><i>商品id：</i>{{ this.product.id }}</p>
                    <p><i>商品已售：</i>{{ this.product.already_sale }}</p>
                    <p><i>商品状态：</i>{{ this.product.on_sale == "1" ? "在售" : "停售" }}</p>
                    <p><i>商品已优先级：</i>{{ this.product.level }}</p>
                    <p><i>商品库存：</i>{{ this.product.stock_quantity }}</p>

                </div>
            </div>
        </div>


    </div>
</template>

<script>
import "../utils/commonFunc.js"
export default {
    name: "Box",
    data() {
        return {
            productID: "",
            product: "",
            image_urls: []
        }
    },
    methods: {
        goBack() {
            this.$router.back()
        }
    },
    mounted() {
        this.productID = this.$route.query.id
        this.$http.post("/query/productIdSearch", { id: this.productID }).then(res => {
            this.product = res.data.results[0]
            let explainImage_urls = []
            if (this.product.explainImage_urls) {
                explainImage_urls = JSON.parse(this.product.explainImage_urls)
            }
            this.image_urls.push(this.product.coverImage_url, ...explainImage_urls)

        }).catch(err => {
            console.log(err)
        })
    }
}
</script>

<style lang="less" scoped>
// @import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css");
@import "~bootstrap-icons/font/bootstrap-icons.css";

/deep/.el-carousel__button {
    background-color: rgba(0, 255, 247, 0.3);
    height: 10px;
}

/deep/.el-carousel__indicators {

    width: 500px;
    display: flex;
    justify-content: center;
}

/deep/.is-active {

    button {
        background-color: rgb(0, 183, 255);
    }
}

/deep/.el-carousel__arrow {
    i {
        font-size: 20px;
        font-weight: 900;
        color: rgb(0, 255, 229);
    }

}

.ftc-wite {
    color: aliceblue;
}

.bkc-gray {
    background-color: #475669;
}

.bkc-lightgray {
    background-color: rgba(157, 173, 194, 0.1);
}

.container {
    // cursor: pointer;
    min-width: 1400px;
overflow: hidden;
//  background-color: rgba(220, 224, 231, 0.4);
 background-color: rgba(229, 232, 232, 0.7);
// color: red;
    .content {
        display: flex;
        justify-content: flex-start;
        align-items: center;

        .content-left {
            width: 600px;
            height: 650px;
            min-height: 650px;
            margin: 0px 20px 0px;
            box-sizing: border-box;
            border: rgba(159, 156, 156, 0.8) 10px solid;
            // background-color: rgba(250, 235, 215, 0.2);
        }

        .content-right {
            height: 650px;
            min-height: 650px;
            width: 50%;
            border: rgba(57, 56, 56, 0.6) 3px solid;
            // color: rgb(250, 252, 254);
            font-weight: 500;

              i{
                color: #1e1e21;
                font-weight: 800;
                
              }
            .title {
              
                font-size: 17px;
                height: 100px;
                overflow: auto;
            }

            .description {
                height: 200px;
                overflow: auto;
            }

            .resource {
                height: 120px;
                overflow: auto;
            }

            .otherInformation {
                height: 180px;
                overflow: auto;
            }
        }
    }


    .el-carousel__item h3 {
        color: #475669;
        font-size: 14px;
        opacity: 0.75;
        line-height: 200px;
        margin: 0;
    }

    .el-carousel__item:nth-child(2n) {
        background-color: #99a9bf;
    }

    .el-carousel__item:nth-child(2n+1) {
        background-color: #d3dce6;
    }

    .backButton {
        // display: block;
        // height: 60px;
        width: 100px;
        text-align: center;
        margin: 20px 20px;
        border-radius: 5px;
        cursor: pointer;

        i {
            font-size: 30px;
            border-radius: 5px;
            padding: 0px 20px;
        }

    }

}</style>
