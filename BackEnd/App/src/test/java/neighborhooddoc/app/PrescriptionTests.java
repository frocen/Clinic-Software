package neighborhooddoc.app;

import neighborhooddoc.app.controller.BookingController;
import neighborhooddoc.app.controller.MedicineController;
import neighborhooddoc.app.controller.PrescriptionController;
import neighborhooddoc.app.model.Booking;
import neighborhooddoc.app.model.Medicine;
import neighborhooddoc.app.model.Prescription;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class PrescriptionTests {
    @Autowired
    private PrescriptionController prescriptionController;

    @Autowired
    private MedicineController medicineController;
    @BeforeAll
    public static void init(){
        System.out.println("Before doing test, please reset database");
    }
    @Order(2)
    @Test
    public void testGetAllPrescriptionForPatient() {
        List<Prescription> prescriptions = prescriptionController.getAllPrescriptionForPatient("1");
        assertAll("Get all prescriptions",
                () -> assertEquals(1, prescriptions.size())
        );
    }
    @Order(1)
    @Test
    public void testPrescript() {
        boolean success=prescriptionController.prescript("1","1","10");
        List<Prescription> prescripts = prescriptionController.getAllPrescriptionForPatient("1");
        assertAll("Create Prescript",
                () -> assertEquals(true, success),
                () -> assertEquals("10", prescripts.get(0).getQuantity()),
                () -> assertEquals("1", prescripts.get(0).getPatient())
        );
    }
    @Order(3)
    @Test
    public void testUpdatePrescript() {
        boolean success = prescriptionController.updatePrescript("1","1","2");
        List<Prescription> prescriptions = prescriptionController.getAllPrescriptionForPatient("1");
        assertAll("test prescription quantity",
                () -> assertEquals(true, success),
                () -> assertEquals("2", prescriptions.get(0).getQuantity())
        );
    }
    @Order(4)
    @Test
    public void testMedicineChange() {
        Medicine medicine = medicineController.getMedicine("1");
        assertAll("Initial stock medicine of 1 is 100, after previous update and create, stock should be 99. Because init" +
                        "prescript quantity is 1, when create with 10 quantity, it actual update 9 more, and then"+
                "change to 2, actually only add 1, so medicine stock only -1.",
                () -> assertEquals(99, medicine.getStock())
        );
    }
}
