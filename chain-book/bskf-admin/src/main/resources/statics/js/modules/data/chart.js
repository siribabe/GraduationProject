var chart = new Vue({
    el: '#chart',
    methods: {
        a: function () {
            var myEchart = echarts.init(chart.$el);
            myEchart.setOption(this.option);
        }
    },
    mounted() {
        var that = this;
        $.get(baseURL + 'data/cases/agg', {type: T.p('type'), tableName: T.p('tableName')}, function (res) {
            that.option = res.option;
            that.$nextTick(function () {
                that.a();
            })
        })

    }
});
