$(function () {
    $("#jqGrid").jqGrid({
        url: baseURL + 'data/cases/list?type=' + T.p('type') + '&wid=' + T.p('wid'),
        datatype: "json",
        colModel: [
            {
                label: '书籍名称',
                name: 'name',
                sortable: false,
                width: 260,
                formatter: function (cellvalue, options, rowObject) {
                    return "<a target=\"_self\" href=\"info.html?id=" + options.rowId + "\" >" + cellvalue + "</a>";
                }
            },
            {
                label: '简介', name: 'mark', width: 50,
                formatter: function (cellvalue, options, rowObject) {
                    var showv = cellvalue;
                    if (!isBlank(cellvalue) && cellvalue.length > 20) {
                        showv = cellvalue.substring(0, 20);
                    }
                    return showv;
                }
            },
            {label: '学校', name: 'xx', width: 50},
            {label: '专业', name: 'zz', width: 50},
            {label: '发布时间', name: 'ptime', width: 50},
            {
                label: '推荐度', name: 'tjd', width: 50,
                formatter: function (cellvalue, options, rowObject) {
                    var str = Number(cellvalue * 100).toFixed(1);
                    str += "%";
                    return str;
                }
            },
            {label: 'ID', name: 'pid', width: 50, key: true, hidden: true}
        ],
        viewrecords: true,
        height: 760,
        rowNum: 20,
        rowList: [20, 30, 40],
        rownumbers: true,
        rownumWidth: 25,
        autowidth: true,
        multiselect: true,
        pager: "#jqGridPager",
        jsonReader: {
            root: "page.list",
            page: "page.currPage",
            total: "page.totalPage",
            records: "page.totalCount"
        },
        prmNames: {
            page: "page",
            rows: "limit",
            order: "order"
        },
        gridComplete: function () {
            //隐藏grid底部滚动条
            $("#jqGrid").closest(".ui-jqgrid-bdiv").css({"overflow-x": "hidden"});
        }
    });
});

var vm = new Vue({
    el: '#rrapp',
    data: {
        q: {
            paramKey: null
        },
        showList: true,
        title: null,
        config: {}
    },
    methods: {
        query: function () {
            vm.reload();
        },
        borrow: function (event) {
            var ids = getSelectedRows();
            if (ids == null) {
                return;
            }

            confirm('确定要收藏选中的书籍？', function () {
                $.ajax({
                    type: "POST",
                    url: baseURL + "data/cases/borrow",
                    contentType: "application/json",
                    data: JSON.stringify(ids),
                    success: function (r) {
                        if (r.code == 0) {
                            alert('收藏成功', function (index) {
                                vm.reload();
                            });
                        } else {
                            alert(r.msg);
                        }
                    }
                });
            });
        },
        reload: function (event) {
            vm.showList = true;
            var page = $("#jqGrid").jqGrid('getGridParam', 'page');
            $("#jqGrid").jqGrid('setGridParam', {
                postData: {'paramKey': vm.q.paramKey},
                page: page
            }).trigger("reloadGrid");
        },
        back: function () {
            history.go(-1);
        }
    }
});