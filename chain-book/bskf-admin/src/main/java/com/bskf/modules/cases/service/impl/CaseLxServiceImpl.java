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

package com.bskf.modules.cases.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bskf.common.utils.Constant;
import com.bskf.common.utils.PageUtils;
import com.bskf.common.utils.Query;
import com.bskf.modules.cases.dao.CaseLxDao;
import com.bskf.modules.cases.entity.CaseAggEntity;
import com.bskf.modules.cases.entity.CplxEntity;
import com.bskf.modules.cases.service.CaseLxService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("caseLxService")
public class CaseLxServiceImpl extends ServiceImpl<CaseLxDao, CplxEntity> implements CaseLxService {

    @Autowired
    private JdbcTemplate template;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<CplxEntity> page = this.selectPage(
                new Query<CplxEntity>(params).getPage(),
                new EntityWrapper<CplxEntity>()
                        .eq("status", 1)
                        .addFilterIfNeed(params.get(Constant.SQL_FILTER) != null, (String) params.get(Constant.SQL_FILTER))
        );
        return new PageUtils(page);
    }

    @Override
    public void save(CplxEntity scheduleJob) {

    }

    @Override
    public void update(CplxEntity scheduleJob) {

    }

    @Override
    public void deleteBatch(Long[] jobIds) {

    }

    @Override
    public int updateBatch(Long[] jobIds, int status) {
        return 0;
    }

    @Override
    public void run(Long[] jobIds) {

    }

    @Override
    public void pause(Long[] jobIds) {

    }

    @Override
    public void resume(Long[] jobIds) {

    }

    @Override
    public List<CaseAggEntity> queryAgg(Map<String, Object> map) {
        String type = (String) map.get("type");
        String sql = "SELECT t.`zy` AS cKey, count(*) AS cValue FROM t_book_info t WHERE t.status=1 GROUP BY cKey ORDER BY cKey DESC";
        if ("jyrd".equals(type)) {
            sql = "SELECT p.`name` cKey,count(1) cValue from t_book_bow t LEFT JOIN t_book_info p on t.bid=p.pid GROUP BY p.`name` ORDER BY cValue DESC limit 20";
        }
        List query = template.query(sql, (RowMapper) (resultSet, i) -> {
            CaseAggEntity entity = new CaseAggEntity();
            entity.setcKey(resultSet.getString("cKey"));
            entity.setcValue(Integer.valueOf(resultSet.getString("cValue")));
            return entity;
        });
        return query;
    }
}
