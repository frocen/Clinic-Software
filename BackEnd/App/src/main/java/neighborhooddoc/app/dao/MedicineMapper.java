package neighborhooddoc.app.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import neighborhooddoc.app.model.Medicine;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MedicineMapper extends BaseMapper<Medicine> {
}
