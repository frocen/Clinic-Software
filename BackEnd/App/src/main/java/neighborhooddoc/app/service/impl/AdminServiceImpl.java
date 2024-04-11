package neighborhooddoc.app.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import neighborhooddoc.app.dao.AdminMapper;
import neighborhooddoc.app.dao.DoctorMapper;
import neighborhooddoc.app.model.Admin;
import neighborhooddoc.app.model.Doctor;
import neighborhooddoc.app.service.AdminService;
import neighborhooddoc.app.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Admin login(String id, String password) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("id",id);
        map.put("password",password);
        List<Admin> admins = adminMapper.selectByMap(map);
//        if (doctors.isEmpty()){
//            throw;
//        }else {
//            return doctors.get(0);
//        }
        return admins.get(0);
    }
}