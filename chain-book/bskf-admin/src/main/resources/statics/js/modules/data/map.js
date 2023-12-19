var dom = document.getElementById("chart");
var myChart = echarts.init(dom);
var app = {};
var option;

$.get(baseURL + 'data/cases/maps', {tableName: T.p('tableName')}, function (res) {
    option = {
        legend: [{
            data: res.categories,
            textStyle: {
                color: '#00FAE1'
            }
        }],
        series: [{
            type: 'graph',
            layout: 'force',
            legendHoverLink: true, //是否启用图例 hover(悬停) 时的联动高亮。
            hoverAnimation: true, //是否开启鼠标悬停节点的显示动画
            edgeSymbol: ['arrow', ''],
            force: {
                edgeLength: 120,
                repulsion: 500
            },
            roam: true,
            draggable: true,//每个节点的拖拉
            itemStyle: {
                normal: {
                    // color:'#00FAE1',
                    cursor: 'pointer',
                    label: {
                        show: true,
                        position: [-10, -15],
                        textStyle: { //标签的字体样式
                            color: '#00FAE1', //字体颜色
                            fontStyle: 'normal',//文字字体的风格 'normal'标准 'italic'斜体 'oblique' 倾斜
                            fontWeight: 'bolder',//'normal'标准'bold'粗的'bolder'更粗的'lighter'更细的或100 | 200 | 300 | 400...
                            fontFamily: 'sans-serif', //文字的字体系列
                            fontSize: 12, //字体大小
                        }
                    },
                    nodeStyle: {
                        brushType: "both",
                        borderColor: "rgba(255,215,0,0.4)",
                        borderWidth: 1,
                    },
                },
                //鼠标放上去有阴影效果
                emphasis: {
                    shadowColor: '#00FAE1',
                    shadowOffsetX: 0,
                    shadowOffsetY: 0,
                    shadowBlur: 40,
                },
            },
            lineStyle: {
                width: 2,
            },
            label: {
                color: '#00FAE1',
                fontSize: 18,
            },
            symbolSize: 14,//节点大小
            cursor: 'pointer',
            categories: res.categories,
            data: res.nodes.map(function (node, idx) {
                node.id = idx;
                return node;
            }),
            edges: res.links
        }]
    };

    myChart.setOption(option);

    if (option && typeof option === 'object') {
        myChart.setOption(option);
    }
})
