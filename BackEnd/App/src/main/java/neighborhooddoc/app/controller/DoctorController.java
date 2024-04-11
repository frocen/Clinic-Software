package neighborhooddoc.app.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import neighborhooddoc.app.dao.DoctorMapper;
import neighborhooddoc.app.model.Doctor;
import neighborhooddoc.app.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class DoctorController {

    @Autowired
    private DoctorService doctorService;


    @GetMapping("/Doctor/{id}")
    public Doctor getDoctor(@RequestParam("id") String id){
        return doctorService.getById(id);
    }

    @GetMapping("/Doctor")
    public List<Doctor> getAllDoctor(){
        return doctorService.list(null);
    }

    @PostMapping("/Doctor")
    public void insertDoctor(@RequestParam("name") String name,@RequestParam("password") String password){
        Doctor doctor = new Doctor();
        doctor.setName(name);
        doctor.setPassword(password);
        doctorService.save(doctor);
    }
    @DeleteMapping("/Doctor/{id}")
    public void deleteDoctor(@RequestParam("id") String id){
        doctorService.removeById(id);
    }
    @PutMapping("/Doctor")
    public void updateDoctor(@RequestParam("id") String id, String name, String password){
        Doctor doctor = new Doctor();
        doctor.setId(id);
        if(name != null){
            doctor.setName(name);
        }
        if (password !=null) {
            doctor.setPassword(password);
        }
        QueryWrapper<Doctor> wrapper = new QueryWrapper<>();
        wrapper
                .eq("id",id);
        doctorService.update(doctor,wrapper);
    }

    @PostMapping("/Doctor/login")
    public Doctor login(@RequestParam("id") String id,@RequestParam("password") String password){
        return doctorService.login(id, password);
    }
}