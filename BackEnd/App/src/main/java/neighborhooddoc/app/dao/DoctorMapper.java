package neighborhooddoc.app.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import neighborhooddoc.app.model.Doctor;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DoctorMapper extends BaseMapper<Doctor> {

}