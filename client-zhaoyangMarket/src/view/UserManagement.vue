<template>
  <div>
    <div class="header">
      <el-button type="primary" @click="dialogVisible = true">+新增</el-button>
      <div class="searchContainer">
        <input type="text" class="searchInput" v-model="searchName"  @keydown.enter="searchUser">
        <div class="searchButton" @click="searchUser">搜索</div>
        <button @click="showAllUser" class="showAllUserButton">查看全部</button>
      </div>
    </div>

    <el-dialog title="提示" :visible.sync="dialogVisible" width="50%"  style="min-width: 500px; max-width: 1500px;margin:100px auto;" :before-close="beforeCloseHandler">
      <!-- 新增用户的表单信息 -->
      <el-form ref="currentForm" :model="currentForm" :show-message="showMessage" :rules="rules" label-width="100px">
        <el-form-item label="用户名" prop="username">
          <el-input v-model="currentForm.username" :disabled="usernameDisabled"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="currentForm.password"></el-input>
        </el-form-item>
        <el-form-item label="爱心数量" prop="heart">
          <el-input v-model="currentForm.heart"></el-input>
        </el-form-item>
        <el-form-item label="昵称" prop="nick_name">
          <el-input v-model="currentForm.nick_name"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="cancelHandler('currentForm')">取 消</el-button>
        <el-button type="primary" @click="confirmHandler('currentForm')">确 定</el-button>
      </span>
    </el-dialog>


<!-- 用户表单 -->
    <el-table :data="tableData" style="width: 100%;height: 540px;overflow-y: scroll;">
      <el-table-column label="用户名" width="240">
        <template slot-scope="scope">
          <span>{{ scope.row.username }}</span>
        </template>
      </el-table-column>
      <el-table-column label="密码" width="180">
        <template slot-scope="scope">
          <span>{{ scope.row.password }}</span>
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
      <el-table-column label="最近上线时间" width="180">
        <template slot-scope="scope">
          <span>{{ scope.row.latelyOnline_date }}</span>
        </template>
      </el-table-column>

      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
          <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="footer" style="padding-left: 800px;">
      <button @click="getPrePage">上一页</button>
      <span>{{ currentPageNumber }}/{{ totalUserPageNumber }}</span>
      <button @click="getNextPage">下一页</button>
    </div>

  </div>
</template>

