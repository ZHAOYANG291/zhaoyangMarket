const mysql2=require("mysql2")
const connection=mysql2.createConnection({
    host:"127.0.0.1",
    port:3306,
    database:"ZhaoYangMarket",
    user:"root",
    password:"123456",
})

connection.connect(function(err){
    if (err) {
        console.error('error connecting (连接失败): ' + err.stack);
        return;
      }
      console.log('connected as id (连接成功啦) ' + connection.threadId);
})

module.exports=connection