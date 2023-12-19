package com.bskf.modules.job.task;

import com.bskf.modules.sys.entity.SysUserEntity;
import com.bskf.modules.sys.service.SysUserService;
import com.bskf.modules.sys.entity.SysUserEntity;
import com.bskf.modules.sys.service.SysUserService;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * pingduoduo脚本
 * <p>
 * PDDTask
 *
 * 女装：http://www.pinduoduo.com/category/girlshoes.html
 * 男装：http://www.pinduoduo.com/category/boyshirt.html
 * 女装：http://www.pinduoduo.com/category/food.html
 * 女装：http://www.pinduoduo.com/category/girlshoes.html
 * 女装：http://www.pinduoduo.com/category/girlshoes.html
 * 女装：http://www.pinduoduo.com/category/girlshoes.html
 *
 * @author Mark
 * @since 1.2.0 2016-11-28
 */
@Component("PDDTask")
public class PDDTask {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private SysUserService sysUserService;

    public void test(String params) {
        logger.info("我是带参数的test方法，正在被执行，参数为：" + params);

        try {
            Thread.sleep(1000L);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        SysUserEntity user = sysUserService.selectById(1L);
        System.out.println(ToStringBuilder.reflectionToString(user));

    }


    public void test2() {
        logger.info("我是不带参数的test2方法，正在被执行");
    }
}
