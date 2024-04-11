package neighborhooddoc.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import neighborhooddoc.app.dao.MedicineMapper;
import neighborhooddoc.app.dao.PrescriptionMapper;
import neighborhooddoc.app.model.Booking;
import neighborhooddoc.app.model.Medicine;
import neighborhooddoc.app.model.Prescription;
import neighborhooddoc.app.service.PrescriptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @Description
 */
@Service
public class PrescriptionServiceImpl extends ServiceImpl<PrescriptionMapper,Prescription>  implements PrescriptionService {
    @Autowired
    MedicineMapper medicineMapper;

    @Autowired
    PrescriptionMapper prescriptionMapper;

    @Override
    public boolean CreatePrescription(String medicineId, String patientId, String quantity) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("id",medicineId);
        List<Medicine> medicines = medicineMapper.selectByMap(map);
        if (medicines.get(0).getStock()<Integer.parseInt(quantity)){
            return false;
        }
        else {
            HashMap<String, Object> map2 = new HashMap<>();
            map2.put("medicine",medicineId);
            map2.put("patient",patientId);
            List<Prescription> prescriptions = prescriptionMapper.selectByMap(map2);
            if(prescriptions.isEmpty()){
            Prescription prescription = new Prescription();
            prescription.setMedicine(medicineId);
            prescription.setPatient(patientId);
            prescription.setQuantity(quantity);
            prescriptionMapper.insert(prescription);
            QueryWrapper<Medicine> wrapper = new QueryWrapper<>();
            wrapper
                    .eq("id", medicineId);
            Medicine medicine = new Medicine();
            medicine.setStock(medicines.get(0).getStock()-Integer.parseInt(quantity));
            medicineMapper.update(medicine,wrapper);
            return true;}else {
                return update(medicineId, patientId, quantity);
            }
        }
    }

    @Override
    public boolean update(String medicineId, String patientId, String quantity) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("id",medicineId);
        List<Medicine> medicines = medicineMapper.selectByMap(map);
        HashMap<String, Object> map2 = new HashMap<>();
        map2.put("medicine",medicineId);
        map2.put("patient",patientId);
        List<Prescription> prescriptions = prescriptionMapper.selectByMap(map2);
        if (medicines.get(0).getStock()+Integer.parseInt(prescriptions.get(0).getQuantity())<Integer.parseInt(quantity)){
            return false;
        }
        else {
            QueryWrapper<Prescription> wrapper1 = new QueryWrapper<>();
            wrapper1
                    .and(i ->i.eq("medicine", medicineId).eq("patient" , patientId));
            Prescription prescription = new Prescription();
            prescription.setMedicine(medicineId);
            prescription.setPatient(patientId);
            prescription.setQuantity(quantity);
            prescriptionMapper.update(prescription,wrapper1);
            QueryWrapper<Medicine> wrapper = new QueryWrapper<>();
            wrapper
                    .eq("id", medicineId);
            Medicine medicine = new Medicine();
            medicine.setStock(medicines.get(0).getStock()-Integer.parseInt(quantity)+Integer.parseInt(prescriptions.get(0).getQuantity()));
            medicineMapper.update(medicine,wrapper);
            return true;
        }
    }

}
