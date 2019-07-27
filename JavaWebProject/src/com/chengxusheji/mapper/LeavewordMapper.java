package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Leaveword;

public interface LeavewordMapper {
	/*添加公共留言信息*/
	public void addLeaveword(Leaveword leaveword) throws Exception;

	/*按照查询条件分页查询公共留言记录*/
	public ArrayList<Leaveword> queryLeaveword(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有公共留言记录*/
	public ArrayList<Leaveword> queryLeavewordList(@Param("where") String where) throws Exception;

	/*按照查询条件的公共留言记录数*/
	public int queryLeavewordCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条公共留言记录*/
	public Leaveword getLeaveword(int leaveWordId) throws Exception;

	/*更新公共留言记录*/
	public void updateLeaveword(Leaveword leaveword) throws Exception;

	/*删除公共留言记录*/
	public void deleteLeaveword(int leaveWordId) throws Exception;

}
