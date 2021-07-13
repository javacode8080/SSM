package com.atguigu.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 设计的一个通用的JSON返回类
 */
public class Msg {
    private int code;//状态码：100-处理成功；200-处理失败
    private String msg;//提示信息：
    private Map<String,Object> extend=new HashMap<>();//用户返回给浏览器的数据；

    /**
     * 处理成功方法
     * @return
     */
    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功！");
        return result;
    }

    /**
     * 处理失败方法
     * @return
     */
    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败！");
        return result;
    }

    /**
     * add():添加方法，实现数据的传递和其他信息的自动添加，要实现的是自动连接，故返回的是Msg对象
     * @return
     */
    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
