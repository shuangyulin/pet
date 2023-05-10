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
import com.chengxusheji.service.PetClassService;
import com.chengxusheji.po.PetClass;

//PetClass管理控制层
@Controller
@RequestMapping("/PetClass")
public class PetClassController extends BaseController {

    /*业务层对象*/
    @Resource PetClassService petClassService;

	@InitBinder("petClass")
	public void initBinderPetClass(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("petClass.");
	}
	/*跳转到添加PetClass视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new PetClass());
		return "PetClass_add";
	}

	/*客户端ajax方式提交添加宠物类别信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated PetClass petClass, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        petClassService.addPetClass(petClass);
        message = "宠物类别添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询宠物类别信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)petClassService.setRows(rows);
		List<PetClass> petClassList = petClassService.queryPetClass(page);
	    /*计算总的页数和总的记录数*/
	    petClassService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = petClassService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = petClassService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(PetClass petClass:petClassList) {
			JSONObject jsonPetClass = petClass.getJsonObject();
			jsonArray.put(jsonPetClass);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询宠物类别信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<PetClass> petClassList = petClassService.queryAllPetClass();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(PetClass petClass:petClassList) {
			JSONObject jsonPetClass = new JSONObject();
			jsonPetClass.accumulate("petClassId", petClass.getPetClassId());
			jsonPetClass.accumulate("petClassName", petClass.getPetClassName());
			jsonArray.put(jsonPetClass);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询宠物类别信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<PetClass> petClassList = petClassService.queryPetClass(currentPage);
	    /*计算总的页数和总的记录数*/
	    petClassService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = petClassService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = petClassService.getRecordNumber();
	    request.setAttribute("petClassList",  petClassList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "PetClass/petClass_frontquery_result"; 
	}

     /*前台查询PetClass信息*/
	@RequestMapping(value="/{petClassId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer petClassId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键petClassId获取PetClass对象*/
        PetClass petClass = petClassService.getPetClass(petClassId);

        request.setAttribute("petClass",  petClass);
        return "PetClass/petClass_frontshow";
	}

	/*ajax方式显示宠物类别修改jsp视图页*/
	@RequestMapping(value="/{petClassId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer petClassId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键petClassId获取PetClass对象*/
        PetClass petClass = petClassService.getPetClass(petClassId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonPetClass = petClass.getJsonObject();
		out.println(jsonPetClass.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新宠物类别信息*/
	@RequestMapping(value = "/{petClassId}/update", method = RequestMethod.POST)
	public void update(@Validated PetClass petClass, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			petClassService.updatePetClass(petClass);
			message = "宠物类别更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "宠物类别更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除宠物类别信息*/
	@RequestMapping(value="/{petClassId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer petClassId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  petClassService.deletePetClass(petClassId);
	            request.setAttribute("message", "宠物类别删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "宠物类别删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条宠物类别记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String petClassIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = petClassService.deletePetClasss(petClassIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出宠物类别信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<PetClass> petClassList = petClassService.queryPetClass();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "PetClass信息记录"; 
        String[] headers = { "宠物类别id","宠物类别名称"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<petClassList.size();i++) {
        	PetClass petClass = petClassList.get(i); 
        	dataset.add(new String[]{petClass.getPetClassId() + "",petClass.getPetClassName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"PetClass.xls");//filename是下载的xls的名，建议最好用英文 
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
