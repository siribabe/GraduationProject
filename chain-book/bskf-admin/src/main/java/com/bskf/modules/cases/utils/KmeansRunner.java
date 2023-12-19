package com.bskf.modules.cases.utils;

import java.util.*;

/**
 * k-means算法聚类
 */
public class KmeansRunner {

    private int kNum;                             //簇的个数
    private int iterNum = 10;                     //迭代次数
    private int iterMaxTimes = 100000;            //单次迭代最大运行次数
    private int iterRunTimes = 0;                 //单次迭代实际运行次数
    private float disDiff = (float) 0.01;         //单次迭代终止条件，两次运行中类中心的距离差
    private Map<Long, float[]> original_data;    //用于存放，原始数据集
    private static List<Kpoint> kpointList = null;   //用于存放，原始数据集所构建的点集
    private int len = 0;                           //用于记录每个数据点的维度

    public KmeansRunner(int k, Map<Long, float[]> original_data) {
        this.kNum = k;
        this.original_data = original_data;
        this.len = original_data.values().iterator().next().length;
        //检查规范
        check();
        //初始化点集。
        init();
    }

    /**
     * 检查规范
     */
    private void check() {
        if (kNum == 0) {
            throw new IllegalArgumentException("k must be the number > 0");
        }
        if (original_data == null) {
            throw new IllegalArgumentException("program can't get real data");
        }
    }

    /**
     * 初始化数据集，把数组转化为Point类型。
     */
    private void init() {
        kpointList = new ArrayList<>();
        for (Long uid : original_data.keySet()) {
            kpointList.add(new Kpoint(Math.toIntExact(uid), original_data.get(uid)));
        }
        System.out.println(kpointList);
    }

    /**
     * 随机选取中心点，构建成中心类。
     */
    private Set<Kcluster> chooseCenterCluster() {
        Set<Kcluster> kclusterSet = new HashSet<Kcluster>();
        Random random = new Random();
        for (int id = 0; id < kNum; ) {
            int anInt = random.nextInt(kpointList.size());
            Kpoint kpoint = kpointList.get(anInt);
            // 用于标记是否已经选择过该数据。
            boolean flag = true;
            for (Kcluster kcluster : kclusterSet) {
                if (kcluster.getCenter().equals(kpoint)) {
                    flag = false;
                }
            }
            // 如果随机选取的点没有被选中过，则生成一个cluster
            if (flag) {
                Kcluster kcluster = new Kcluster(id, kpoint);
                kclusterSet.add(kcluster);
                id++;
            }
        }
        return kclusterSet;
    }

    /**
     * 为每个点分配一个类！
     */
    public void cluster(Set<Kcluster> kclusterSet) {
        // 计算每个点到K个中心的距离，并且为每个点标记类别号
        for (Kpoint kpoint : kpointList) {
            float min_dis = Integer.MAX_VALUE;
            for (Kcluster kcluster : kclusterSet) {
                float tmp_dis = (float) Math.min(getEuclideanDis(kpoint, kcluster.getCenter()), min_dis);
                if (tmp_dis != min_dis) {
                    min_dis = tmp_dis;
                    kpoint.setClusterId(kcluster.getId());
                    kpoint.setDist(min_dis);
                }
            }
        }
        // 新清除原来所有的类中成员。把所有的点，分别加入每个类别
        for (Kcluster kcluster : kclusterSet) {
            kcluster.getMembers().clear();
            for (Kpoint kpoint : kpointList) {
                if (kpoint.getClusterid() == kcluster.getId()) {
                    kcluster.addPoint(kpoint);
                }
            }
        }
    }

    /**
     * 计算每个类的中心位置！
     */
    public boolean calculateCenter(Set<Kcluster> kclusterSet) {
        boolean ifNeedIter = false;
        for (Kcluster kcluster : kclusterSet) {
            List<Kpoint> kpoint_list = kcluster.getMembers();
            float[] sumAll = new float[len];
            // 所有点，对应各个维度进行求和
            for (int i = 0; i < len; i++) {
                for (int j = 0; j < kpoint_list.size(); j++) {
                    sumAll[i] += kpoint_list.get(j).getlocalArray()[i];
                }
            }
            // 计算平均值
            for (int i = 0; i < sumAll.length; i++) {
                sumAll[i] = (float) sumAll[i] / kpoint_list.size();
            }
            // 计算两个新、旧中心的距离，如果任意一个类中心移动的距离大于dis_diff则继续迭代。
            if (getEuclideanDis(kcluster.getCenter(), new Kpoint(sumAll)) > disDiff) {
                ifNeedIter = true;
            }
            // 设置新的类中心位置
            kcluster.setCenter(new Kpoint(sumAll));
        }
        return ifNeedIter;
    }

    /**
     * 运行 k-means
     */
    public Set<Kcluster> run() {
        Set<Kcluster> kclusterSet = chooseCenterCluster();
        boolean ifNeedIter = true;
        while (ifNeedIter) {
            cluster(kclusterSet);
            ifNeedIter = calculateCenter(kclusterSet);
            iterRunTimes++;
        }
        return kclusterSet;
    }

    /**
     * 返回实际运行次数
     */
    public int getIterTimes() {
        return iterRunTimes;
    }


    /**
     * 求欧式距离
     */
    public static double getEuclideanDis(Kpoint p1, Kpoint p2) {
        double count_dis = 0;
        float[] p1_local_array = p1.getlocalArray();
        float[] p2_local_array = p2.getlocalArray();

        if (p1_local_array.length != p2_local_array.length) {
            throw new IllegalArgumentException("length of array must be equal!");
        }

        for (int i = 0; i < p1_local_array.length; i++) {
            count_dis += Math.pow(p1_local_array[i] - p2_local_array[i], 2);
        }

        return Math.sqrt(count_dis);
    }
}
