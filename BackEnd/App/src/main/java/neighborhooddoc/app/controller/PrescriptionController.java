package neighborhooddoc.app.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import neighborhooddoc.app.common.ApiRestResponse;
import neighborhooddoc.app.model.Booking;
import neighborhooddoc.app.model.Doctor;
import neighborhooddoc.app.model.Prescription;
import neighborhooddoc.app.service.MedicineService;
import neighborhooddoc.app.service.PrescriptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class PrescriptionController {
    @Autowired
    private PrescriptionService prescriptionService;
    @GetMapping("/prescription/patient")
    public List<Prescription> getAllPrescriptionForPatient(@RequestParam("patientId") String patientId){
        QueryWrapper<Prescription> wrapper = new QueryWrapper<>();
        wrapper
                .eq("patient",patientId);
        return prescriptionService.list(wrapper);
    }
    @PostMapping("/prescription/doctor")
    public boolean prescript(@RequestParam("medicineId")String medicineId, @RequestParam("patientId")String patientId,
                             @RequestParam("quantity")String quantity) {
        return prescriptionService.CreatePrescription(medicineId, patientId, quantity);
    }
    @PutMapping("/prescription/update")
    public boolean updatePrescript(@RequestParam("medicineId")String medicineId, @RequestParam("patientId")String patientId,
                             @RequestParam("quantity")String quantity) {
        return prescriptionService.update(medicineId, patientId, quantity);
    }
}
