package neighborhooddoc.app.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import neighborhooddoc.app.model.Medicine;
import neighborhooddoc.app.service.MedicineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class MedicineController {
    @Autowired
    private MedicineService medicineService;

    @GetMapping("/Medicine/{id}")
    public Medicine getMedicine(@RequestParam("id") String id){
        return medicineService.getById(id);
    }

    @GetMapping("/Medicine")
    public List<Medicine> getAllMedicine(){
        return medicineService.list(null);
    }

    @PostMapping("/Medicine")
    public void insertMedicine(@RequestParam("name") String name,@RequestParam("description") String description){
        Medicine medicine = new Medicine();
        medicine.setName(name);
        medicine.setDescription(description);
        medicine.setStock(10);
        medicineService.save(medicine);
    }
    @DeleteMapping("/Medicine/{id}")
    public void deleteMedicine(@RequestParam("id") String id){
        medicineService.removeById(id);
    }
    @PutMapping("/Medicine")
    public void updateMedicine(@RequestParam("id") String id, String name, String description, Integer stock){
        Medicine medicine = new Medicine();
        medicine.setId(id);
        if(name != null){
            medicine.setName(name);
        }
        if (description !=null) {
            medicine.setDescription(description);
        }
        if (stock!=null) {
            medicine.setStock(stock);
        }
        if (stock==null){
            Medicine oldMedicine = getMedicine(id);
            medicine.setStock(oldMedicine.getStock());
        }
        QueryWrapper<Medicine> wrapper = new QueryWrapper<>();
        wrapper
                .eq("id",id);
        medicineService.update(medicine,wrapper);
    }
}