/*
 * @file        地图相关
 * @DateTime    2018-04-05
 */

// var data = [
//     {
//         id: 0,
//         name: '玉米',
//         num: '100万斤',
//         text: '我是北京市',
//         img: 'https://p5.ssl.qhimg.com/d/inn/bdf6028f2530/bonus.png',
//         lng: 116.38,
//         lat: 39.92
//     },
//     {
//         id: 0,
//         name: '玉米',
//         num: '100万斤',
//         text: '我是北京市',
//         img: 'https://p5.ssl.qhimg.com/d/inn/bdf6028f2530/bonus.png',
//         lng: 117.06446,
//         lat: 39.974482
//     },
//     {
//         id: 0,
//         name: '玉米',
//         num: '100万斤',
//         text: '我是北京市',
//         img: 'https://p5.ssl.qhimg.com/d/inn/bdf6028f2530/bonus.png',
//         lng: 114.872692,
//         lat: 40.815362
//     },
//     {
//         id: 0,
//         name: '玉米',
//         num: '100万斤',
//         text: '我是北京市',
//         img: 'https://p5.ssl.qhimg.com/d/inn/bdf6028f2530/bonus.png',
//         lng: 116.679943,
//         lat: 39.514099
//     },
//     {
//         id: 0,
//         name: '玉米',
//         num: '100万斤',
//         text: '我是北京市',
//         img: 'https://p5.ssl.qhimg.com/d/inn/bdf6028f2530/bonus.png',
//         lng: 117.21278,
//         lat: 39.093291
//     },
//     {
//         id: 0,
//         name: '玉米',
//         num: '100万斤',
//         text: '我是北京市',
//         img: 'https://p5.ssl.qhimg.com/d/inn/bdf6028f2530/bonus.png',
//         lng: 115.960339,
//         lat: 39.497146
//     },
//     {
//         id: 0,
//         name: '玉米',
//         num: '100万斤',
//         text: '我是北京市',
//         img: 'https://p5.ssl.qhimg.com/d/inn/bdf6028f2530/bonus.png',
//         lng: 116.355847,
//         lat: 39.093291
//     }
// ];

const vm = new Vue({
    el: '#page',
    data: {
        map: null,
        // 详情弹框
        info: {
            html: '',
            style: '',
            show: false
        }
    },
    methods: {
        getMenuList() {
            $.getJSON("sys/menu/nav", function (r) {
                vm.menuList = r.menuList;
            });
        },
        // 点内容
        getTemplate(src) {
            return `<div style="width: 50px;"><img src="${src}" style="width:100%"/></div>`;
        },
        // 添加标记点
        addMarker(positionList) {
            const markers = [];
            positionList.forEach(v => {
                const obj = {
                    position: [v.lng, v.lat],
                    offset: new AMap.Pixel(-25, -50),
                    content: this.getTemplate(v.img),
                    title: '农产品',
                    zoom: 13,
                    clickable: true
                };
                const marker = new AMap.Marker(obj);
                marker.setAnimation('AMAP_ANIMATION_DROP');
                marker.params = v;
                marker.on('click', (e) => {
                    const { target, pixel } = e;
                    const { params } = target;
                    this.showInfo(pixel, params);
                });
                markers.push(marker);
            });
            this.map.add(markers);
        },
        // 显示详情弹框
        showInfo(pixel, params) {
            const html = `<p class="line">农作物：${params.name}</p><p class="line">产量：${params.num}</p><p class="line">介绍：${params.text}</p>`;
            const style = {
                top: `${pixel.y}px`,
                left: `${pixel.x + 50}px`
            };
            Object.assign(this.info, {
                html,
                style,
                show: true
            });
        },
        // 关闭详情弹框
        closeInfoMark() {
            Object.assign(this.info, {
                html: '',
                show: false
            });
        },
        initMap(position = []) {
            this.position = position;
            this.addMarker();
        }
    },
    mounted() {
        console.log('mounted');
    }
});
window.mapInit = () => {
    vm.map = new AMap.Map('mapContainer', {
        zoom: 8, // 地图缩放级别
        mapStyle: 'amap://styles/normal', // 设置地图的显示样式
        center: [116.397428, 39.90923], // 中心点坐标
        // viewMode: '3D', // 使用3D视图
        // pitch: 75, // 地图俯仰角度，有效范围 0 度- 83 度
        showBuildingBlock: true, // 3D楼块效果
    });
    console.log(vm.map);
    // // 异步加载插件
    // // AMap.plugin(['AMap.ToolBar', 'AMap.Geolocation'], () => {
    // //     const toolbar = new AMap.ToolBar();
    // //     map.addControl(toolbar); // 工具控件
    // //     map.addControl(new AMap.Geolocation()); // 定位
    // // });
    var nData=[];
    $.ajax({
        type: "POST",
        url: baseURL + 'data/cases/mlist',
        contentType: "application/json",
        data: "",
        async:false,
        success: function (r) {
            if (r.code == 0) {
                for(var k=0;k<r.list.length;k++){
                    var pItem={};
                    pItem.id=r.list[k].id;
                    pItem.name=r.list[k].name;
                    pItem.num=r.list[k].sl+r.list[k].dw;
                    if(r.list[k].mark.length>50){
                        pItem.text=r.list[k].mark.substring(0,50)+"...";
                    }else{
                        pItem.text=r.list[k].mark;
                    }
                    pItem.img=r.list[k].img;
                    pItem.lng=r.list[k].jd;
                    pItem.lat=r.list[k].wd;
                    nData.push(pItem);
                }
            } else {
                alert(r.msg);
            }
        }
    });
    vm.addMarker(nData);
    document.querySelector('.amap-logo').style.display = 'none';
    document.querySelector('.amap-copyright').remove();
};
