package com.jasmine.wx.entity;

import java.io.Serializable;
import java.lang.reflect.Field;

public class ObjectString implements Serializable {

    private int num;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String toString(){
        StringBuilder stringBuilder=new StringBuilder();
        stringBuilder.append("{");
        Field []fields=this.getClass().getDeclaredFields();
        for(Field field:fields){
            field.setAccessible(true);
            stringBuilder.append("\""+field.getName()+"\":");
            try {
                stringBuilder.append(field.get(this)+",");
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
        stringBuilder.append("}");
        return stringBuilder.toString();
    }
}
