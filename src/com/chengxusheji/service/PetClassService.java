package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.PetClass;

import com.chengxusheji.mapper.PetClassMapper;
@Service
public class PetClassService {

	@Resource PetClassMapper petClassMapper;
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

    /*添加宠物类别记录*/
    public void addPetClass(PetClass petClass) throws Exception {
    	petClassMapper.addPetClass(petClass);
    }

    /*按照查询条件分页查询宠物类别记录*/
    public ArrayList<PetClass> queryPetClass(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return petClassMapper.queryPetClass(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<PetClass> queryPetClass() throws Exception  { 
     	String where = "where 1=1";
    	return petClassMapper.queryPetClassList(where);
    }

    /*查询所有宠物类别记录*/
    public ArrayList<PetClass> queryAllPetClass()  throws Exception {
        return petClassMapper.queryPetClassList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = petClassMapper.queryPetClassCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取宠物类别记录*/
    public PetClass getPetClass(int petClassId) throws Exception  {
        PetClass petClass = petClassMapper.getPetClass(petClassId);
        return petClass;
    }

    /*更新宠物类别记录*/
    public void updatePetClass(PetClass petClass) throws Exception {
        petClassMapper.updatePetClass(petClass);
    }

    /*删除一条宠物类别记录*/
    public void deletePetClass (int petClassId) throws Exception {
        petClassMapper.deletePetClass(petClassId);
    }

    /*删除多条宠物类别信息*/
    public int deletePetClasss (String petClassIds) throws Exception {
    	String _petClassIds[] = petClassIds.split(",");
    	for(String _petClassId: _petClassIds) {
    		petClassMapper.deletePetClass(Integer.parseInt(_petClassId));
    	}
    	return _petClassIds.length;
    }
}
