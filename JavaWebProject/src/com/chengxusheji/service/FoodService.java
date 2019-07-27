package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Food;

import com.chengxusheji.mapper.FoodMapper;
@Service
public class FoodService {

	@Resource FoodMapper foodMapper;
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

    /*添加宠物粮食记录*/
    public void addFood(Food food) throws Exception {
    	foodMapper.addFood(food);
    }

    /*按照查询条件分页查询宠物粮食记录*/
    public ArrayList<Food> queryFood(String foodName,String addDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!foodName.equals("")) where = where + " and t_food.foodName like '%" + foodName + "%'";
    	if(!addDate.equals("")) where = where + " and t_food.addDate like '%" + addDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return foodMapper.queryFood(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Food> queryFood(String foodName,String addDate) throws Exception  { 
     	String where = "where 1=1";
    	if(!foodName.equals("")) where = where + " and t_food.foodName like '%" + foodName + "%'";
    	if(!addDate.equals("")) where = where + " and t_food.addDate like '%" + addDate + "%'";
    	return foodMapper.queryFoodList(where);
    }

    /*查询所有宠物粮食记录*/
    public ArrayList<Food> queryAllFood()  throws Exception {
        return foodMapper.queryFoodList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String foodName,String addDate) throws Exception {
     	String where = "where 1=1";
    	if(!foodName.equals("")) where = where + " and t_food.foodName like '%" + foodName + "%'";
    	if(!addDate.equals("")) where = where + " and t_food.addDate like '%" + addDate + "%'";
        recordNumber = foodMapper.queryFoodCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取宠物粮食记录*/
    public Food getFood(int foodId) throws Exception  {
        Food food = foodMapper.getFood(foodId);
        return food;
    }

    /*更新宠物粮食记录*/
    public void updateFood(Food food) throws Exception {
        foodMapper.updateFood(food);
    }

    /*删除一条宠物粮食记录*/
    public void deleteFood (int foodId) throws Exception {
        foodMapper.deleteFood(foodId);
    }

    /*删除多条宠物粮食信息*/
    public int deleteFoods (String foodIds) throws Exception {
    	String _foodIds[] = foodIds.split(",");
    	for(String _foodId: _foodIds) {
    		foodMapper.deleteFood(Integer.parseInt(_foodId));
    	}
    	return _foodIds.length;
    }
}
