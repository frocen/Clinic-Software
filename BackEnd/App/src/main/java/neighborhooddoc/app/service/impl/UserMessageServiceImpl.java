package neighborhooddoc.app.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import neighborhooddoc.app.dao.UserMessageMapper;
import neighborhooddoc.app.model.UserMessage;
import neighborhooddoc.app.service.UserMessageService;
import org.springframework.stereotype.Service;

/**
 * @Description
 */
@Service
public class UserMessageServiceImpl extends ServiceImpl<UserMessageMapper, UserMessage> implements UserMessageService {
}
