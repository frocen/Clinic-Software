package neighborhooddoc.app.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import neighborhooddoc.app.model.Prescription;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PrescriptionMapper extends BaseMapper<Prescription> {
}
