package neighborhooddoc.app.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import neighborhooddoc.app.dao.DoctorMapper;
import neighborhooddoc.app.dao.MedicineMapper;
import neighborhooddoc.app.model.Doctor;
import neighborhooddoc.app.model.Medicine;
import neighborhooddoc.app.service.DoctorService;
import neighborhooddoc.app.service.MedicineService;
import org.springframework.stereotype.Service;

@Service
public class MedicineServiceImpl extends ServiceImpl<MedicineMapper, Medicine> implements MedicineService {
}