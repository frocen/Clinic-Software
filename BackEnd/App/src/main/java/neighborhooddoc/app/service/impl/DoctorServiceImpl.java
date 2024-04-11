package neighborhooddoc.app.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import neighborhooddoc.app.dao.DoctorMapper;
import neighborhooddoc.app.model.Doctor;
import neighborhooddoc.app.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.print.Doc;
import java.util.HashMap;
import java.util.List;

@Service
public class DoctorServiceImpl extends ServiceImpl<DoctorMapper, Doctor> implements DoctorService {
    @Autowired
    private DoctorMapper doctorMapper;
    @Override
    public Doctor login(String id, String password) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("id",id);
        map.put("password",password);
        List<Doctor> doctors = doctorMapper.selectByMap(map);
//        if (doctors.isEmpty()){
//            throw;
//        }else {
//            return doctors.get(0);
//        }
        return doctors.get(0);
    }
}