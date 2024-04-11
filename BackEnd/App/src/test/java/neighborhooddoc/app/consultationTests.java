package neighborhooddoc.app;

import neighborhooddoc.app.controller.ConsultationController;
import neighborhooddoc.app.model.Consultation;
import neighborhooddoc.app.model.Prescription;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class consultationTests {
    @Autowired
    private ConsultationController consultationController;
    @Order(2)
    @Test
    public void testGetAllConsultationFromPatientForDoctor() {
        List<Consultation> consultations = consultationController.getAllConsultationFromPatientForDoctor("1","1");
        assertAll("Get all consultations",
                () -> assertEquals(1, consultations.size())
        );
    }
    @Order(1)
    @Test
    public void testWriteConsultation() {
        consultationController.writeNewConsultation("1","1","consultation texts");
        List<Consultation> consultations = consultationController.getAllConsultationFromPatientForDoctor("1","1");
        assertAll("Create consultation",
                () -> assertEquals("1", consultations.get(0).getDoctor()),
                () -> assertEquals("consultation texts", consultations.get(0).getText()),
                () -> assertEquals("1", consultations.get(0).getPatient())
        );
    }
}
