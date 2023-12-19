/**
 * Copyright 2023 基于区块链技术的图书管理系统
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package com.bskf.modules.cases.controller;

import com.bskf.common.annotation.SysLog;
import com.bskf.common.utils.PageUtils;
import com.bskf.common.utils.R;
import com.bskf.common.validator.ValidatorUtils;
import com.bskf.modules.cases.entity.BookInfoEntity;
import com.bskf.modules.cases.entity.CaseAggEntity;
import com.bskf.modules.cases.service.CaseLxService;
import com.bskf.modules.cases.service.CaseService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author Mark jstarseven@163.com
 * @since 1.2.0 2016-11-28
 */
@RestController
@RequestMapping("/data/cases")
public class CaseController {

    @Autowired
    private CaseService caseService;

    @Autowired
    private CaseLxService caseLxService;

    /**
     * 日期聚合数据
     *
     * @return
     */
    @RequestMapping("/agg")
//    @RequiresPermissions("data:cases:agg")
    public R agg(@RequestParam Map<String, Object> map) {
        //查询列表数据
        List<CaseAggEntity> list = caseLxService.queryAgg(map);
        String[] cate = new String[list.size()];
        int[] serial = new int[list.size()];
        int index = 0;
        for (int i = list.size() - 1; i >= 0; i--) {
            cate[index] = list.get(i).getcKey();
            serial[index] = list.get(i).getcValue();
            index++;
        }
        String type = (String) map.get("type");
        String showname = "数量", ctype = "bar";
        if (StringUtils.isEmpty(type)) {
            showname = "数量";
        } else if (("jyrd".equals(type))) {
            showname = "借阅次数";
            ctype = "line";
        }
        JSONArray cate_json = JSONArray.fromObject(cate);
        JSONArray serial_json = JSONArray.fromObject(serial);
        JsonObject option = new JsonParser().parse("{\n" +
                "    title : {text: ''},\n" +
                "    tooltip : {trigger: 'axis'},\n" +
                "    toolbox: { show : true,\n" +
                "        feature : {\n" +
                "            dataView : {show: true, readOnly: false},\n" +
                "            magicType : {show: true, type: ['line', 'bar']},\n" +
                "            restore : {show: true},\n" +
                "            saveAsImage : {show: true}\n" +
                "        }\n" +
                "    },\n" +
                "    calculable : true,\n" +
                "    color: ['#c23531','#2f4554', '#61a0a8']," +
                "    xAxis : [ { axisLabel:{interval:0,rotate:40},type : 'category', data : " + cate_json.toString() + " } ],\n" +
                "    yAxis : [ { type : 'value' } ],\n" +
                "    series :[{ name:'" + showname + "',type:'" + ctype + "',\n" +
                "                                itemStyle:{\n" +
                "                                    normal:{\n" +
                "                                        color:'#4ad2ff'\n" +
                "                                    }\n" +
                "                                },label:{normal:{show:true}},\n" +
                "                data:" + serial_json.toString() + ",\n" +
                "                markLine : {data : [{type : 'average', name: '平均值'}]}\n" +
                "            }]\n" +
                "}").getAsJsonObject();
        JSONObject option_json = JSONObject.fromObject(option.toString());
        return R.ok().put("option", option_json);
    }


