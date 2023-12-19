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

package com.bskf.modules.oss.controller;

import com.bskf.common.utils.*;
import com.bskf.modules.cases.utils.Md5Utils;
import com.google.gson.Gson;
import com.bskf.common.exception.RRException;
import com.bskf.common.validator.ValidatorUtils;
import com.bskf.modules.sys.service.SysConfigService;
import com.bskf.common.validator.group.AliyunGroup;
import com.bskf.common.validator.group.QcloudGroup;
import com.bskf.common.validator.group.QiniuGroup;
import com.bskf.modules.oss.cloud.CloudStorageConfig;
import com.bskf.modules.oss.cloud.OSSFactory;
import com.bskf.modules.oss.entity.SysOssEntity;
import com.bskf.modules.oss.service.SysOssService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.Map;

/**
 * 文件上传
 *
 * @author jstarseven
 * @email jstarseven@163.com
 * @date 2017-03-25 12:13:26
 */
@RestController
@RequestMapping("sys/oss")
public class SysOssController {
    @Autowired
    private SysOssService sysOssService;
    @Autowired
    private SysConfigService sysConfigService;

    private final static String KEY = ConfigConstant.CLOUD_STORAGE_CONFIG_KEY;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:oss:all")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = sysOssService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 云存储配置信息
     */
    @RequestMapping("/config")
    @RequiresPermissions("sys:oss:all")
    public R config() {
        CloudStorageConfig config = sysConfigService.getConfigObject(KEY, CloudStorageConfig.class);

        return R.ok().put("config", config);
    }


    /**
     * 保存云存储配置信息
     */
    @RequestMapping("/saveConfig")
    @RequiresPermissions("sys:oss:all")
    public R saveConfig(@RequestBody CloudStorageConfig config) {
        //校验类型
        ValidatorUtils.validateEntity(config);

        if (config.getType() == Constant.CloudService.QINIU.getValue()) {
            //校验七牛数据
            ValidatorUtils.validateEntity(config, QiniuGroup.class);
        } else if (config.getType() == Constant.CloudService.ALIYUN.getValue()) {
            //校验阿里云数据
            ValidatorUtils.validateEntity(config, AliyunGroup.class);
        } else if (config.getType() == Constant.CloudService.QCLOUD.getValue()) {
            //校验腾讯云数据
            ValidatorUtils.validateEntity(config, QcloudGroup.class);
        }

        sysConfigService.updateValueByKey(KEY, new Gson().toJson(config));

        return R.ok();
    }


    /**
     * 上传文件
     */
    @RequestMapping("/upload/{type}")
//	@RequiresPermissions("sys:oss:all")
    public R upload(@PathVariable("type") String type, @RequestParam("file") MultipartFile file) throws Exception {
        if (file.isEmpty()) {
            throw new RRException("上传文件不能为空");
        }
        String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        if ("book_img".equals(type)) {
            String fileName = Md5Utils.GetMD5Code(file.getOriginalFilename() + System.currentTimeMillis()) + suffix;
            File path = new File(ResourceUtils.getURL("classpath:").getPath());
            String sPath = path.getParentFile().getParentFile().getParent() + File.separator + "bskf-admin" + File.separator + "src" + File.separator + "main" + File.separator +
                    "resources" + File.separator + "statics" + File.separator + "book_img" + File.separator;
            File dest = new File(sPath + fileName);
            try {
                file.transferTo(dest);
                return R.ok().put("url", "book_img" + File.separator + fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
            return R.error();
        } else {
            //上传文件
            String url = OSSFactory.build().uploadSuffix(file.getBytes(), suffix);

            //保存文件信息
            SysOssEntity ossEntity = new SysOssEntity();
            ossEntity.setUrl(url);
            ossEntity.setCreateDate(new Date());
            sysOssService.insert(ossEntity);
            return R.ok().put("url", url);
        }
    }


    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("sys:oss:all")
    public R delete(@RequestBody Long[] ids) {
        sysOssService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

    public static void main(String[] args) throws FileNotFoundException {
        File path = new File(ResourceUtils.getURL("classpath:").getPath());
        System.out.println(path.getParentFile().getParentFile().getParent() + File.separator + "bskf-admin" + File.separator + "src" + File.separator + "main" + File.separator +
                "resources" + File.separator + "statics" + File.separator + "book_img");
        String onlinePath = path.getParentFile().getParentFile().getParent() + File.separator + "uploads" + File.separator;
        onlinePath = onlinePath.substring(5, onlinePath.length());
        System.out.println(onlinePath);
    }
}
