package neighborhooddoc.app.service;

import com.baomidou.mybatisplus.extension.service.IService;
import neighborhooddoc.app.model.Prescription;
import org.springframework.web.bind.annotation.RequestParam;

public interface PrescriptionService extends IService<Prescription> {
    boolean CreatePrescription(String medicineId, String patientId, String quantity);

    boolean update(String medicineId, String patientId, String quantity);

}
