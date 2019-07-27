package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Adopt {
    /*领养id*/
    private Integer adoptId;
    public Integer getAdoptId(){
        return adoptId;
    }
    public void setAdoptId(Integer adoptId){
        this.adoptId = adoptId;
    }

    /*被领养宠物*/
    private Pet petObj;
    public Pet getPetObj() {
        return petObj;
    }
    public void setPetObj(Pet petObj) {
        this.petObj = petObj;
    }

    /*领养人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*领养申请时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    /*审核状态*/
    @NotEmpty(message="审核状态不能为空")
    private String shenHe;
    public String getShenHe() {
        return shenHe;
    }
    public void setShenHe(String shenHe) {
        this.shenHe = shenHe;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonAdopt=new JSONObject(); 
		jsonAdopt.accumulate("adoptId", this.getAdoptId());
		jsonAdopt.accumulate("petObj", this.getPetObj().getPetName());
		jsonAdopt.accumulate("petObjPri", this.getPetObj().getPetId());
		jsonAdopt.accumulate("userObj", this.getUserObj().getName());
		jsonAdopt.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonAdopt.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		jsonAdopt.accumulate("shenHe", this.getShenHe());
		return jsonAdopt;
    }}