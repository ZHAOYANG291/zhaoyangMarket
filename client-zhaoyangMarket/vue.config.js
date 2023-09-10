const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  publicPath: process.env.NODE_ENV === 'production'
  ? 'E:/VScode_programfile/yq_CodeNote/Vue/案例/backstage-management-system/dist'
  : './',
  lintOnSave:false, //这个配置是开启/关闭eslint的语法校验
  publicPath: './',
})
