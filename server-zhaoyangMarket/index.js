const express = require("express")
const bodyParser = require("body-parser")
const cors = require("cors")
const acceptImage = require("./tools/acceptImage")
const port = 4561  //前端访问后端的这个端口
const App = express()
//解决post请求的请求体为空的问题
App.use(bodyParser.json())
App.use(bodyParser.urlencoded({
    extended: false
}))
//解决跨域问题
App.use(cors());

//获取到数据库的连接对象
const MySqlConnection = require("./tools/getMySqlConnection.js");
//获取到multer的实例对象
const upload = require("./tools/getMulterInstance.js");
const fs = require('fs');
const sharp = require("sharp")
const path = require("path")
// 通用回调函数
function commonCallback(req, res, info) {
    return (err, results, fields) => {
        if (err) {
            res.send({
                theStatus: false,
                message: info + "失败！",
                results: [],
                errorInfo: err
            })
            console.log(info + "失败啦啦啦！！！")
            console.log("**************************Error**************************start")
            console.log(err)
            console.log("**************************Error**************************end")
         return ;
        } else {
            res.send({
                theStatus: true,
                message: info + "成功！",
                results: results,
                successInfo: results.info ? results.info : ""
            })
        }
    }

}
//增加商品
App.post("/insert/InsertProduct", (req, res) => {
    let reqBody = req.body
    let keys = Object.keys(reqBody)
    let values = Object.values(reqBody)
    let keysStr = ""
    let valuesStr = ""
    //组装product()内的sql语句
    keys.forEach((key) => {
        keysStr += key + ","
        valuesStr += "?,"
    })
    if (keysStr.endsWith(",")) {
        keysStr = keysStr.slice(0, -1)
    }
    if (valuesStr.endsWith(",")) {
        valuesStr = valuesStr.slice(0, -1)
    }

    console.log("-------------")
    console.log("INSERT into product(" + keysStr + ")" + "  values(" + valuesStr + ")")
    MySqlConnection.query("INSERT into product(" + keysStr + ")" + "  values(" + valuesStr + ")", values, commonCallback(req, res, "商品添加"))
})

//下架商品
App.post("/delete/deleteProduct", (req, res) => {
    if (req.body["id"]) {

        MySqlConnection.query("DELETE from product WHERE id=?", req.body["id"], commonCallback(req, res, "商品下架"))
    }
})

//更新商品
App.post("/update/updateProduct", (req, res) => {
    let reqBody = req.body

    let keys = Object.keys(reqBody)
    let valueArray = [] //这里面存的是除了id的其他字段
    let fieldsStr = "";
    let id = ""
    keys.forEach((key) => {
        //将非id的字段拼接成sql语句的格式
        if (key != "id" && key != "already_sale") {
            fieldsStr += key + "=?,"
            valueArray.push(reqBody[key])
        } else {
            if (key == "id") id = reqBody[key]

        }
    })

    //去掉最后一个,
    if (fieldsStr.endsWith(",")) {
        fieldsStr = fieldsStr.slice(0, -1)
    }
    console.log("-----------")
    console.log("UPDATE product set " + fieldsStr + " WHERE " + "id=" + id)
    if (valueArray.length > 0) {
        MySqlConnection.query("UPDATE product set " + fieldsStr + " WHERE " + "id=?", [...valueArray, id], commonCallback(req, res, "商品修改"))
    }

})

//查询下一页
App.post("/query/selectNextPage", (req, res) => {
    let reqBody = req.body
    MySqlConnection.query("SELECT * from product LIMIT ?,?", [reqBody.lowerLimit, reqBody.pageProductCount], commonCallback(req, res, "查询一页商品"))

})


// 查询商品总量
App.all("/query/selectAllCount", (req, res) => {
    MySqlConnection.query("SELECT COUNT(*) from product", commonCallback(req, res, "查询全部商品数量"))
})

//搜索商品
App.post("/query/productSearch", (req, res) => {
    let reqBody = req.body

    if (reqBody.title && reqBody.category_id) {
        MySqlConnection.query("SELECT * from product WHERE category_id=? AND title like ? ", [reqBody.category_id, "%" + reqBody.title + "%"], commonCallback(req, res, "搜索相关商品"))
    } else if (reqBody.category_id) {
        MySqlConnection.query("select * from product where category_id=?", reqBody.category_id, commonCallback(req, res, "搜索相关商品"))
    } else if (reqBody.title) {
        MySqlConnection.query("select * from product where title like ?", "%" + reqBody.title + "%", commonCallback(req, res, "搜索相关商品"))
    }
})

