package neighborhooddoc.app.service;

import com.baomidou.mybatisplus.extension.service.IService;
import neighborhooddoc.app.model.Admin;
import neighborhooddoc.app.model.Doctor;

public interface AdminService extends IService<Admin> {
    public Admin login(String name, String password);

}