package neighborhooddoc.app.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import neighborhooddoc.app.model.Booking;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BookingMapper extends BaseMapper<Booking> {
}
