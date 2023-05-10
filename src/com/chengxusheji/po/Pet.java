package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Pet {
    /*宠物id*/
    private Integer petId;
    public Integer getPetId(){
        return petId;
    }
    public void setPetId(Integer petId){
        this.petId = petId;
    }

    /*宠物类别*/
    private PetClass petClassObj;
    public PetClass getPetClassObj() {
        return petClassObj;
    }
    public void setPetClassObj(PetClass petClassObj) {
        this.petClassObj = petClassObj;
    }

    /*宠物名称*/
    @NotEmpty(message="宠物名称不能为空")
    private String petName;
    public String getPetName() {
        return petName;
    }
    public void setPetName(String petName) {
        this.petName = petName;
    }

    /*宠物照片*/
    private String petPhoto;
    public String getPetPhoto() {
        return petPhoto;
    }
    public void setPetPhoto(String petPhoto) {
        this.petPhoto = petPhoto;
    }

    /*宠物介绍*/
    @NotEmpty(message="宠物介绍不能为空")
    private String petDesc;
    public String getPetDesc() {
        return petDesc;
    }
    public void setPetDesc(String petDesc) {
        this.petDesc = petDesc;
    }

    /*领养要求*/
    @NotEmpty(message="领养要求不能为空")
    private String petRequest;
    public String getPetRequest() {
        return petRequest;
    }
    public void setPetRequest(String petRequest) {
        this.petRequest = petRequest;
    }

    /*领养状态*/
    @NotEmpty(message="领养状态不能为空")
    private String petState;
    public String getPetState() {
        return petState;
    }
    public void setPetState(String petState) {
        this.petState = petState;
    }

    /*登记时间*/
    @NotEmpty(message="登记时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPet=new JSONObject(); 
		jsonPet.accumulate("petId", this.getPetId());
		jsonPet.accumulate("petClassObj", this.getPetClassObj().getPetClassName());
		jsonPet.accumulate("petClassObjPri", this.getPetClassObj().getPetClassId());
		jsonPet.accumulate("petName", this.getPetName());
		jsonPet.accumulate("petPhoto", this.getPetPhoto());
		jsonPet.accumulate("petDesc", this.getPetDesc());
		jsonPet.accumulate("petRequest", this.getPetRequest());
		jsonPet.accumulate("petState", this.getPetState());
		jsonPet.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonPet;
    }}