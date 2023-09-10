const fs = require('fs');
const sharp = require('sharp');
const path = require("path")
module.exports= async  function acceptImage(file,directoryName,productId,fileName,fileMaxsize){
    //file 接收到的文件
    //directoryName 要存入的目录文件夹路径
    //productId  商品id
    //fileName 要存入的文件名
    //fileMaxsize 图片最大储存值，超过就压缩
    
       let imgUrl=""
    
           let fileSuffix=file.originalname.split(/[.]+/).pop()  //图片后缀名
        
            
            if (file && productId) {
               
                
                    imgUrl=`http://127.0.0.1:4561/${productId}/${fileName}.${fileSuffix}`
                
                if(file.size>fileMaxsize){//图片大于3MB的话就压缩存储
                    let options={ //sharp的options
                        quality:30
                    }
                    if(!fs.existsSync(directoryName + productId)){
                        fs.mkdir(directoryName+productId,(err)=>{
                             if(err){
                                console.log(err)
                                return "";
                             }
                        })
                    }
                    //设置一个标志
                    var  flag=false;
                    if(fileSuffix=="jpg" || fileSuffix=="jpeg"){
                      await  sharp(file.path).jpeg(options).toFile(`${directoryName}${productId}/${fileName}.${fileSuffix}`).then(()=>flag=true)
                    }else if(fileSuffix=="png"){
                      await  sharp(file.path).png(options).toFile(`${directoryName}${productId}/${fileName}.${fileSuffix}`).then(()=>flag=true)
                    }else if(fileSuffix=="gif"){
                       await sharp(file.path).gif(options).toFile(`${directoryName}${productId}/${fileName}.${fileSuffix}`).then(()=>flag=true)
                    }
                    
                    if(flag){
                        return imgUrl
                    }else{
                        return ""
                    }
                    
                }else{//否则就正常存储
               
                    if (fs.existsSync(directoryName + productId)) {//商品对应的文件夹已经存在了
                        console.log("文件夹已存在")
                        fs.renameSync(file.path, `${directoryName}${productId}/${fileName}.${fileSuffix}`)
                        return imgUrl
                    } else {//商品对应的文件夹不存在
                        fs.mkdir(directoryName + productId, (err) => {
                            if (err) {
                                console.log(err)
                                return ""
                            } else {
                                console.log("创建成功！")
                                fs.renameSync(file.path, `${directoryName}${productId}/${fileName}.${fileSuffix}`)
                                return imgUrl
                            }
                        })
                    }
        
                }
               
            }else{
               
                return ""
            }
    
        }