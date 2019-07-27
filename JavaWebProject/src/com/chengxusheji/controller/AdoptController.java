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
import com.chengxusheji.service.AdoptService;
import com.chengxusheji.po.Adopt;
import com.chengxusheji.service.PetService;
import com.chengxusheji.po.Pet;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Adopt管理控制层
@Controller
@RequestMapping("/Adopt")
public class AdoptController extends BaseController {

    /*业务层对象*/
    @Resource AdoptService adoptService;

    @Resource PetService petService;
    @Resource UserInfoService userInfoService;
	@InitBinder("petObj")
	public void initBinderpetObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("petObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("adopt")
	public void initBinderAdopt(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("adopt.");
	}
	/*跳转到添加Adopt视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Adopt());
		/*查询所有的Pet信息*/
		List<Pet> petList = petService.queryAllPet();
		request.setAttribute("petList", petList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Adopt_add";
	}

	/*客户端ajax方式提交添加领养信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Adopt adopt, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        adoptService.addAdopt(adopt);
        message = "领养添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询领养信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("petObj") Pet petObj,@ModelAttribute("userObj") UserInfo userObj,String addTime,String shenHe,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (addTime == null) addTime = "";
		if (shenHe == null) shenHe = "";
		if(rows != 0)adoptService.setRows(rows);
		List<Adopt> adoptList = adoptService.queryAdopt(petObj, userObj, addTime, shenHe, page);
	    /*计算总的页数和总的记录数*/
	    adoptService.queryTotalPageAndRecordNumber(petObj, userObj, addTime, shenHe);
	    /*获取到总的页码数目*/
	    int totalPage = adoptService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = adoptService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Adopt adopt:adoptList) {
			JSONObject jsonAdopt = adopt.getJsonObject();
			jsonArray.put(jsonAdopt);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询领养信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Adopt> adoptList = adoptService.queryAllAdopt();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Adopt adopt:adoptList) {
			JSONObject jsonAdopt = new JSONObject();
			jsonAdopt.accumulate("adoptId", adopt.getAdoptId());
			jsonArray.put(jsonAdopt);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询领养信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("petObj") Pet petObj,@ModelAttribute("userObj") UserInfo userObj,String addTime,String shenHe,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (addTime == null) addTime = "";
		if (shenHe == null) shenHe = "";
		List<Adopt> adoptList = adoptService.queryAdopt(petObj, userObj, addTime, shenHe, currentPage);
	    /*计算总的页数和总的记录数*/
	    adoptService.queryTotalPageAndRecordNumber(petObj, userObj, addTime, shenHe);
	    /*获取到总的页码数目*/
	    int totalPage = adoptService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = adoptService.getRecordNumber();
	    request.setAttribute("adoptList",  adoptList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("petObj", petObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("addTime", addTime);
	    request.setAttribute("shenHe", shenHe);
	    List<Pet> petList = petService.queryAllPet();
	    request.setAttribute("petList", petList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Adopt/adopt_frontquery_result"; 
	}

     /*前台查询Adopt信息*/
	@RequestMapping(value="/{adoptId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer adoptId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键adoptId获取Adopt对象*/
        Adopt adopt = adoptService.getAdopt(adoptId);

        List<Pet> petList = petService.queryAllPet();
        request.setAttribute("petList", petList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("adopt",  adopt);
        return "Adopt/adopt_frontshow";
	}

	/*ajax方式显示领养修改jsp视图页*/
	@RequestMapping(value="/{adoptId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer adoptId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键adoptId获取Adopt对象*/
        Adopt adopt = adoptService.getAdopt(adoptId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonAdopt = adopt.getJsonObject();
		out.println(jsonAdopt.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新领养信息*/
	@RequestMapping(value = "/{adoptId}/update", method = RequestMethod.POST)
	public void update(@Validated Adopt adopt, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			adoptService.updateAdopt(adopt);
			message = "领养更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "领养更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除领养信息*/
	@RequestMapping(value="/{adoptId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer adoptId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  adoptService.deleteAdopt(adoptId);
	            request.setAttribute("message", "领养删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "领养删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条领养记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String adoptIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = adoptService.deleteAdopts(adoptIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出领养信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("petObj") Pet petObj,@ModelAttribute("userObj") UserInfo userObj,String addTime,String shenHe, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(addTime == null) addTime = "";
        if(shenHe == null) shenHe = "";
        List<Adopt> adoptList = adoptService.queryAdopt(petObj,userObj,addTime,shenHe);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Adopt信息记录"; 
        String[] headers = { "领养id","被领养宠物","领养人","领养申请时间","审核状态"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<adoptList.size();i++) {
        	Adopt adopt = adoptList.get(i); 
        	dataset.add(new String[]{adopt.getAdoptId() + "",adopt.getPetObj().getPetName(),adopt.getUserObj().getName(),adopt.getAddTime(),adopt.getShenHe()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Adopt.xls");//filename是下载的xls的名，建议最好用英文 
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
