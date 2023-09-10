import * as echarts from "echarts";
import moment, { months } from "moment/moment";
import axios from "axios";
import {getNewUserRegistCount} from "../api/index"
//导出柱状图 bar1
export function bar1(chartDom){
    var myChart = echarts.init(chartDom);
    var option;
    let targetDate=new Date()
    let preDate=new Date(targetDate)


   let day4= moment(new Date(targetDate).setDate(targetDate.getDate()-4)).format("YYYY-MM-DD")
   let day3=moment(new Date(targetDate).setDate(targetDate.getDate()-3)).format("YYYY-MM-DD")
   let day2=moment(new Date(targetDate).setDate(targetDate.getDate()-2)).format("YYYY-MM-DD")
   let day1=moment(new Date(targetDate).setDate(targetDate.getDate()-1)).format("YYYY-MM-DD")
   let day0=moment(targetDate).format("YYYY-MM-DD")

     function dataFactory(day){
    return  getNewUserRegistCount(day)
   }

   let arrData

   (async ()=>{
    arrData=await Promise.all([getNewUserRegistCount(day4),
                               getNewUserRegistCount(day3),
                               getNewUserRegistCount(day2),
                               getNewUserRegistCount(day1),
                               getNewUserRegistCount(day0)])

arrData=arrData.map((item)=>{return item.data.results[0].count})

    option = {
      title:{
        text:"新增用户("+targetDate.getFullYear()+")",
       textStyle:{
        fontSize:"15"
       } 
      },
      xAxis: {
        type: 'category',
        data: [ 
                day4.slice(-5),
                day3.slice(-5),
                day2.slice(-5),
                day1.slice(-5),
                day0.slice(-5),
                ]
      },
      yAxis: {
        type: 'value'
      },
      //设置图形与边界的距离
      grid:{
        top:"50px",
        bottom:"50px",
        right:"10px"
      },
      series: [
        {
          data: arrData,
          type: 'bar',
          showBackground: true,
          backgroundStyle: {
            color: 'rgba(180, 180, 180, 0.2)'
          },
        }
      ]
    };

    option && myChart.setOption(option);
   })()
   
  

    }

    





    
//导出柱状图 bar2
export function bar2(chartDom){
    var app = {};
    var myChart = echarts.init(chartDom);
    var option;
    
    const posList = [
      'left',
      'right',
      'top',
      'bottom',
      'inside',
      'insideTop',
      'insideLeft',
      'insideRight',
      'insideBottom',
      'insideTopLeft',
      'insideTopRight',
      'insideBottomLeft',
      'insideBottomRight'
    ];
    app.configParameters = {
      rotate: {
        min: -90,
        max: 90
      },
      align: {
        options: {
          left: 'left',
          center: 'center',
          right: 'right'
        }
      },
      verticalAlign: {
        options: {
          top: 'top',
          middle: 'middle',
          bottom: 'bottom'
        }
      },
      position: {
        options: posList.reduce(function (map, pos) {
          map[pos] = pos;
          return map;
        }, {})
      },
      distance: {
        min: 0,
        max: 100
      }
    };
    app.config = {
      rotate: 90,
      align: 'left',
      verticalAlign: 'middle',
      position: 'insideBottom',
      distance: 15,
      onChange: function () {
        const labelOption = {
          rotate: app.config.rotate,
          align: app.config.align,
          verticalAlign: app.config.verticalAlign,
          position: app.config.position,
          distance: app.config.distance
        };
        myChart.setOption({
          series: [
            {
              label: labelOption
            },
            {
              label: labelOption
            },
            {
              label: labelOption
            },
            {
              label: labelOption
            }
          ]
        });
      }
    };
    const labelOption = {
      show: true,
      position: app.config.position,
      distance: app.config.distance,
      align: app.config.align,
      verticalAlign: app.config.verticalAlign,
      rotate: app.config.rotate,
      formatter: '{c}  {name|{a}}',
      fontSize: 16,
      rich: {
        name: {}
      }
    };
    option = {
      tooltip: {
        trigger: 'axis',
        axisPointer: {
          type: 'shadow'
        }
      },
      legend: {
        data: ['Forest', 'Steppe', 'Desert', 'Wetland']
      },
      toolbox: {
        show: true,
        orient: 'vertical',
        left: 'right',
        top: 'center',
        feature: {
          mark: { show: true },
          dataView: { show: true, readOnly: false },
          magicType: { show: true, type: ['line', 'bar', 'stack'] },
          restore: { show: true },
          saveAsImage: { show: true }
        }
      },
      xAxis: [
        {
          type: 'category',
          axisTick: { show: false },
          data: ['2012', '2013', '2014', '2015', '2016']
        }
      ],
      yAxis: [
        {
          type: 'value'
        }
      ],
      series: [
        {
          name: 'Forest',
          type: 'bar',
          barGap: 0,
          label: labelOption,
          emphasis: {
            focus: 'series'
          },
          data: [320, 332, 301, 334, 390]
        },
        {
          name: 'Steppe',
          type: 'bar',
          label: labelOption,
          emphasis: {
            focus: 'series'
          },
          data: [220, 182, 191, 234, 290]
        },
        {
          name: 'Desert',
          type: 'bar',
          label: labelOption,
          emphasis: {
            focus: 'series'
          },
          data: [150, 232, 201, 154, 190]
        },
        {
          name: 'Wetland',
          type: 'bar',
          label: labelOption,
          emphasis: {
            focus: 'series'
          },
          data: [98, 77, 101, 99, 40]
        }
      ]
    };
    
    option && myChart.setOption(option);
    
}
//导出饼状图 pie1
export function pie1(chartDom){
    var myChart = echarts.init(chartDom);
    var option;
    option = {
        title: {
        //   text: 'Referer of a Website',
          // subtext: 'Fake Data',
          text:"用户分布",
          // left: 'center'
        },
        grid:{
            right:"3px"
        },
        tooltip: {
          trigger: 'item'
        },
        // legend: {
        //   orient: 'vertical',
        //   left: 'left'
        // },
        series: [
          {
            name: '人员分布',
            type: 'pie',
         
            data: [
              { value: 1048, name: '四川' },
              { value: 735, name: '广东' },
              { value: 484, name: '深圳' },
              { value: 300, name: '北京' },
              { value: 580, name: '其他' },
            ],
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      };
      option && myChart.setOption(option);
}

