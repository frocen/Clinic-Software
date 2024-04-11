package neighborhooddoc.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import neighborhooddoc.app.dao.BookingMapper;
import neighborhooddoc.app.dao.ConsultationMapper;
import neighborhooddoc.app.model.Booking;
import neighborhooddoc.app.model.Consultation;
import neighborhooddoc.app.service.ConsultationService;
import neighborhooddoc.app.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class ConsultationServiceImpl extends ServiceImpl<ConsultationMapper, Consultation> implements ConsultationService {
    @Autowired
    private ConsultationMapper consultationMapper;
    @Override
    public boolean writeConsultation(String docId, String patientId, String text) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("doctor",docId);
        map.put("patient",patientId);
        List<Consultation> consultations = consultationMapper.selectByMap(map);
        if (consultations.isEmpty()){
            Consultation consultation = new Consultation();
            consultation.setDoctor(docId);
            consultation.setPatient(patientId);
            consultation.setText(text);
            consultationMapper.insert(consultation);
            return true;
        }
        else {
            QueryWrapper<Consultation> wrapper = new QueryWrapper<>();
            wrapper
                    .and(i ->i.eq("doctor", docId).eq("patient" , patientId));
            Consultation consultation = new Consultation();
            consultation.setText(text);
            consultationMapper.update(consultation,wrapper);
            return false;
        }
    }
}
