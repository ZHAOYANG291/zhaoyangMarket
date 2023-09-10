import Vue from 'vue'
import Vuex from 'vuex'
import tab from './modules/tab'
Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    currentPath:{path:"#/home"},
    searchProducts:null,
    ifSearchModel:false,
    theme:""
  },
  getters: {
  },
  mutations: {
   setSearchProducts(state,searResults){
state.searchProducts=searResults
   },
   setIfSearchModel(state,value){
    state.ifSearchModel=value
   },
   setTheme(state,value){
    state.theme=value
   }
  },
  actions: {
    updateCurrentPath(state,value){
      state.currentPath=value
     }
  },
  modules: {
    tab
  }
})
