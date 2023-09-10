<template>
    <div class="container">

        <div class="background">

        </div>
        <div class="systemTitle">
            <p> <span>朝</span> 
                <span>阳</span>
                <span>市</span>
                <span>场</span>
                <span>——</span>
                <span>后</span>
                <span>台</span>
               </p>
        </div>
        <div class="content">
            <el-card class="box-card">
                <div class="inputContainer" @keydown.enter="doLogin">
                    <el-input v-model="username" placeholder="请输入账号"></el-input>
                    <el-input placeholder="请输入密码" v-model="password" show-password></el-input>
                </div>
                <div class="buttonContainer">
                    <el-button @click="doLogin" type="primary" round>登录</el-button>
                    <el-button type="primary" @click="clearInput" round>清空</el-button>
                </div>
            </el-card>
        </div>

    </div>
</template>

<script>
import { getAdministratorLoginCheck } from "../api/index.js"
import moment from "moment"

function sightWhithMouse(container, background) {

    //container 容器节点
    //background 背景图节点
    if (container && background) {
        container.style += "position:relative; perspective: 1000px; overflow: hidden;"
        background.style += "position: absolute; transform: translateZ(-1px) scale(1.2); transition: transform 1s cubic-bezier(0,1,0.8,1)  ;"

        container.addEventListener('mousemove', (e) => {
            e.stopPropagation()
            const xAxis = (window.innerWidth / 2 - e.pageX) / 15; // 调整 25 以控制视差效果的强度
            const yAxis = (window.innerHeight / 2 - e.pageY) / 15;

            background.style.transform = `translateZ(-1px) scale(1.1) translate(${xAxis}px, ${yAxis}px)`;
        });
    } else {
        return;
    }


}


export default {
    data() {
        return {
            username: "",
            password: ""
        }
    },
    methods: {
        doLogin() {
            if (this.username && this.password) {
                getAdministratorLoginCheck({ username: this.username, password: this.password, currentOnline_date: moment(new Date()).format("YYYY-MM-DD HH:mm:ss") }).then((res) => {

                    if (res.data.theStatus && res.data.results.length > 0) {
                        sessionStorage.setItem("loginState", true)
                        localStorage.setItem("username", res.data.results[0].username)
                        localStorage.setItem("nick_name", res.data.results[0].nick_name)
                        localStorage.setItem("level", res.data.results[0].level)
                        localStorage.setItem("headPortraitUrl", res.data.results[0].headPortraitUrl)
                        localStorage.setItem("lastOnline_date", res.data.results[0].lastOnline_date)
                        localStorage.setItem("currentOnline_date", res.data.results[0].currentOnline_date)

                        this.$router.push("/main/home")
                    } else {
                        alert("账号或密码不正确")
                        return;
                    }
                }).catch(err => console.log(err))
            } else {
                alert("账号密码不能为空")
                return;
            }

        },
        clearInput() {
            this.username = ""
            this.password = ""
        }
    },
    mounted() {
        // window.loginState=false
        //设置背景视角随着鼠标移动
        sightWhithMouse(document.querySelector(".container"), document.querySelector(".background"))
    }

}

</script>

<style lang="less" scoped>
.container {
    position: relative;
    width: 100vw;
    height: 100vh;
    min-width: 1400px;
    min-height: 700px;
    overflow: hidden;

    .background {
        width: 100%;
        height: 100%;
        background: url("../assets/loginBackGround.jpeg") no-repeat 0 0/100% auto;
    }

    .systemTitle {
        position: fixed;
        top: 12%;
        left: 50%;
        width: 300px;
        height: 100px;
        transform: translatex(-50%);

        p {
            user-select: none;
            font-size: 36px;
            text-align: center;
            // color: rgba(17, 219, 242,1);
            font-weight: 800;
            color: transparent;
            -webkit-text-stroke: 2px rgba(66, 65, 65, 0.8);
            text-stroke: 2px rgba(66, 65, 65, 0.8);
      
            span:hover {
                color: rgba(135,206,235,0.9);
                text-shadow: -1px -1px white,
                    1px 1px #333;
            }
        }
    }

    .content {

        position: fixed;
        width: 400px;
        height: 240px;
        top: 60%;
        left: 50%;
        transform: translate(-50%, -50%);
        // background-color: red;

        .el-card {
            border: 0;
        }

        .box-card {
            position: fixed;
            width: 400px;
            height: 240px;
            background-color: rgba(255, 254, 254, 0.4);
        }

        .inputContainer {
            margin: 0 auto;
            width: 220px;

            .el-input {
                margin: 10px 0;
            }
        }

        .buttonContainer {
            margin-top: 40px;
            width: 100%;
            display: flex;
            justify-content: space-around;

            .el-button {
                background-color: rgba(0, 255, 255, 0.3);
                color: rgb(32, 31, 31);
                font-weight: 700;
            }
        }

    }


}
</style>