<script>
import moment from 'moment';
export default {
  name: "Box",
  data() {
    var validateNotEmpty = function (rule, value, callback) {
      if (!value) {
        callback(new Error("不能为空！"));
      } else {
        callback();
      }
    };
    let exitValidator = {
      validator: async (rule, value, callback) => {
        await this.$http.post("/query/selectUser", { username: this.currentForm.username }).then(res => {
          console.log(res.data.results)
          if (res.data.results.length > 0) {
            callback(new Error("用户名已存在"))
          } else {
            callback()
          }
        })
      },
      trigger: "blur"
    }

    var validateName = function (rule, value, callback) {
      if (value.length > 20) callback(new Error("用户名应在20个字符以内)"));
      else callback();
    };
    let numberVilidator = {
      validator: (rule, value, callback) => {
      let num= Number(value)
        if (value) {
          if (isNaN(num) || num<0 || num>4294967295) {
            callback(new Error("必须为0~4294967295的数字"));
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
      usernameDisabled: false,
      searchName: "",
      dialogVisible: false,
      showMessage: true,
      editIndex: -1,
      lowerLimit: 0,
      pageUserCount: 9,
      allUserCount: 0,
      currentForm: {
        username: "",
        password: "",
        heart: "",
        nick_name: "",
      },
      tableData: [],
      rules: {
        username: [
          {
            required: true,
            validator: validateNotEmpty,
            message: "用户名不能为空",
            trigger: "blur",
            size: "large"
          },
          { validator: validateName, trigger: "blur", },
          exitValidator
        ],
        password: [{ required: true, message: "密码不能为空", trigger: "blur" },{min:1,max:20,message:"密码长度必须在20个字符以内",trigger:"blur"}],
        heart: [{ required: true, message: "爱心数量不能为空", trigger: "blur" }, numberVilidator],
        nick_name:[{min:1,max:15,message:"昵称必须在15个字符以内",trigger:"blur"}]
      },
    };
  },
  methods: {
    showAllUser() {
      this.$http.post("/query/selectNextUserPage", {
        lowerLimit: this.lowerLimit,
        pageUserCount: this.pageUserCount

      }).then(res => {
        this.tableData = res.data.results
        // console.log(this.tableData)
      })

      this.$http.get("/query/selectAllUserCount").then(res =>
        this.allUserCount = res.data.results[0]["COUNT(*)"]
      )
    },
    searchUser() {
      if (this.searchName) {
        this.$http.post("/query/searchUser", { searchName: this.searchName }).then((res) => {
          this.tableData = res.data.results
        })
      } else {
        this.showAllUser()
      }


    },
    handleEdit(index, row) {//进入编辑用户面板
      this.dialogVisible = true;
      this.editIndex = index;
      this.usernameDisabled = true;
      this.currentForm = { ...this.tableData[index] }
    },
    handleDelete(index, row) { //删除用户
      if (this.tableData[index].username) {
        this.$http.post("/delete/deleteUser", { username: this.tableData[index].username }).then(res => {
          console.log(res)
          if (res.data.theStatus) {
            //删除
            this.tableData.splice(index, 1);
          }
        })
      }



    },
    confirmHandler(formName) {
      this.$refs[formName].validate((ifvalid) => {
        if (ifvalid) {

          if (this.editIndex != -1 && this.usernameDisabled) {//编辑用户
            this.$http.post("/update/updateUser", this.currentForm).then(res => {
              if (res.data.theStatus) {
                console.log(this.editIndex)
                // this.tableDatap[this.editIndex]={...this.currentForm}
                this.$set(this.tableData, this.editIndex, {
                  ...this.currentForm
                });
              }
              //将编辑的index设置为-1
              this.editIndex = -1;
              this.usernameDisabled = false;
              console.log(this.usernameDisabled)
            })
          } else {//添加用户
         let registration_date=moment(Date.now()).format("YYYY-MM-DD")
         console.log(registration_date)
         this.currentForm.registration_date=registration_date
            this.$http.post("/insert/addUser", this.currentForm).then(res => {
              console.log(res)

              // this.tableData.push({
              //   ...this.currentForm,
              // });
              this.editIndex = -1;
              this.currentForm={}
            })
          }

          for (let key in this.form) {
            this.form[key] = "";
          }
          //关闭dialog 
          this.dialogVisible = false;

        } else {
          // this.showMessage = true
          alert("请按需求填写表单");
        }
      });
    },
    cancelHandler(formName) {
      this.dialogVisible = false;
      for (let key in this.currentForm) {
        this.currentForm[key] = "";
      }
      this.editIndex = -1;
      // this.showMessage = false
      this.usernameDisabled = false;
      this.$nextTick(() => {
        this.$refs[formName].clearValidate()
      })
    },
    beforeCloseHandler(done) {
      // console.log("关闭Dialog")
      this.cancelHandler("currentForm")
      done()
    },
    getPrePage() {
      if (this.lowerLimit > 0) {
        this.lowerLimit = this.lowerLimit - this.pageUserCount
        let obj = {
          lowerLimit: this.lowerLimit,
          pageUserCount: this.pageUserCount
        }
        this.$http.post("/query/selectNextUserPage", obj).then(res => {
          this.tableData = res.data.results
        })
      }

    },
    getNextPage() {
      if (this.lowerLimit + this.pageUserCount < this.allUserCount) {
        this.lowerLimit = this.lowerLimit + this.pageUserCount
        let obj = {
          lowerLimit: this.lowerLimit,
          pageUserCount: this.pageUserCount
        }
        this.$http.post("/query/selectNextUserPage", obj).then(res => {
          this.tableData = res.data.results
        })
      }


    }
  },
  computed: {
    currentPageNumber() {
      return Number(this.lowerLimit / this.pageUserCount) + 1
    },
    totalUserPageNumber() {
      return Math.ceil(Number(this.allUserCount / this.pageUserCount))
    }
  },
  mounted() {
    this.showAllUser()
  }
};
</script>

<style lang="less" scoped>
.header {
  display: flex;
  justify-content: flex-start;
  align-items: center;

  .el-button {
    height: 50px;
    font-size: 20px;
  }

  .searchContainer {
    width: 60%;
    margin-left: 50px;
    min-width: 600px;
    height: 80px;
    // background-color: aqua;
    display: flex;
    justify-content: flex-start;
    align-items: center;

    .searchInput {
      border: 0px;
      padding-left: 10px;
      border-radius: 5px;
      width: 60%;
      min-width: 300px;
      height: 40px;
      // background-color: black;
    }

    .searchButton {
      border-radius: 5px;
      cursor: pointer;
      width: 100px;
      height: 40px;
      line-height: 40px;
      text-align: center;
      font-size: 23px;
      font-weight: 500;
      background-color: aquamarine;
      user-select: none;
    }

    .showAllUserButton {
      height: 40px;
      font-size: large;
      margin-left: 10px;
      cursor: pointer;
      border-radius: 5PX;
      border:1px gray solid
    }
.showAllUserButton:active{
  background-color: yellow;
}
    .searchButton:active {
      background-color: yellow;
    }
  }

}

.el-form {
  margin: 0 auto;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  flex-wrap: wrap;
}

/deep/.el-form-item__label {
  padding: 0 0 0 15px;
  text-align: left;
}</style>
