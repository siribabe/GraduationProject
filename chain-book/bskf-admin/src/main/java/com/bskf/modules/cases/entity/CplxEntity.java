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

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import jdk.nashorn.internal.objects.annotations.Getter;
import jdk.nashorn.internal.objects.annotations.Setter;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;

/**
 * 定时任务
 *
 * @author Mark jstarseven@163.com
 * @since 1.2.0 2016-11-28
 */
@TableName("t_cplx")
@lombok.Setter
@lombok.Getter
public class CplxEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 任务id
     */
    @TableId
    private Long id;

    /**
     * spring bean名称
     */
    @NotBlank(message = "bean名称不能为空")
    private String name;

    /**
     * 方法名
     */
    @NotBlank(message = "方法名称不能为空")
    private String mark;

    /**
     * 任务状态
     */
    private Integer status;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date ct;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date ut;
}
