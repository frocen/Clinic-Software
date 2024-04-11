package neighborhooddoc.app.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import neighborhooddoc.app.model.Patient;
import neighborhooddoc.app.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class PatientController {
    @Autowired
    private PatientService patientService;

    @GetMapping("/Patient/{id}")
    public Patient getPatient(@RequestParam("id") String id){
        return patientService.getById(id);
    }

    @GetMapping("/Patient")
    public List<Patient> getAllPatient(){
        return patientService.list(null);
    }
    @PostMapping("/Patient")
    public void insertPatient(@RequestParam("id") String id,@RequestParam("name") String name,@RequestParam("password") String password){
        patientService.create(id,name,password);
    }
    @DeleteMapping("/Patient/{id}")
    public void deletePatient(@RequestParam("id") String id){
        patientService.removeById(id);
    }
    @PutMapping("/Patient")
    public void updatePatient(@RequestParam("id") String id, String name, String password, String status){
        Patient patient = new Patient();
        patient.setId(id);
        if(name != null){
            patient.setName(name);
        }
        if (password !=null) {
            patient.setPassword(password);
        }
        if (status !=null) {
            patient.setStatus(status);
        }
        QueryWrapper<Patient> wrapper = new QueryWrapper<>();
        wrapper
                .eq("id",id);
        patientService.update(patient,wrapper);
    }

    @PostMapping("/Patient/login")
    public Patient login(@RequestParam("id") String id, @RequestParam("password") String password){
        return patientService.login(id, password);
    }
}