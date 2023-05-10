package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class PetClass {
    /*宠物类别id*/
    private Integer petClassId;
    public Integer getPetClassId(){
        return petClassId;
    }
    public void setPetClassId(Integer petClassId){
        this.petClassId = petClassId;
    }

    /*宠物类别名称*/
    @NotEmpty(message="宠物类别名称不能为空")
    private String petClassName;
    public String getPetClassName() {
        return petClassName;
    }
    public void setPetClassName(String petClassName) {
        this.petClassName = petClassName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPetClass=new JSONObject(); 
		jsonPetClass.accumulate("petClassId", this.getPetClassId());
		jsonPetClass.accumulate("petClassName", this.getPetClassName());
		return jsonPetClass;
    }}