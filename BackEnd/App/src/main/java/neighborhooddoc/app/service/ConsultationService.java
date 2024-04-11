package neighborhooddoc.app.service;

import com.baomidou.mybatisplus.extension.service.IService;
import neighborhooddoc.app.model.Consultation;

public interface ConsultationService extends IService<Consultation> {
    boolean writeConsultation(String docId, String patientId,String text);
}
