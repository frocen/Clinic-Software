package neighborhooddoc.app.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import neighborhooddoc.app.model.UserMessage;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMessageMapper extends BaseMapper<UserMessage> {
}
