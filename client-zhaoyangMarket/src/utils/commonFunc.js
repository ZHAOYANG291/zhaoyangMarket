  
 const commonFunc= {
    //获取下一页商品的通用函数
      getNextPageCommonFunc(extraFun) {
          return () => {
              this.lowerLimit = (this.pageNumber - 1) * this.pageProductCount;
              this.$http
                  .post(
                      "/query/selectNextPage", {
                          lowerLimit: this.lowerLimit,
                          pageProductCount: this.pageProductCount,
                      }, {
                          timeout: 1000,
                      }
                  )
                  .then((res) => {
                      this.allProducts = res.data.results;
                      this.paginationFrontTemp = Array.from(this.paginationFront);
                      this.paginationBackTemp = Array.from(this.paginationBack);
                      if (this.pageTotalNumber <= 10) {
                          //如果页数总数小于等于10，那么就只需要用paginationFront就能存下这些页面了
                          // for (let i = 0; i < this.pageTotalNumber; i++) {
                          //   this.paginationFront[i] = i + 1;
                          // }
                      } else if (this.pageTotalNumber > 10) {
                          //如果页数的总数大于10，那么就需要用两个数组，即paginationFront和paginationBack来存这些页面了
                          if (this.paginationFront.indexOf(this.pageNumber) != -1 || this.pageNumber < this.paginationBack[0]) {
                              //如果这个页码是在paginationFront里面找到的，那么就走这条分支

                              if (this.pageNumber >= 3) {
                                  //如果页码大于等于3那么我们就需要动态地决定在paginationFront中存下哪5个页面
                                  if (this.pageNumber < this.paginationBack[0] - 2) {
                                      //如果页码是小于paginationBack[0]-2，那么我们就需要动态决定paginationFront的页面
                                      this.paginationFront[0] = this.pageNumber - 2;
                                      this.paginationFront[1] = this.pageNumber - 1;
                                      this.paginationFront[2] = this.pageNumber;
                                      this.paginationFront[3] = this.pageNumber + 1;
                                      this.paginationFront[4] = this.pageNumber + 2;
                                  } else if (this.pageNumber >= this.paginationBack[0] - 2) {
                                      //如果页码大于等于paginationBack[0]-2,那么我们就只需要从paginationBack[0]往前面数五个固定的页面来作为paginationFront的5个页面
                                      this.paginationFront[0] = this.paginationBack[0] - 5;
                                      this.paginationFront[1] = this.paginationBack[0] - 4;
                                      this.paginationFront[2] = this.paginationBack[0] - 3;
                                      this.paginationFront[3] = this.paginationBack[0] - 2;
                                      this.paginationFront[4] = this.paginationBack[0] - 1;
                                  }
                              } else if (this.pageNumber < 3) {
                                  //如果当前页码小于3，那么我们也只需要在paginationFront，以页码为1-5的五个固定页面作为其页面了
                                  for (let i = 0; i < 5; i++) {
                                      this.paginationFront[i] = i + 1;
                                  }
                              }
                          } else if (this.paginationBack.indexOf(this.pageNumber) != -1) {
                              // console.log(this.paginationBack)
                              if (this.pageNumber <= this.pageTotalNumber - 2) {
                                  if (this.pageNumber > this.paginationFront[4] + 2) {
                                      this.paginationBack[0] = this.pageNumber - 2;
                                      this.paginationBack[1] = this.pageNumber - 1;
                                      this.paginationBack[2] = this.pageNumber;
                                      this.paginationBack[3] = this.pageNumber + 1;
                                      this.paginationBack[4] = this.pageNumber + 2;
                                  } else if (this.pageNumber >= this.paginationFront[4] + 2) {
                                      this.paginationBack[0] = this.paginationFront[4] + 1;
                                      this.paginationBack[1] = this.paginationFront[4] + 2;
                                      this.paginationBack[2] = this.paginationFront[4] + 3;
                                      this.paginationBack[3] = this.paginationFront[4] + 4;
                                      this.paginationBack[4] = this.paginationFront[4] + 5;
                                  }
                              } else {
                                  for (let i = 0; i < 5; i++) {
                                      this.paginationBack[i] = this.pageTotalNumber - 4 + i;
                                  }
                              }
                          }



                      }
                  })
                  .catch((err) => {
                      if (typeof extraFun == "function") {
                          extraFun();
                          console.log("获取页面信息失败");
                          alert("Oops！！服务器响应超时，可能是网络出问题咯");
                      }
                      //如果获取页面信息失败，则返回之前的页码
                      this.paginationFront = Array.from(this.paginationFrontTemp);
                      this.paginationBack = Array.from(this.paginationBackTemp);
                  });
          };
      },
      //promise的.catch里面的公共复用函数
      commonErrorFunc(err) {
          this.sqlAlert = "error";
          console.log(err.res.data.message, err.res.data.successInfo);
      },
      //promise的.then里面的公共复用resolve函数
      commonResolveFunc(extraCode) {
          return (res) => {
              //如果执行状态正确，就在控制台打印消息
              if (res.data.theStatus) {
                  if (typeof extraCode == "function") extraCode();

                  // console.log(res.data.message, res.data.successInfo);
                  this.sqlAlert = "success";
                  setTimeout(() => {
                      this.sqlAlert = "";
                  }, 1500);
              } else {
                  //如果执行状态错误，就抛出异常
                  let err = new Error("出错啦！！");
                  err.res = res;
                  throw err;
              }
          };
      },
      //promise的.then里面的公共复用reject函数
      commonRejectFunc(rej) {
          alert("请求失败，可能是因为网络异常或者服务器崩溃");
          console.log(rej);
      }


  }

  export default commonFunc