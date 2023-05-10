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
import com.chengxusheji.service.FoodOrderService;
import com.chengxusheji.po.FoodOrder;
import com.chengxusheji.service.FoodService;
import com.chengxusheji.po.Food;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//FoodOrder管理控制层
@Controller
@RequestMapping("/FoodOrder")
public class FoodOrderController extends BaseController {

    /*业务层对象*/
    @Resource FoodOrderService foodOrderService;

    @Resource FoodService foodService;
    @Resource UserInfoService userInfoService;
	@InitBinder("foodObj")
	public void initBinderfoodObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("foodObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("foodOrder")
	public void initBinderFoodOrder(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("foodOrder.");
	}
	/*跳转到添加FoodOrder视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new FoodOrder());
		/*查询所有的Food信息*/
		List<Food> foodList = foodService.queryAllFood();
		request.setAttribute("foodList", foodList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "FoodOrder_add";
	}

	/*客户端ajax方式提交添加宠粮订单信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated FoodOrder foodOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        foodOrderService.addFoodOrder(foodOrder);
        message = "宠粮订单添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询宠粮订单信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("foodObj") Food foodObj,@ModelAttribute("userObj") UserInfo userObj,String orderState,String orderTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (orderState == null) orderState = "";
		if (orderTime == null) orderTime = "";
		if(rows != 0)foodOrderService.setRows(rows);
		List<FoodOrder> foodOrderList = foodOrderService.queryFoodOrder(foodObj, userObj, orderState, orderTime, page);
	    /*计算总的页数和总的记录数*/
	    foodOrderService.queryTotalPageAndRecordNumber(foodObj, userObj, orderState, orderTime);
	    /*获取到总的页码数目*/
	    int totalPage = foodOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = foodOrderService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(FoodOrder foodOrder:foodOrderList) {
			JSONObject jsonFoodOrder = foodOrder.getJsonObject();
			jsonArray.put(jsonFoodOrder);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询宠粮订单信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<FoodOrder> foodOrderList = foodOrderService.queryAllFoodOrder();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(FoodOrder foodOrder:foodOrderList) {
			JSONObject jsonFoodOrder = new JSONObject();
			jsonFoodOrder.accumulate("orderId", foodOrder.getOrderId());
			jsonArray.put(jsonFoodOrder);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询宠粮订单信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("foodObj") Food foodObj,@ModelAttribute("userObj") UserInfo userObj,String orderState,String orderTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (orderState == null) orderState = "";
		if (orderTime == null) orderTime = "";
		List<FoodOrder> foodOrderList = foodOrderService.queryFoodOrder(foodObj, userObj, orderState, orderTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    foodOrderService.queryTotalPageAndRecordNumber(foodObj, userObj, orderState, orderTime);
	    /*获取到总的页码数目*/
	    int totalPage = foodOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = foodOrderService.getRecordNumber();
	    request.setAttribute("foodOrderList",  foodOrderList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("foodObj", foodObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("orderState", orderState);
	    request.setAttribute("orderTime", orderTime);
	    List<Food> foodList = foodService.queryAllFood();
	    request.setAttribute("foodList", foodList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "FoodOrder/foodOrder_frontquery_result"; 
	}

     /*前台查询FoodOrder信息*/
	@RequestMapping(value="/{orderId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer orderId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键orderId获取FoodOrder对象*/
        FoodOrder foodOrder = foodOrderService.getFoodOrder(orderId);

        List<Food> foodList = foodService.queryAllFood();
        request.setAttribute("foodList", foodList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("foodOrder",  foodOrder);
        return "FoodOrder/foodOrder_frontshow";
	}

	/*ajax方式显示宠粮订单修改jsp视图页*/
	@RequestMapping(value="/{orderId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer orderId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键orderId获取FoodOrder对象*/
        FoodOrder foodOrder = foodOrderService.getFoodOrder(orderId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonFoodOrder = foodOrder.getJsonObject();
		out.println(jsonFoodOrder.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新宠粮订单信息*/
	@RequestMapping(value = "/{orderId}/update", method = RequestMethod.POST)
	public void update(@Validated FoodOrder foodOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			foodOrderService.updateFoodOrder(foodOrder);
			message = "宠粮订单更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "宠粮订单更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除宠粮订单信息*/
	@RequestMapping(value="/{orderId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer orderId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  foodOrderService.deleteFoodOrder(orderId);
	            request.setAttribute("message", "宠粮订单删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "宠粮订单删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条宠粮订单记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String orderIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = foodOrderService.deleteFoodOrders(orderIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出宠粮订单信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("foodObj") Food foodObj,@ModelAttribute("userObj") UserInfo userObj,String orderState,String orderTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(orderState == null) orderState = "";
        if(orderTime == null) orderTime = "";
        List<FoodOrder> foodOrderList = foodOrderService.queryFoodOrder(foodObj,userObj,orderState,orderTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "FoodOrder信息记录"; 
        String[] headers = { "订单id","宠粮名称","预订用户","预订数量","订单状态","预订时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<foodOrderList.size();i++) {
        	FoodOrder foodOrder = foodOrderList.get(i); 
        	dataset.add(new String[]{foodOrder.getOrderId() + "",foodOrder.getFoodObj().getFoodName(),foodOrder.getUserObj().getName(),foodOrder.getOrderNumber() + "",foodOrder.getOrderState(),foodOrder.getOrderTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"FoodOrder.xls");//filename是下载的xls的名，建议最好用英文 
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
