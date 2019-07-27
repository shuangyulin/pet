package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Pet;

public interface PetMapper {
	/*添加宠物信息*/
	public void addPet(Pet pet) throws Exception;

	/*按照查询条件分页查询宠物记录*/
	public ArrayList<Pet> queryPet(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有宠物记录*/
	public ArrayList<Pet> queryPetList(@Param("where") String where) throws Exception;

	/*按照查询条件的宠物记录数*/
	public int queryPetCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条宠物记录*/
	public Pet getPet(int petId) throws Exception;

	/*更新宠物记录*/
	public void updatePet(Pet pet) throws Exception;

	/*删除宠物记录*/
	public void deletePet(int petId) throws Exception;

}
