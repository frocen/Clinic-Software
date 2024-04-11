package neighborhooddoc.app.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import neighborhooddoc.app.model.Admin;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper extends BaseMapper<Admin> {
    int deleteByPrimaryKey(Integer id);

    int insert(Admin record);
    int insertSelective(Admin record);
    Admin selectByPrimaryKey(Integer id);
    int updateByPrimaryKeySelective(Admin record);
    int updateByPrimaryKey(Admin record);
    Admin selectByName(String userName);
}