package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Food;

public interface FoodMapper {
	/*添加宠物粮食信息*/
	public void addFood(Food food) throws Exception;

	/*按照查询条件分页查询宠物粮食记录*/
	public ArrayList<Food> queryFood(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有宠物粮食记录*/
	public ArrayList<Food> queryFoodList(@Param("where") String where) throws Exception;

	/*按照查询条件的宠物粮食记录数*/
	public int queryFoodCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条宠物粮食记录*/
	public Food getFood(int foodId) throws Exception;

	/*更新宠物粮食记录*/
	public void updateFood(Food food) throws Exception;

	/*删除宠物粮食记录*/
	public void deleteFood(int foodId) throws Exception;

}
