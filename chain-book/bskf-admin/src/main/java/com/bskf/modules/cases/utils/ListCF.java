package com.bskf.modules.cases.utils;

import com.google.common.collect.Lists;

import java.util.ArrayList;
import java.util.List;

/**
 * list 拆分
 * Created by jstarseven on 2016/3/23.
 */
public class ListCF {

    public static void main(String[] args) {
        List list = Lists.newArrayList();
        list.add(1);
        list.add(2);
        list.add(3);
        list.add(4);
        list.add(5);
        list.add(6);
        list.add(7);
        list.add(8);
        list.add(9);
        List list1 = subList(list, 10);
        System.out.println(49 % 50);

        List list2 = list.subList(5, list.size());
        System.out.println(list2);
    }

    //将list按blockSize大小等分，最后多余的单独一份
    public static <T> List<List<T>> subList(List<T> list, int blockSize) {
        List<List<T>> lists = new ArrayList<>();
        if (list != null && blockSize > 0) {
            int listSize = list.size();
            if (listSize <= blockSize) {
                lists.add(list);
                return lists;
            }
            int batchSize = listSize / blockSize;
            int remain = listSize % blockSize;
            for (int i = 0; i < batchSize; i++) {
                int fromIndex = i * blockSize;
                int toIndex = fromIndex + blockSize;
                System.out.println("fromIndex=" + fromIndex + ", toIndex=" + toIndex);
                lists.add(list.subList(fromIndex, toIndex));
            }
            if (remain > 0) {
                System.out.println("fromIndex=" + (listSize - remain) + ", toIndex=" + (listSize));
                lists.add(list.subList(listSize - remain, listSize));
            }
        }
        return lists;
    }


}
