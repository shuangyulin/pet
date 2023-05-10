package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.FoodService;
import com.chengxusheji.po.Food;

//Food管理控制层
@Controller
@RequestMapping("/Food")
public class FoodController extends BaseController {

    /*业务层对象*/
    @Resource FoodService foodService;

	@InitBinder("food")
	public void initBinderFood(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("food.");
	}
	/*跳转到添加Food视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Food());
		return "Food_add";
	}

	/*客户端ajax方式提交添加宠物粮食信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Food food, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			food.setFoodPhoto(this.handlePhotoUpload(request, "foodPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        foodService.addFood(food);
        message = "宠物粮食添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询宠物粮食信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String foodName,String addDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (foodName == null) foodName = "";
		if (addDate == null) addDate = "";
		if(rows != 0)foodService.setRows(rows);
		List<Food> foodList = foodService.queryFood(foodName, addDate, page);
	    /*计算总的页数和总的记录数*/
	    foodService.queryTotalPageAndRecordNumber(foodName, addDate);
	    /*获取到总的页码数目*/
	    int totalPage = foodService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = foodService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Food food:foodList) {
			JSONObject jsonFood = food.getJsonObject();
			jsonArray.put(jsonFood);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询宠物粮食信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Food> foodList = foodService.queryAllFood();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Food food:foodList) {
			JSONObject jsonFood = new JSONObject();
			jsonFood.accumulate("foodId", food.getFoodId());
			jsonFood.accumulate("foodName", food.getFoodName());
			jsonArray.put(jsonFood);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询宠物粮食信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String foodName,String addDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (foodName == null) foodName = "";
		if (addDate == null) addDate = "";
		List<Food> foodList = foodService.queryFood(foodName, addDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    foodService.queryTotalPageAndRecordNumber(foodName, addDate);
	    /*获取到总的页码数目*/
	    int totalPage = foodService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = foodService.getRecordNumber();
	    request.setAttribute("foodList",  foodList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("foodName", foodName);
	    request.setAttribute("addDate", addDate);
		return "Food/food_frontquery_result"; 
	}

     /*前台查询Food信息*/
	@RequestMapping(value="/{foodId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer foodId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键foodId获取Food对象*/
        Food food = foodService.getFood(foodId);

        request.setAttribute("food",  food);
        return "Food/food_frontshow";
	}

	/*ajax方式显示宠物粮食修改jsp视图页*/
	@RequestMapping(value="/{foodId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer foodId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键foodId获取Food对象*/
        Food food = foodService.getFood(foodId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonFood = food.getJsonObject();
		out.println(jsonFood.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新宠物粮食信息*/
	@RequestMapping(value = "/{foodId}/update", method = RequestMethod.POST)
	public void update(@Validated Food food, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String foodPhotoFileName = this.handlePhotoUpload(request, "foodPhotoFile");
		if(!foodPhotoFileName.equals("upload/NoImage.jpg"))food.setFoodPhoto(foodPhotoFileName); 


		try {
			foodService.updateFood(food);
			message = "宠物粮食更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "宠物粮食更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除宠物粮食信息*/
	@RequestMapping(value="/{foodId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer foodId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  foodService.deleteFood(foodId);
	            request.setAttribute("message", "宠物粮食删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "宠物粮食删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条宠物粮食记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String foodIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = foodService.deleteFoods(foodIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出宠物粮食信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String foodName,String addDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(foodName == null) foodName = "";
        if(addDate == null) addDate = "";
        List<Food> foodList = foodService.queryFood(foodName,addDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Food信息记录"; 
        String[] headers = { "宠粮id","宠粮名称","宠粮照片","库存数量","上架日期"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<foodList.size();i++) {
        	Food food = foodList.get(i); 
        	dataset.add(new String[]{food.getFoodId() + "",food.getFoodName(),food.getFoodPhoto(),food.getFoodNum() + "",food.getAddDate()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Food.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
