package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.PetClass;

public interface PetClassMapper {
	/*添加宠物类别信息*/
	public void addPetClass(PetClass petClass) throws Exception;

	/*按照查询条件分页查询宠物类别记录*/
	public ArrayList<PetClass> queryPetClass(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有宠物类别记录*/
	public ArrayList<PetClass> queryPetClassList(@Param("where") String where) throws Exception;

	/*按照查询条件的宠物类别记录数*/
	public int queryPetClassCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条宠物类别记录*/
	public PetClass getPetClass(int petClassId) throws Exception;

	/*更新宠物类别记录*/
	public void updatePetClass(PetClass petClass) throws Exception;

	/*删除宠物类别记录*/
	public void deletePetClass(int petClassId) throws Exception;

}
