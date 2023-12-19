package com.bskf.modules.cases.utils;/**
 * Created by jstarseven on 2019/4/14.
 */

/**
 * Title: Kpoint
 * Description:
 * Company: 北京华宇元典信息服务有限公司
 *
 * @author lingrui
 * @version 1.0
 * @date 2019/4/14
 */
public class Kpoint {
    private float[] localArray;
    private int id;
    private int clusterId;  // 标识属于哪个类中心。
    private float dist;     // 标识和所属类中心的距离。

    public Kpoint(int id, float[] localArray) {
        this.id = id;
        this.localArray = localArray;
    }

    public Kpoint(float[] localArray) {
        this.id = -1; //表示不属于任意一个类
        this.localArray = localArray;
    }

    public float[] getlocalArray() {
        return localArray;
    }

    public int getId() {
        return id;
    }

    public void setClusterId(int clusterId) {
        this.clusterId = clusterId;
    }

    public int getClusterid() {
        return clusterId;
    }

    public float getDist() {
        return dist;
    }

    public void setDist(float dist) {
        this.dist = dist;
    }

    @Override
    public String toString() {
        String result = "Point_id=" + id + "  [";
        for (int i = 0; i < localArray.length; i++) {
            result += localArray[i] + " ";
        }
        return result.trim() + "] clusterId: " + clusterId + " dist: " + dist;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null || getClass() != obj.getClass())
            return false;

        Kpoint kpoint = (Kpoint) obj;
        if (kpoint.localArray.length != localArray.length)
            return false;

        for (int i = 0; i < localArray.length; i++) {
            if (Float.compare(kpoint.localArray[i], localArray[i]) != 0) {
                return false;
            }
        }
        return true;
    }

    @Override
    public int hashCode() {
        float x = localArray[0];
        float y = localArray[localArray.length - 1];
        long temp = x != +0.0d ? Double.doubleToLongBits(x) : 0L;
        int result = (int) (temp ^ (temp >>> 32));
        temp = y != +0.0d ? Double.doubleToLongBits(y) : 0L;
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        return result;
    }

}
