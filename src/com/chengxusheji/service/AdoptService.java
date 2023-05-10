package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Pet;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Adopt;

import com.chengxusheji.mapper.AdoptMapper;
@Service
public class AdoptService {

	@Resource AdoptMapper adoptMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加领养记录*/
    public void addAdopt(Adopt adopt) throws Exception {
    	adoptMapper.addAdopt(adopt);
    }

    /*按照查询条件分页查询领养记录*/
    public ArrayList<Adopt> queryAdopt(Pet petObj,UserInfo userObj,String addTime,String shenHe,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != petObj && petObj.getPetId()!= null && petObj.getPetId()!= 0)  where += " and t_adopt.petObj=" + petObj.getPetId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_adopt.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_adopt.addTime like '%" + addTime + "%'";
    	if(!shenHe.equals("")) where = where + " and t_adopt.shenHe like '%" + shenHe + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return adoptMapper.queryAdopt(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Adopt> queryAdopt(Pet petObj,UserInfo userObj,String addTime,String shenHe) throws Exception  { 
     	String where = "where 1=1";
    	if(null != petObj && petObj.getPetId()!= null && petObj.getPetId()!= 0)  where += " and t_adopt.petObj=" + petObj.getPetId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_adopt.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_adopt.addTime like '%" + addTime + "%'";
    	if(!shenHe.equals("")) where = where + " and t_adopt.shenHe like '%" + shenHe + "%'";
    	return adoptMapper.queryAdoptList(where);
    }

    /*查询所有领养记录*/
    public ArrayList<Adopt> queryAllAdopt()  throws Exception {
        return adoptMapper.queryAdoptList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Pet petObj,UserInfo userObj,String addTime,String shenHe) throws Exception {
     	String where = "where 1=1";
    	if(null != petObj && petObj.getPetId()!= null && petObj.getPetId()!= 0)  where += " and t_adopt.petObj=" + petObj.getPetId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_adopt.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_adopt.addTime like '%" + addTime + "%'";
    	if(!shenHe.equals("")) where = where + " and t_adopt.shenHe like '%" + shenHe + "%'";
        recordNumber = adoptMapper.queryAdoptCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取领养记录*/
    public Adopt getAdopt(int adoptId) throws Exception  {
        Adopt adopt = adoptMapper.getAdopt(adoptId);
        return adopt;
    }

    /*更新领养记录*/
    public void updateAdopt(Adopt adopt) throws Exception {
        adoptMapper.updateAdopt(adopt);
    }

    /*删除一条领养记录*/
    public void deleteAdopt (int adoptId) throws Exception {
        adoptMapper.deleteAdopt(adoptId);
    }

    /*删除多条领养信息*/
    public int deleteAdopts (String adoptIds) throws Exception {
    	String _adoptIds[] = adoptIds.split(",");
    	for(String _adoptId: _adoptIds) {
    		adoptMapper.deleteAdopt(Integer.parseInt(_adoptId));
    	}
    	return _adoptIds.length;
    }
}
