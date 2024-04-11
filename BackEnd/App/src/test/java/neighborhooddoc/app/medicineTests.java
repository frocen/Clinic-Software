package neighborhooddoc.app;

import neighborhooddoc.app.controller.MedicineController;
import neighborhooddoc.app.model.Medicine;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)

class medicineTests {
    @Autowired
    private MedicineController medicineController;
    @BeforeAll
    public static void init(){
        System.out.println("Before doing test, please reset database");
    }
    @Order(1)
    @Test
    public void testGetMedicine() {
        Medicine medicine = medicineController.getMedicine("1");
        assertAll("medicine",
                () -> assertEquals("M1", medicine.getName()),
                () -> assertEquals("description", medicine.getDescription()),
                () -> assertEquals(1, medicine.getStock())
        );
    }
    @Order(2)
    @Test
    public void testGetAllMedicine() {
        List<Medicine> allMedicine = medicineController.getAllMedicine();
        assertAll("medicine list",
                () -> assertEquals(2, allMedicine.size()),
                () -> assertEquals("M1", allMedicine.get(0).getName()),
                () -> assertEquals("M2", allMedicine.get(1).getName())
        );
    }
    @Order(3)
    @Test
    public void testInsertMedicine(){
        medicineController.insertMedicine("testInsertFunction","description");
        List<Medicine> allMedicine = medicineController.getAllMedicine();
        assertAll("medicine list",
                () -> assertEquals(3, allMedicine.size()),
                () -> assertEquals("testInsertFunction", allMedicine.get(2).getName()),
                () -> assertEquals("description", allMedicine.get(2).getDescription())
        );
    }
    @Order(4)
    @Test
    public void testDeleteMedicine(){
        String deleteId = medicineController.getAllMedicine().get(2).getId();
        medicineController.deleteMedicine(deleteId);
        List<Medicine> allMedicine = medicineController.getAllMedicine();
        Medicine medicine = medicineController.getMedicine(deleteId);
        assertAll("medicine list",
                () -> assertEquals(2, allMedicine.size()),
                () -> assertEquals(null, medicine)
        );
    }
    @Order(5)
    @Test
    public void testUpdateMedicineNameOnly(){
        medicineController.updateMedicine("1","updateName",null,null);
        Medicine medicine = medicineController.getMedicine("1");
        assertAll("medicine list",
                () -> assertEquals("updateName", medicine.getName()),
                () -> assertEquals("description", medicine.getDescription()),
                () -> assertEquals(1, medicine.getStock())
        );
    }
    @Order(6)
    @Test
    public void testUpdateMedicineDescriptionOnly(){
        medicineController.updateMedicine("1",null,"updateDescription",null);
        Medicine medicine = medicineController.getMedicine("1");
        assertAll("medicine list",
                () -> assertEquals("updateName", medicine.getName()),
                () -> assertEquals("updateDescription", medicine.getDescription()),
                () -> assertEquals(1, medicine.getStock())
        );
    }
    @Order(7)
    @Test
    public void testUpdateMedicineStockOnly(){
        medicineController.updateMedicine("1",null,null,100);
        Medicine medicine = medicineController.getMedicine("1");
        assertAll("medicine list",
                () -> assertEquals("updateName", medicine.getName()),
                () -> assertEquals("updateDescription", medicine.getDescription()),
                () -> assertEquals(100, medicine.getStock())
        );
    }
}
