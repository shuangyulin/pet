package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.PetClass;
import com.chengxusheji.po.Pet;

import com.chengxusheji.mapper.PetMapper;
@Service
public class PetService {

	@Resource PetMapper petMapper;
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

    /*添加宠物记录*/
    public void addPet(Pet pet) throws Exception {
    	petMapper.addPet(pet);
    }

    /*按照查询条件分页查询宠物记录*/
    public ArrayList<Pet> queryPet(PetClass petClassObj,String petName,String petState,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != petClassObj && petClassObj.getPetClassId()!= null && petClassObj.getPetClassId()!= 0)  where += " and t_pet.petClassObj=" + petClassObj.getPetClassId();
    	if(!petName.equals("")) where = where + " and t_pet.petName like '%" + petName + "%'";
    	if(!petState.equals("")) where = where + " and t_pet.petState like '%" + petState + "%'";
    	if(!addTime.equals("")) where = where + " and t_pet.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return petMapper.queryPet(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Pet> queryPet(PetClass petClassObj,String petName,String petState,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != petClassObj && petClassObj.getPetClassId()!= null && petClassObj.getPetClassId()!= 0)  where += " and t_pet.petClassObj=" + petClassObj.getPetClassId();
    	if(!petName.equals("")) where = where + " and t_pet.petName like '%" + petName + "%'";
    	if(!petState.equals("")) where = where + " and t_pet.petState like '%" + petState + "%'";
    	if(!addTime.equals("")) where = where + " and t_pet.addTime like '%" + addTime + "%'";
    	return petMapper.queryPetList(where);
    }

    /*查询所有宠物记录*/
    public ArrayList<Pet> queryAllPet()  throws Exception {
        return petMapper.queryPetList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(PetClass petClassObj,String petName,String petState,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(null != petClassObj && petClassObj.getPetClassId()!= null && petClassObj.getPetClassId()!= 0)  where += " and t_pet.petClassObj=" + petClassObj.getPetClassId();
    	if(!petName.equals("")) where = where + " and t_pet.petName like '%" + petName + "%'";
    	if(!petState.equals("")) where = where + " and t_pet.petState like '%" + petState + "%'";
    	if(!addTime.equals("")) where = where + " and t_pet.addTime like '%" + addTime + "%'";
        recordNumber = petMapper.queryPetCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取宠物记录*/
    public Pet getPet(int petId) throws Exception  {
        Pet pet = petMapper.getPet(petId);
        return pet;
    }

    /*更新宠物记录*/
    public void updatePet(Pet pet) throws Exception {
        petMapper.updatePet(pet);
    }

    /*删除一条宠物记录*/
    public void deletePet (int petId) throws Exception {
        petMapper.deletePet(petId);
    }

    /*删除多条宠物信息*/
    public int deletePets (String petIds) throws Exception {
    	String _petIds[] = petIds.split(",");
    	for(String _petId: _petIds) {
    		petMapper.deletePet(Integer.parseInt(_petId));
    	}
    	return _petIds.length;
    }
}
