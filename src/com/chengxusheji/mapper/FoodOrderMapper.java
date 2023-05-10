package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.FoodOrder;

public interface FoodOrderMapper {
	/*添加宠粮订单信息*/
	public void addFoodOrder(FoodOrder foodOrder) throws Exception;

	/*按照查询条件分页查询宠粮订单记录*/
	public ArrayList<FoodOrder> queryFoodOrder(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有宠粮订单记录*/
	public ArrayList<FoodOrder> queryFoodOrderList(@Param("where") String where) throws Exception;

	/*按照查询条件的宠粮订单记录数*/
	public int queryFoodOrderCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条宠粮订单记录*/
	public FoodOrder getFoodOrder(int orderId) throws Exception;

	/*更新宠粮订单记录*/
	public void updateFoodOrder(FoodOrder foodOrder) throws Exception;

	/*删除宠粮订单记录*/
	public void deleteFoodOrder(int orderId) throws Exception;

}
