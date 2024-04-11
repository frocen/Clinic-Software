package neighborhooddoc.app.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import neighborhooddoc.app.model.Patient;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PatientMapper extends BaseMapper<Patient> {

}
