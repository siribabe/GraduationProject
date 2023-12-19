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

package com.bskf.modules.cases.service;

import com.baomidou.mybatisplus.service.IService;
import com.bskf.common.utils.PageUtils;
import com.bskf.modules.cases.entity.BookInfoEntity;

import java.util.List;
import java.util.Map;

/**
 * 定时任务
 *
 * @author Mark jstarseven@163.com
 * @since 1.2.0 2016-11-28
 */
public interface CaseService extends IService<BookInfoEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 保存定时任务
     */
    void save(BookInfoEntity scheduleJob);

    /**
     * 更新定时任务
     */
    void update(BookInfoEntity scheduleJob);

    /**
     * 批量删除定时任务
     */
    void deleteBatch(String[] jobIds);

    /**
     * 批量更新定时任务状态
     */
    int updateBatch(String[] jobIds, int status);

    List<BookInfoEntity> queryMapList(Map<String, Object> params);

    BookInfoEntity selectBookInfo(String jobId);

    void borrow(String[] jobIds);

    void backbook(Long[] jobIds);

    PageUtils queryBowPage(Map<String, Object> params);
}
