package neighborhooddoc.app.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import neighborhooddoc.app.dao.PatientMapper;
import neighborhooddoc.app.model.Doctor;
import neighborhooddoc.app.model.Patient;
import neighborhooddoc.app.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class PatientServiceImpl extends ServiceImpl<PatientMapper, Patient> implements PatientService {
    @Autowired
    private PatientMapper patientMapper;
    @Override
    public Patient login(String id, String password) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("id",id);
        map.put("password",password);
        List<Patient> patients = patientMapper.selectByMap(map);
//        if (patients.isEmpty()){
//            throw;
//        }else {
//            return patients.get(0);
//        }
        return patients.get(0);
    }

    @Override
    public boolean create(String id, String name, String password) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("id",id);
        map.put("password",password);
        List<Patient> patients = patientMapper.selectByMap(map);
        if (patients.isEmpty()){
            Patient patient = new Patient();
            patient.setId(id);
            patient.setName(name);
            patient.setPassword(password);
            patientMapper.insert(patient);
            return true;
        }
        else {
            return false;
        }
    }
}