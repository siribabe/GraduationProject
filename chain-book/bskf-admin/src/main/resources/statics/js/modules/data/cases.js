$(function () {
    // $("#jqGrid").jqGrid({
    //
    //     url: baseURL + 'data/cases/list_lx',
    //     datatype: "json",
    //     colModel: [
    //         {label: 'id', name: 'id', width: 40, key: true},
    //         {
    //             label: '产品类型', name: 'name', width: 160, formatter: function (cellvalue, options, rowObject) {
    //                 return "<a target=\"_self\" href=\"cplist.html?id=" + options.rowId + "\" >" + cellvalue + "</a>";
    //             }
    //         },
    //         {label: '类型描述', name: 'mark', width: 160},
    //         {label: '创建时间', name: 'ct', width: 70}
    //     ],
    //     viewrecords: true,
    //     height: 370,
    //     rowNum: 10,
    //     rowList: [10, 30, 50],
    //     rownumbers: true,
    //     rownumWidth: 25,
    //     autowidth: true,
    //     multiselect: true,
    //     pager: "#jqGridPager",
    //     jsonReader: {
    //         root: "page.list",
    //         page: "page.currPage",
    //         total: "page.totalPage",
    //         records: "page.totalCount"
    //     },
    //     prmNames: {
    //         page: "page",
    //         rows: "limit",
    //         order: "order"
    //     },
    //     gridComplete: function () {
    //         //隐藏grid底部滚动条
    //         $("#jqGrid").closest(".ui-jqgrid-bdiv").css({"overflow-x": "hidden"});
    //     }
    // });
});
var vm = new Vue({
    el: '#rrapp',
    data: {
        q: {
            key: null
        },
        option: {},
        datasum: 0
    },
    methods: {
        query: function () {
            vm.reload();
        },
        reload: function (event) {
            var page = $("#jqGrid").jqGrid('getGridParam', 'page');
            $("#jqGrid").jqGrid('setGridParam', {
                postData: {'key': vm.q.key},
                page: page
            }).trigger("reloadGrid");
        }
    },
    mounted() {

    }
});