    /**
     * 关系聚合数据
     *
     * @return
     */
    @RequestMapping("/maps")
//    @RequiresPermissions("data:cases:agg")
    public R maps(@RequestParam Map<String, Object> map) {
        List<BookInfoEntity> books = caseService.queryMapList(map);
        Map<String, List<BookInfoEntity>> sMap = books.stream().collect(Collectors.groupingBy(s -> s.getZy()));
        Map<String, Integer> cIndex = Maps.newHashMap();
        List cas = Lists.newArrayList(), nodes = Lists.newArrayList(), links = Lists.newArrayList();
        List<String> smap = sMap.keySet().stream().collect(Collectors.toList());
        nodes.add(new HashMap() {{
            put("name", "区块链图书馆");
            put("value", 1);
            put("category", 0);
        }});
        for (int i = 0; i < smap.size(); i++) {
            int finalI = i;
            cas.add(new HashMap() {{
                put("name", smap.get(finalI));
            }});
            cIndex.put(smap.get(finalI), i);
            nodes.add(new HashMap() {{
                put("name", smap.get(finalI));
                put("value", 1);
                put("category", finalI);
            }});
            links.add(new HashMap() {{
                put("source", 0);
                put("target", finalI + 1);
            }});
        }
        int start = nodes.size();
        List<HashMap> nos = books.stream().map(n -> new HashMap() {{
            put("name", n.getName());
            put("value", n.getTjrq());
            put("category", cIndex.get(n.getZy()));
        }}).collect(Collectors.toList());
        nodes.addAll(nos);
        for (int p = start; p < nodes.size(); p++) {
            HashMap o = (HashMap) nodes.get(p);
            int finalP = p;
            links.add(new HashMap() {{
                put("source", finalP);
                put("target", (Integer) o.get("category") + 1);
            }});
        }
        return R.ok().put("nodes", nodes).put("links", links).put("categories", cas);
    }

    /**
     * 列表
     */
    @RequestMapping("/mlist")
//	@RequiresPermissions("data:caseInfo:list_lx")
    public R mlist(@RequestParam Map<String, Object> params) {
        List<BookInfoEntity> list = caseService.queryMapList(params);

        return R.ok().put("list", list);
    }


    //------------------------------------------轮胎信息------------------------------------------

    /**
     * 列表
     */
    @RequestMapping("/list")
//	@RequiresPermissions("data:caseInfo:list_lx")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = caseService.queryPage(params);

        return R.ok().put("page", page);
    }

    /**
     * 保存
     */
    @SysLog("保存")
    @RequestMapping("/save")
    @RequiresPermissions("data:cases:save")
    public R save(@RequestBody BookInfoEntity caseInfoJob) {
        ValidatorUtils.validateEntity(caseInfoJob);

        caseService.save(caseInfoJob);

        return R.ok();
    }

    /**
     * 修改
     */
    @SysLog("修改")
    @RequestMapping("/update")
    @RequiresPermissions("data:cases:update")
    public R update(@RequestBody BookInfoEntity caseInfoJob) {
        ValidatorUtils.validateEntity(caseInfoJob);

        caseService.update(caseInfoJob);

        return R.ok();
    }

    /**
     * 删除
     */
    @SysLog("删除")
    @RequestMapping("/delete")
    @RequiresPermissions("data:cases:delete")
    public R delete(@RequestBody String[] jobIds) {
        caseService.deleteBatch(jobIds);
        return R.ok();
    }

    /**
     * 列表
     */
    @RequestMapping("/borrow_list")
//	@RequiresPermissions("data:caseInfo:list_lx")
    public R borrow_list(@RequestParam Map<String, Object> params) {
        PageUtils page = caseService.queryBowPage(params);

        return R.ok().put("page", page);
    }

    /**
     * 借书
     */
    @SysLog("借书")
    @RequestMapping("/borrow")
//    @RequiresPermissions("data:caseInfo:delete_lx")
    public R borrow(@RequestBody String[] jobIds) {
        caseService.borrow(jobIds);
        return R.ok();
    }

    /**
     * 还书
     */
    @SysLog("还书")
    @RequestMapping("/backbook")
//    @RequiresPermissions("data:caseInfo:delete_lx")
    public R backbook(@RequestBody Long[] jobIds) {
        caseService.backbook(jobIds);
        return R.ok();
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{type}/{id}")
//	@RequiresPermissions("data:caseInfo:info")
    public R info(@PathVariable("type") String type, @PathVariable("id") String jobId) {
        BookInfoEntity caseInfo = caseService.selectBookInfo(jobId);
        return R.ok().put("list", "y".equals(type) ? caseInfo.InitValueList() : caseInfo);
    }

}
