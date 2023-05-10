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
import com.chengxusheji.service.PetService;
import com.chengxusheji.po.Pet;
import com.chengxusheji.service.PetClassService;
import com.chengxusheji.po.PetClass;

//Pet管理控制层
@Controller
@RequestMapping("/Pet")
public class PetController extends BaseController {

    /*业务层对象*/
    @Resource PetService petService;

    @Resource PetClassService petClassService;
	@InitBinder("petClassObj")
	public void initBinderpetClassObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("petClassObj.");
	}
	@InitBinder("pet")
	public void initBinderPet(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("pet.");
	}
	/*跳转到添加Pet视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Pet());
		/*查询所有的PetClass信息*/
		List<PetClass> petClassList = petClassService.queryAllPetClass();
		request.setAttribute("petClassList", petClassList);
		return "Pet_add";
	}

	/*客户端ajax方式提交添加宠物信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Pet pet, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			pet.setPetPhoto(this.handlePhotoUpload(request, "petPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        petService.addPet(pet);
        message = "宠物添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询宠物信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("petClassObj") PetClass petClassObj,String petName,String petState,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (petName == null) petName = "";
		if (petState == null) petState = "";
		if (addTime == null) addTime = "";
		if(rows != 0)petService.setRows(rows);
		List<Pet> petList = petService.queryPet(petClassObj, petName, petState, addTime, page);
	    /*计算总的页数和总的记录数*/
	    petService.queryTotalPageAndRecordNumber(petClassObj, petName, petState, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = petService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = petService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Pet pet:petList) {
			JSONObject jsonPet = pet.getJsonObject();
			jsonArray.put(jsonPet);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询宠物信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Pet> petList = petService.queryAllPet();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Pet pet:petList) {
			JSONObject jsonPet = new JSONObject();
			jsonPet.accumulate("petId", pet.getPetId());
			jsonPet.accumulate("petName", pet.getPetName());
			jsonArray.put(jsonPet);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询宠物信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("petClassObj") PetClass petClassObj,String petName,String petState,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (petName == null) petName = "";
		if (petState == null) petState = "";
		if (addTime == null) addTime = "";
		List<Pet> petList = petService.queryPet(petClassObj, petName, petState, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    petService.queryTotalPageAndRecordNumber(petClassObj, petName, petState, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = petService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = petService.getRecordNumber();
	    request.setAttribute("petList",  petList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("petClassObj", petClassObj);
	    request.setAttribute("petName", petName);
	    request.setAttribute("petState", petState);
	    request.setAttribute("addTime", addTime);
	    List<PetClass> petClassList = petClassService.queryAllPetClass();
	    request.setAttribute("petClassList", petClassList);
		return "Pet/pet_frontquery_result"; 
	}

     /*前台查询Pet信息*/
	@RequestMapping(value="/{petId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer petId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键petId获取Pet对象*/
        Pet pet = petService.getPet(petId);

        List<PetClass> petClassList = petClassService.queryAllPetClass();
        request.setAttribute("petClassList", petClassList);
        request.setAttribute("pet",  pet);
        return "Pet/pet_frontshow";
	}

	/*ajax方式显示宠物修改jsp视图页*/
	@RequestMapping(value="/{petId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer petId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键petId获取Pet对象*/
        Pet pet = petService.getPet(petId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonPet = pet.getJsonObject();
		out.println(jsonPet.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新宠物信息*/
	@RequestMapping(value = "/{petId}/update", method = RequestMethod.POST)
	public void update(@Validated Pet pet, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String petPhotoFileName = this.handlePhotoUpload(request, "petPhotoFile");
		if(!petPhotoFileName.equals("upload/NoImage.jpg"))pet.setPetPhoto(petPhotoFileName); 


		try {
			petService.updatePet(pet);
			message = "宠物更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "宠物更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除宠物信息*/
	@RequestMapping(value="/{petId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer petId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  petService.deletePet(petId);
	            request.setAttribute("message", "宠物删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "宠物删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条宠物记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String petIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = petService.deletePets(petIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出宠物信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("petClassObj") PetClass petClassObj,String petName,String petState,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(petName == null) petName = "";
        if(petState == null) petState = "";
        if(addTime == null) addTime = "";
        List<Pet> petList = petService.queryPet(petClassObj,petName,petState,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Pet信息记录"; 
        String[] headers = { "宠物id","宠物类别","宠物名称","宠物照片","领养要求","领养状态","登记时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<petList.size();i++) {
        	Pet pet = petList.get(i); 
        	dataset.add(new String[]{pet.getPetId() + "",pet.getPetClassObj().getPetClassName(),pet.getPetName(),pet.getPetPhoto(),pet.getPetRequest(),pet.getPetState(),pet.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Pet.xls");//filename是下载的xls的名，建议最好用英文 
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
