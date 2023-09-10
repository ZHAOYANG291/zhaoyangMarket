 const multer=require("multer")
 let storage= multer.diskStorage({
    destination: './resource/',
    filename:(req,file,callBack)=>{
       const originalname=Buffer.from(file.originalname,"latin1").toString("utf-8") //处理中文字符乱码
       file.originalname=originalname
        callBack(null,originalname)
    }
 })


 let upload=new multer({storage})
 module.exports=upload