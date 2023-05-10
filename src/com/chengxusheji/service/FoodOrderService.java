package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Food;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.FoodOrder;

import com.chengxusheji.mapper.FoodOrderMapper;
@Service
public class FoodOrderService {

	@Resource FoodOrderMapper foodOrderMapper;
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

    /*添加宠粮订单记录*/
    public void addFoodOrder(FoodOrder foodOrder) throws Exception {
    	foodOrderMapper.addFoodOrder(foodOrder);
    }

    /*按照查询条件分页查询宠粮订单记录*/
    public ArrayList<FoodOrder> queryFoodOrder(Food foodObj,UserInfo userObj,String orderState,String orderTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != foodObj && foodObj.getFoodId()!= null && foodObj.getFoodId()!= 0)  where += " and t_foodOrder.foodObj=" + foodObj.getFoodId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_foodOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!orderState.equals("")) where = where + " and t_foodOrder.orderState like '%" + orderState + "%'";
    	if(!orderTime.equals("")) where = where + " and t_foodOrder.orderTime like '%" + orderTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return foodOrderMapper.queryFoodOrder(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<FoodOrder> queryFoodOrder(Food foodObj,UserInfo userObj,String orderState,String orderTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != foodObj && foodObj.getFoodId()!= null && foodObj.getFoodId()!= 0)  where += " and t_foodOrder.foodObj=" + foodObj.getFoodId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_foodOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!orderState.equals("")) where = where + " and t_foodOrder.orderState like '%" + orderState + "%'";
    	if(!orderTime.equals("")) where = where + " and t_foodOrder.orderTime like '%" + orderTime + "%'";
    	return foodOrderMapper.queryFoodOrderList(where);
    }

    /*查询所有宠粮订单记录*/
    public ArrayList<FoodOrder> queryAllFoodOrder()  throws Exception {
        return foodOrderMapper.queryFoodOrderList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Food foodObj,UserInfo userObj,String orderState,String orderTime) throws Exception {
     	String where = "where 1=1";
    	if(null != foodObj && foodObj.getFoodId()!= null && foodObj.getFoodId()!= 0)  where += " and t_foodOrder.foodObj=" + foodObj.getFoodId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_foodOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!orderState.equals("")) where = where + " and t_foodOrder.orderState like '%" + orderState + "%'";
    	if(!orderTime.equals("")) where = where + " and t_foodOrder.orderTime like '%" + orderTime + "%'";
        recordNumber = foodOrderMapper.queryFoodOrderCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取宠粮订单记录*/
    public FoodOrder getFoodOrder(int orderId) throws Exception  {
        FoodOrder foodOrder = foodOrderMapper.getFoodOrder(orderId);
        return foodOrder;
    }

    /*更新宠粮订单记录*/
    public void updateFoodOrder(FoodOrder foodOrder) throws Exception {
        foodOrderMapper.updateFoodOrder(foodOrder);
    }

    /*删除一条宠粮订单记录*/
    public void deleteFoodOrder (int orderId) throws Exception {
        foodOrderMapper.deleteFoodOrder(orderId);
    }

    /*删除多条宠粮订单信息*/
    public int deleteFoodOrders (String orderIds) throws Exception {
    	String _orderIds[] = orderIds.split(",");
    	for(String _orderId: _orderIds) {
    		foodOrderMapper.deleteFoodOrder(Integer.parseInt(_orderId));
    	}
    	return _orderIds.length;
    }
}