App.post("/query/productIdSearch", (req, res) => {
    let reqBody = req.body
    MySqlConnection.query("select * from product where id=" + reqBody.id, commonCallback(req, res, "查询某件商品"))
})
//----------------------用户-----------------------
//添加用户
App.post("/insert/addUser", (req, res) => {
    let reqBody = req.body
    let keys = Object.keys(reqBody)
    let values = Object.values(reqBody)
    let keysStr = ""
    let valuesStr = ""
    // let valueArray=[]
    //组装product()内的sql语句
    keys.forEach((key) => {
        keysStr += key + ","
        valuesStr += "?,"
    })
    if (keysStr.endsWith(",")) {
        keysStr = keysStr.slice(0, -1)
    }
    if (valuesStr.endsWith(",")) {
        valuesStr = valuesStr.slice(0, -1)
    }

    console.log("-------------")
    console.log("INSERT into user(" + keysStr + ")" + "  values(" + valuesStr + ")")
    MySqlConnection.query("INSERT into user(" + keysStr + ")" + "  values(" + valuesStr + ")", values, commonCallback(req, res, "添加用户"))
})
//删除用户
App.post("/delete/deleteUser", (req, res) => {
    console.log(req.body)
    if (req.body["username"]) {

        MySqlConnection.query("DELETE from user WHERE username=?", req.body["username"], commonCallback(req, res, "删除用户"))
    }
})
//更新用户
App.post("/update/updateUser", (req, res) => {
    let reqBody = req.body
    let keys = Object.keys(reqBody)
    let valueArray = [] //这里面存的是除了username的其他字段
    let fieldsStr = "";
    let username = ""
    keys.forEach((key) => {
        //将非username的字段拼接成sql语句的格式
        if (key != "username") {
            fieldsStr += key + "=?,"
            valueArray.push(reqBody[key])
        } else {
            if (key == "username") username = reqBody[key]

        }
    })

    //去掉最后一个,
    if (fieldsStr.endsWith(",")) {
        fieldsStr = fieldsStr.slice(0, -1)
    }
    // console.log("-----------")
    console.log("UPDATE user set " + fieldsStr + " WHERE " + "username=" + username)
    if (valueArray.length > 0) {
        MySqlConnection.query("UPDATE user set " + fieldsStr + " WHERE " + "username=?", [...valueArray, username], commonCallback(req, res, "修改用户"))
    }

})

//查询一页用户
App.post("/query/selectNextUserPage", (req, res) => {
    let reqBody = req.body
    MySqlConnection.query("SELECT * from user LIMIT ?,?", [reqBody.lowerLimit, reqBody.pageUserCount], commonCallback(req, res, "查询一页用户"))

    // console.log(reqBody.lowerLimit, reqBody.pageUserCount)
})
//查询用户
App.post("/query/selectUser", (req, res) => {
    let reqBody = req.body
    MySqlConnection.query("SELECT * from user where username = ? ", [reqBody.username], commonCallback(req, res, "查询用户"))
    // console.log(reqBody.username)
})
//模糊查询，查询用户
App.post("/query/searchUser", (req, res) => {
    let reqBody = req.body
    MySqlConnection.query("SELECT * from user where username like ? or nick_name like ? ", [reqBody.searchName, "%" + reqBody.searchName + "%"], commonCallback(req, res, "搜寻用户"))

})
//查询用户总量
App.get("/query/selectAllUserCount", (req, res) => {
    MySqlConnection.query("SELECT COUNT(*) FROM user", commonCallback(req, res, "查询用户总量"))
})

//查询商品种类信息
App.get("/query/selectCategory", (req, res) => {
    MySqlConnection.query("SELECT * FROM category", commonCallback(req, res, "查询商品种类"))
})

//查询用户最近上线情况
App.post("/query/numberOfOnline", (req, res) => {
    MySqlConnection.query("select * from user where latelyOnline_date=?", req.body.searchDay, commonCallback(req, res, "查询" + req.body.searchDay + "上线的用户"))
})

//查询某日期注册人数
App.post("/query/newUserRegistCount", (req, res) => {
   
    MySqlConnection.query("select COUNT(*) AS count from user where registration_date=?", req.body.searchDay, commonCallback(req, res, "查询" + req.body.searchDay + "注册的用户"))
})

//管理员账号登录验证
App.post("/query/administratorLoginCheck", (req, res) => {
    MySqlConnection.query("select * from administrator where username=? and password=?", [req.body.username, req.body.password],
        (err, results) => {

            if (results.length <= 0) {
                res.send({
                    theStatus: false,
                    message:"管理员登录验证失败！",
                    results: [],
                    errorInfo: err
                })
                return;
            }
            MySqlConnection.query("update administrator set lastOnline_date=?,currentOnline_date=? where username=? and password=?",
                [results[0].currentOnline_date, req.body.currentOnline_date, req.body.username, req.body.password],
                (err, results2) => {
                    if (err) {
                        console.log(err)
                        return ;
                    }
                    MySqlConnection.query("select * from administrator where username=? and password=?", [req.body.username, req.body.password], commonCallback(req, res, "管理员登录验证"))
                })

        })



})


//-------------------------------------------------------------------------------


// 指定包含图片的文件夹路径
const imagesFolder = path.join(__dirname, 'resource/');
// 使用 Express 的静态文件中间件来提供静态文件访问功能
App.use(express.static(imagesFolder));



//上传封面图片
App.post("/upload/coverImg", upload.single("coverImg"), async (req, res) => {
    // console.log(__dirname)
    let result = await acceptImage(req.file, "./resource/", req.body.id, "coverImg", 3145728)
    let resultObj = {
        status: true,
        message: result ? "图像上传成功" : "图像上传失败",
        imgUrl: result
    }
    res.send(resultObj)
})

//上传说明图片
App.post("/upload/explainImg", upload.array("explainImg", 8), async (req, res) => {

    let explainImgArray = []
    for (let i = 0; i < req.files.length; i++) {
        explainImgArray.push(await acceptImage(req.files[i], "./resource/", req.body.id, "explainImg" + i, 3145728))

    }

    let resultObj = {}
    if (explainImgArray.length > 0) {
        resultObj.status = true
        resultObj.message = "图像上传成功"
        resultObj.imgUrls = JSON.stringify(explainImgArray)
    } else {
        resultObj.status = false
        resultObj.message = "图像上传失败"
        resultObj.imgUrls = JSON.stringify(explainImgArray)
    }
    res.send(resultObj)

})


App.listen(port, () => {
    console.log(port + "端口正在被监听！")
})