package neighborhooddoc.app.service;


import com.baomidou.mybatisplus.extension.service.IService;
import neighborhooddoc.app.model.Patient;

public interface PatientService extends IService<Patient> {
    public Patient login(String name, String password);
    public boolean create(String id, String name, String password);
}