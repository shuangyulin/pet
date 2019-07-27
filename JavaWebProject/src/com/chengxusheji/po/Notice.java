package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Notice {
    /*公告id*/
    private Integer noticeId;
    public Integer getNoticeId(){
        return noticeId;
    }
    public void setNoticeId(Integer noticeId){
        this.noticeId = noticeId;
    }

    /*标题*/
    @NotEmpty(message="标题不能为空")
    private String noticeTitle;
    public String getNoticeTitle() {
        return noticeTitle;
    }
    public void setNoticeTitle(String noticeTitle) {
        this.noticeTitle = noticeTitle;
    }

    /*公告类别*/
    @NotEmpty(message="公告类别不能为空")
    private String noticeClass;
    public String getNoticeClass() {
        return noticeClass;
    }
    public void setNoticeClass(String noticeClass) {
        this.noticeClass = noticeClass;
    }

    /*公告内容*/
    @NotEmpty(message="公告内容不能为空")
    private String noticeContent;
    public String getNoticeContent() {
        return noticeContent;
    }
    public void setNoticeContent(String noticeContent) {
        this.noticeContent = noticeContent;
    }

    /*发布日期*/
    @NotEmpty(message="发布日期不能为空")
    private String addDate;
    public String getAddDate() {
        return addDate;
    }
    public void setAddDate(String addDate) {
        this.addDate = addDate;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonNotice=new JSONObject(); 
		jsonNotice.accumulate("noticeId", this.getNoticeId());
		jsonNotice.accumulate("noticeTitle", this.getNoticeTitle());
		jsonNotice.accumulate("noticeClass", this.getNoticeClass());
		jsonNotice.accumulate("noticeContent", this.getNoticeContent());
		jsonNotice.accumulate("addDate", this.getAddDate().length()>19?this.getAddDate().substring(0,19):this.getAddDate());
		return jsonNotice;
    }}