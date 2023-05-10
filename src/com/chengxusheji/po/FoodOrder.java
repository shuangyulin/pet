package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class FoodOrder {
    /*订单id*/
    private Integer orderId;
    public Integer getOrderId(){
        return orderId;
    }
    public void setOrderId(Integer orderId){
        this.orderId = orderId;
    }

    /*宠粮名称*/
    private Food foodObj;
    public Food getFoodObj() {
        return foodObj;
    }
    public void setFoodObj(Food foodObj) {
        this.foodObj = foodObj;
    }

    /*预订用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*预订数量*/
    @NotNull(message="必须输入预订数量")
    private Integer orderNumber;
    public Integer getOrderNumber() {
        return orderNumber;
    }
    public void setOrderNumber(Integer orderNumber) {
        this.orderNumber = orderNumber;
    }

    /*订单状态*/
    @NotEmpty(message="订单状态不能为空")
    private String orderState;
    public String getOrderState() {
        return orderState;
    }
    public void setOrderState(String orderState) {
        this.orderState = orderState;
    }

    /*预订时间*/
    private String orderTime;
    public String getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonFoodOrder=new JSONObject(); 
		jsonFoodOrder.accumulate("orderId", this.getOrderId());
		jsonFoodOrder.accumulate("foodObj", this.getFoodObj().getFoodName());
		jsonFoodOrder.accumulate("foodObjPri", this.getFoodObj().getFoodId());
		jsonFoodOrder.accumulate("userObj", this.getUserObj().getName());
		jsonFoodOrder.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonFoodOrder.accumulate("orderNumber", this.getOrderNumber());
		jsonFoodOrder.accumulate("orderState", this.getOrderState());
		jsonFoodOrder.accumulate("orderTime", this.getOrderTime().length()>19?this.getOrderTime().substring(0,19):this.getOrderTime());
		return jsonFoodOrder;
    }}