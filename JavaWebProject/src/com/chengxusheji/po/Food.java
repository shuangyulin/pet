package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Food {
    /*宠粮id*/
    private Integer foodId;
    public Integer getFoodId(){
        return foodId;
    }
    public void setFoodId(Integer foodId){
        this.foodId = foodId;
    }

    /*宠粮名称*/
    @NotEmpty(message="宠粮名称不能为空")
    private String foodName;
    public String getFoodName() {
        return foodName;
    }
    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    /*宠粮照片*/
    private String foodPhoto;
    public String getFoodPhoto() {
        return foodPhoto;
    }
    public void setFoodPhoto(String foodPhoto) {
        this.foodPhoto = foodPhoto;
    }

    /*宠粮介绍*/
    @NotEmpty(message="宠粮介绍不能为空")
    private String foodDesc;
    public String getFoodDesc() {
        return foodDesc;
    }
    public void setFoodDesc(String foodDesc) {
        this.foodDesc = foodDesc;
    }

    /*库存数量*/
    @NotNull(message="必须输入库存数量")
    private Integer foodNum;
    public Integer getFoodNum() {
        return foodNum;
    }
    public void setFoodNum(Integer foodNum) {
        this.foodNum = foodNum;
    }

    /*上架日期*/
    @NotEmpty(message="上架日期不能为空")
    private String addDate;
    public String getAddDate() {
        return addDate;
    }
    public void setAddDate(String addDate) {
        this.addDate = addDate;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonFood=new JSONObject(); 
		jsonFood.accumulate("foodId", this.getFoodId());
		jsonFood.accumulate("foodName", this.getFoodName());
		jsonFood.accumulate("foodPhoto", this.getFoodPhoto());
		jsonFood.accumulate("foodDesc", this.getFoodDesc());
		jsonFood.accumulate("foodNum", this.getFoodNum());
		jsonFood.accumulate("addDate", this.getAddDate().length()>19?this.getAddDate().substring(0,19):this.getAddDate());
		return jsonFood;
    }}