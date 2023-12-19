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

package com.bskf.modules.cases.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.ImmutableMap;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * 书籍
 *
 * @author Mark jstarseven@163.com
 * @since 1.2.0 2016-11-28
 */
@TableName("t_book_info")
@lombok.Setter
@lombok.Getter
public class BookInfoEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 任务id
     */
//    @TableId
    private String pid;
    private String name;
    private String xx;
    private String zz;
    private String zy;
    private int version;
    private int pn;
    private int wn;
    private int bsize;
    private String paper;
    private String mark;
    private int tjrq;
    private String imgw;

    private String content;
    private Integer status;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date ptime;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date ct;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date ut;
    @TableField(exist = false)
    private double tjd = 0d;

    public List InitValueList() {
        return new ArrayList() {{
            add(ImmutableMap.builder().put("column", "name").put("comment", "书籍名称").put("value", isNull(name)).build());
            add(ImmutableMap.builder().put("column", "imgw").put("comment", "图片").put("value", isNull(imgw)).build());
            add(ImmutableMap.builder().put("column", "xx").put("comment", "学校").put("value", isNull(xx)).build());
            add(ImmutableMap.builder().put("column", "zz").put("comment", "作者").put("value", isNull(zz)).build());
            add(ImmutableMap.builder().put("column", "zy").put("comment", "专业").put("value", isNull(zy)).build());
            add(ImmutableMap.builder().put("column", "version").put("comment", "版本").put("value", isNull(version)).build());
            add(ImmutableMap.builder().put("column", "pn").put("comment", "页数").put("value", isNull(pn)).build());
            add(ImmutableMap.builder().put("column", "wn").put("comment", "字数").put("value", isNull(wn)).build());
            add(ImmutableMap.builder().put("column", "bsize").put("comment", "书页大小").put("value", isNull(bsize)).build());
            add(ImmutableMap.builder().put("column", "paper").put("comment", "格式").put("value", isNull(paper)).build());
            add(ImmutableMap.builder().put("column", "mark").put("comment", "简介").put("value", isNull(mark)).build());
            add(ImmutableMap.builder().put("column", "tjrq").put("comment", "推荐人气").put("value", isNull(tjrq)).build());
            add(ImmutableMap.builder().put("column", "ptime").put("comment", "发表时间").put("value", isNull(ptime)).build());
            add(ImmutableMap.builder().put("column", "content").put("comment", "内容").put("value", isNull(content)).build());
        }};
    }

    public Object isNull(Object p) {
        if (Objects.isNull(p)) return "";
        return p;
    }
}
