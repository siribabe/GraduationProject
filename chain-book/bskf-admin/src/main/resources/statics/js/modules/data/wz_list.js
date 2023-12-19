$(function () {
    $("#jqGrid").jqGrid({
        url: baseURL + 'data/cases/list?type=' + T.p('type'),
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
            }, {
                label: '封面',
                name: 'imgw',
                title: false,
                width: 50,
                formatter: function (cellvalue, options, rowObject) {
                    return "<img src='/bskf-admin/statics/" + cellvalue + "'height=\"80\" width=\"65\"/>";
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
            {label: '页数', name: 'pn', width: 50},
            {label: '字数', name: 'wn', width: 50},
            {label: '发布时间', name: 'ptime', width: 50},
            {
                label: '相似推荐',
                name: 'name',
                sortable: false,
                width: 50,
                formatter: function (cellvalue, options, rowObject) {
                    return "<a target=\"_self\" href=\"xs_list.html?wid=" + options.rowId + "&type=tj\" >查看推荐</a>";
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

new AjaxUpload('#upload', {
    action: baseURL + "sys/oss/upload/book_img",
    name: 'file',
    autoSubmit: true,
    responseType: "json",
    onSubmit: function (file, extension) {
        if (!(extension && /^(jpg|jpeg|png|gif)$/.test(extension.toLowerCase()))) {
            alert('只支持jpg、png、gif格式的图片！');
            return false;
        }
    },
    onComplete: function (file, r) {
        if (r.code == 0) {
            alert("书籍图片上传成功！");
            // vm.reload();
            vm.config.imgw = r.url;
        } else {
            alert(r.msg);
        }
    }
});
