package neighborhooddoc.app.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import neighborhooddoc.app.model.Booking;
import neighborhooddoc.app.model.Consultation;
import neighborhooddoc.app.service.ConsultationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ConsultationController {
    @Autowired
    private ConsultationService consultationService;
    @GetMapping("/Consultation")
    public List<Consultation> getAllConsultationFromPatientForDoctor(@RequestParam("patientId") String patientId
    , @RequestParam("docId") String docId){
        QueryWrapper<Consultation> wrapper = new QueryWrapper<>();
        wrapper
                .and(i ->i.eq("patient" , patientId).eq("doctor",docId));
        return consultationService.list(wrapper);
    }
    @PostMapping("/Consultation")
    public void writeNewConsultation(@RequestParam("docId") String docId,
                                     @RequestParam("patientId") String patientId,@RequestParam("text") String text){
        consultationService.writeConsultation(docId, patientId,text);
    }
}
