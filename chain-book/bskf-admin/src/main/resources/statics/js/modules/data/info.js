$(function () {
    $("#jqGrid").jqGrid({
        url: baseURL + 'data/cases/info/y/' + T.p('id'),
        datatype: "json",
        colModel: [
            // {label: '列名', name: 'column', width: 40, key: true},
            {label: '备注', name: 'comment', width: 60, formatter: function (cellvalue, options, rowObject) {
                    return "<span style='color: #00c0ef'>" + cellvalue + "</span>";
                }},
            {
                label: '数据',
                name: 'value',
                title: false,
                width: 200,
                formatter: function (cellvalue, options, rowObject) {
                    if (rowObject.column == "imgw") {
                        return "<img src='/bskf-admin/statics/" + cellvalue + "'height=\"340\" width=\"300\"/>";
                    } else if (!isBlank(cellvalue) && cellvalue.length > 100) {
                        return "<div>" + cellvalue + "</div>";
                    } else {
                        return "<div title='" + cellvalue + "'>" + cellvalue + "</div>";
                    }
                }
            }
        ],
        viewrecords: true,
        height: '100%',
        rowNum: 40,
        rownumbers: true,
        rownumWidth: 25,
        autowidth: true,
        multiselect: false,
        pager: "#jqGridPager",
        jsonReader: {
            root: "list"
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
            key: null
        },
        option: {}
    },
    methods: {
        query: function () {
            $("#jqGrid").jqGrid('setGridParam', {
                postData: {'key': vm.q.key},
                page: 1
            }).trigger("reloadGrid");
        },
        back: function () {
            history.go(-1);
        }
    }
});