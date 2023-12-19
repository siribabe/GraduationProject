$(function () {
    $("#jqGrid").jqGrid({
        url: baseURL + 'data/cases/borrow_list?id=' + T.p('id'),
        datatype: "json",
        colModel: [
            {label: 'ID', name: 'id', width: 50, key: true},
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
                label: '是否归还', name: 'back', width: 50, formatter: function (cellvalue, options, rowObject) {
                    if (cellvalue == 1) {
                        return "<span style='color: #ff4900'>已还</span>";
                    } else {
                        return "<span style='color：#00c0ef'>未还</span>";
                    }
                }
            }
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
var fileName;
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
        add: function () {
            vm.showList = false;
            vm.title = "新增";
            vm.config = {};
            vm.config.lxid = T.p('id');
        },
        update: function () {
            var id = getSelectedRow();
            if (id == null) {
                return;
            }

            $.get(baseURL + "data/cases/info/n/" + id, function (r) {
                vm.showList = false;
                vm.title = "修改";
                vm.config = r.list;
            });
        },
        del: function (event) {
            var ids = getSelectedRows();
            if (ids == null) {
                return;
            }

            confirm('确定要删除选中的书籍？', function () {
                $.ajax({
                    type: "POST",
                    url: baseURL + "data/cases/delete",
                    contentType: "application/json",
                    data: JSON.stringify(ids),
                    success: function (r) {
                        if (r.code == 0) {
                            alert('操作成功', function (index) {
                                vm.reload();
                            });
                        } else {
                            alert(r.msg);
                        }
                    }
                });
            });
        },
        backbook: function (event) {
            var ids = getSelectedRows();
            if (ids == null) {
                return;
            }

            confirm('确定要归还选中的书籍？', function () {
                $.ajax({
                    type: "POST",
                    url: baseURL + "data/cases/backbook",
                    contentType: "application/json",
                    data: JSON.stringify(ids),
                    success: function (r) {
                        if (r.code == 0) {
                            alert('还书成功', function (index) {
                                vm.reload();
                            });
                        } else {
                            alert(r.msg);
                        }
                    }
                });
            });
        },
        saveOrUpdate: function (event) {
            var url = vm.config.pid == null ? "data/cases/save" : "data/cases/update";
            $.ajax({
                type: "POST",
                url: baseURL + url,
                contentType: "application/json",
                data: JSON.stringify(vm.config),
                success: function (r) {
                    if (r.code === 0) {
                        alert('操作成功', function (index) {
                            vm.reload();
                        });
                    } else {
                        alert(r.msg);
                    }
                }
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