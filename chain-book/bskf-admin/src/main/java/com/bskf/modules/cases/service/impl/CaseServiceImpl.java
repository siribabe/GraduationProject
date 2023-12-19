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
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bskf.common.utils.Constant;
import com.bskf.common.utils.PageUtils;
import com.bskf.common.utils.Query;
import com.bskf.modules.cases.dao.CaseDao;
import com.bskf.modules.cases.entity.BookInfoEntity;
import com.bskf.modules.cases.entity.JyInfoEntity;
import com.bskf.modules.cases.service.CaseService;
import com.bskf.modules.cases.utils.Cosine;
import com.bskf.modules.cases.utils.ListCF;
import com.bskf.modules.cases.utils.Md5Utils;
import com.bskf.modules.sys.entity.SysUserEntity;
import com.bskf.modules.sys.shiro.ShiroUtils;
import com.google.common.collect.Lists;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service("caseService")
public class CaseServiceImpl extends ServiceImpl<CaseDao, BookInfoEntity> implements CaseService {

    @Autowired
    private JdbcTemplate template;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String beanName = (String) params.get("paramKey");
        String type = (String) params.get("type");
        String orderField = "ct";
        boolean isAcs = false;
        if ("rm".equals(type)) {
            orderField = "tjrq";
            isAcs = false;
        } else if ("tj".equals(type)) {
            Page<BookInfoEntity> page = findSimilarUserBook(params);
            if (null != page && CollectionUtils.isNotEmpty(page.getRecords())) {
                return new PageUtils(page);
            }
        }
        Page<BookInfoEntity> page = this.selectPage(
                new Query<BookInfoEntity>(params).getPage(),
                new EntityWrapper<BookInfoEntity>().setSqlSelect("pid", "name", "xx", "zz", "zy", "version", "pn", "wn", "bsize", "paper", "mark", "tjrq", "ptime", "imgw")
                        .eq("status", 1)
                        .like(StringUtils.isNotBlank(beanName), "name", beanName)
                        .orderBy(orderField, isAcs)
                        .addFilterIfNeed(params.get(Constant.SQL_FILTER) != null, (String) params.get(Constant.SQL_FILTER))
        );
        if (StringUtils.isNotEmpty(beanName)) {
            page.getRecords().stream().forEach(item -> {
                item.setName(item.getName().replace(beanName, "<span style='color: #ef0000'>" + beanName + "</span>"));
            });
        }
        return new PageUtils(page);
    }

    /**
     * 根据kmean算法，内容相似判定推荐
     *
     * @param params
     * @return
     */
    private Page<BookInfoEntity> findSimilarUserBook(Map<String, Object> params) {

        String beanName = (String) params.get("paramKey");
        String wid = (String) params.get("wid");
        Wrapper<BookInfoEntity> qw = new EntityWrapper<BookInfoEntity>()
                .setSqlSelect("pid", "name", "xx", "zz", "zy", "version", "pn", "wn", "bsize", "paper", "mark", "tjrq", "ptime", "imgw", "content").eq("status", 1);
        String matchText;
        if (StringUtils.isNotEmpty(wid) && !"null".equalsIgnoreCase(wid)) {//基于文章内容推荐
            BookInfoEntity entity = selectBookInfo(wid);
            if (null == entity) return null;
            matchText = entity.getContent();
            qw.ne("pid", wid);
        } else {//基于关键词推荐
            matchText = beanName;
            qw.like(StringUtils.isNotBlank(matchText), "name", matchText);
        }
        String finalMatchText = matchText;
        if (StringUtils.isEmpty(finalMatchText)) return null;
        List<BookInfoEntity> books = this.selectList(qw);
        List<CompletableFuture<BookInfoEntity>> collect = books.stream().map(item -> CompletableFuture.supplyAsync(() -> {
            double similarity = Cosine.getSimilarity(finalMatchText, item.getContent());
            item.setTjd(Double.valueOf(String.format("%.3f", similarity)));
            return item;
        }, executorPool)).collect(Collectors.toList());
        List<BookInfoEntity> resultList = collect.stream().map(c -> c.join()).sorted((o1, o2) -> {
            Double tjd1 = o1.getTjd();
            Double tjd2 = o2.getTjd();
            return tjd2.compareTo(tjd1);
        }).filter(it -> it.getTjd() > 0).collect(Collectors.toList());

        Page<BookInfoEntity> page = new Page<>();
        Integer limit = Integer.valueOf((String) params.get("limit"));
        Integer cpage = Integer.valueOf((String) params.get("page"));
        List<List<BookInfoEntity>> blists = ListCF.subList(resultList, limit);
        page.setRecords(cpage > blists.size() ? Lists.newArrayList() : blists.get(cpage - 1));
        page.setTotal(resultList.size());
        page.setSize(limit);
        page.setCurrent(cpage);
        if (StringUtils.isNotEmpty(beanName)) {
            page.getRecords().stream().forEach(item -> item.setName(item.getName().replace(beanName, "<span style='color: #ef0000'>" + beanName + "</span>")));
        }
        return page;
    }

    @Override
    public void save(BookInfoEntity book) {
        book.setCt(new Date());
        book.setUt(new Date());
        book.setPid(Md5Utils.GetMD5Code(book.getName()));
        book.setPtime(book.getPtime());
        this.insert(book);
        String zy = book.getZy();
        if (StringUtils.isNotBlank(zy)) {
            String[] split = zy.split(",");
            Arrays.stream(split).forEach(item -> template.update("insert ignore into t_book_lx (name) values('" + item + "')"));
        }
    }

    @Override
    public void update(BookInfoEntity scheduleJob) {
//        this.updateById(scheduleJob);
        this.update(scheduleJob, new EntityWrapper<BookInfoEntity>().eq("pid", scheduleJob.getPid()));
    }

    @Override
    public void deleteBatch(String[] jobIds) {
//        this.deleteBatchIds(Arrays.asList(jobIds));
        Arrays.stream(jobIds).forEach(pid -> this.delete(new EntityWrapper<BookInfoEntity>().eq("pid", pid)));

    }

    @Override
    public int updateBatch(String[] jobIds, int status) {
        return this.updateBatch(jobIds, status);
    }

    @Override
    public List<BookInfoEntity> queryMapList(Map<String, Object> params) {
        return this.selectList(new EntityWrapper<BookInfoEntity>().setSqlSelect("pid", "name", "xx", "zz", "zy", "version", "pn", "wn", "bsize", "paper", "mark", "tjrq", "ptime", "imgw", "content")
                .eq("status", 1)
                .addFilterIfNeed(params.get(Constant.SQL_FILTER) != null, (String) params.get(Constant.SQL_FILTER)));
    }

    @Override
    public BookInfoEntity selectBookInfo(String jobId) {
        return this.selectOne(new EntityWrapper<BookInfoEntity>().setSqlSelect("pid", "name", "xx", "zz", "zy", "version", "pn", "wn", "bsize", "paper", "mark", "tjrq", "ptime", "imgw", "content")
                .eq("status", 1)
                .eq("pid", jobId));
    }

    @Override
    public void borrow(String[] jobIds) {
        SysUserEntity user = ShiroUtils.getUserEntity();
        Arrays.stream(jobIds).forEach(item -> {
            template.update("insert ignore into t_book_bow (bid,uid,back) values('" + item + "'," + user.getUserId() + ",0)");
        });

    }

    @Override
    public void backbook(Long[] jobIds) {
        Arrays.stream(jobIds).forEach(item -> {
            template.update("update t_book_bow set back=1 where id=" + item);
        });
    }

    @Override
    public PageUtils queryBowPage(Map<String, Object> params) {
        String beanName = (String) params.get("paramKey");
        SysUserEntity user = ShiroUtils.getUserEntity();
        String sql = "SELECT t.* ,p.id,p.back from t_book_info t,t_book_bow p where t.pid=p.bid and p.uid=" + user.getUserId();
        if (StringUtils.isNotEmpty(beanName)) {
            sql += " and t.name like '%" + beanName + "%'";
        }
        List<JyInfoEntity> query = exeSqlJyBook(sql);
        Page<JyInfoEntity> page = new Page<>();
        page.setRecords(query);
        page.setTotal(query.size());
        page.setSize(Integer.valueOf((String) params.get("limit")));
        page.setCurrent(Integer.valueOf((String) params.get("page")));
        if (StringUtils.isNotEmpty(beanName)) {
            page.getRecords().stream().forEach(item -> item.setName(item.getName().replace(beanName, "<span style='color: #ef0000'>" + beanName + "</span>")));
        }
        return new PageUtils(page);
    }

    private List<JyInfoEntity> exeSqlJyBook(String sql) {
        List<JyInfoEntity> query = template.query(sql, (RowMapper) (resultSet, i) -> {
            JyInfoEntity entity = new JyInfoEntity();
            entity.setId(resultSet.getLong("id"));
            entity.setBack(resultSet.getLong("back"));
            entity.setZy(resultSet.getString("zy"));
            entity.setName(resultSet.getString("name"));
            entity.setMark(resultSet.getString("mark"));
            entity.setZz(resultSet.getString("zz"));
            entity.setXx(resultSet.getString("xx"));
            entity.setPtime(resultSet.getDate("ptime"));
            return entity;
        });
        return query;
    }

    private List<BookInfoEntity> exeSqlBook(String sql) {
        List<BookInfoEntity> query = template.query(sql, (RowMapper) (resultSet, i) -> {
            BookInfoEntity entity = new BookInfoEntity();
            entity.setPid(resultSet.getString("pid"));
            entity.setName(resultSet.getString("name"));
            entity.setMark(resultSet.getString("mark"));
            entity.setZz(resultSet.getString("zz"));
            entity.setZy(resultSet.getString("zy"));
            entity.setXx(resultSet.getString("xx"));
            entity.setTjrq(resultSet.getInt("tjrq"));
            entity.setCt(resultSet.getDate("ct"));
            return entity;
        });
        return query;
    }

    // 线程池大小
    private int poolsize = 10;
    // 线程池
    ThreadPoolExecutor executorPool = new ThreadPoolExecutor(poolsize, poolsize * 2, 10, TimeUnit.SECONDS,
            new ArrayBlockingQueue<>(poolsize / 1), new ThreadPoolExecutor.CallerRunsPolicy());

}
