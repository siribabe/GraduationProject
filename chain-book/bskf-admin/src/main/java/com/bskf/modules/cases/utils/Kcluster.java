package com.bskf.modules.cases.utils;

import java.util.ArrayList;
import java.util.List;

public class Kcluster {
    private int id;// 标识
    private Kpoint center;// 中心
    private List<Kpoint> members = new ArrayList<Kpoint>();// 成员

    public Kcluster(int id, Kpoint center) {
        this.id = id;
        this.center = center;
    }

    public Kcluster(int id, Kpoint center, List<Kpoint> members) {
        this.id = id;
        this.center = center;
        this.members = members;
    }

    public void addPoint(Kpoint newKpoint) {
        members.add(newKpoint);
    }

    public int getId() {
        return id;
    }

    public Kpoint getCenter() {
        return center;
    }

    public void setCenter(Kpoint center) {
        this.center = center;
    }

    public List<Kpoint> getMembers() {
        return members;
    }

    @Override
    public String toString() {
        String toString = "Kcluster \n" + "Cluster_id=" + this.id + ", center:{" + this.center.toString() + "}";
        for (Kpoint kpoint : members) {
            toString += "\n" + kpoint.toString();
        }
        return toString + "\n";
    }
}
