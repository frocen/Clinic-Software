package neighborhooddoc.app.service;

import com.baomidou.mybatisplus.extension.service.IService;
import neighborhooddoc.app.model.Doctor;
import org.springframework.web.bind.annotation.RequestParam;

public interface DoctorService extends IService<Doctor>{
    public Doctor login(String name, String password);
}