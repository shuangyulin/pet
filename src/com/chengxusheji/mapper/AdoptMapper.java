package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Adopt;

public interface AdoptMapper {
	/*添加领养信息*/
	public void addAdopt(Adopt adopt) throws Exception;

	/*按照查询条件分页查询领养记录*/
	public ArrayList<Adopt> queryAdopt(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有领养记录*/
	public ArrayList<Adopt> queryAdoptList(@Param("where") String where) throws Exception;

	/*按照查询条件的领养记录数*/
	public int queryAdoptCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条领养记录*/
	public Adopt getAdopt(int adoptId) throws Exception;

	/*更新领养记录*/
	public void updateAdopt(Adopt adopt) throws Exception;

	/*删除领养记录*/
	public void deleteAdopt(int adoptId) throws Exception;

}
