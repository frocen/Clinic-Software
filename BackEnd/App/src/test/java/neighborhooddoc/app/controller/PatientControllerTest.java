package neighborhooddoc.app.controller;

import neighborhooddoc.app.model.Doctor;
import neighborhooddoc.app.model.Patient;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.nio.file.Path;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class PatientControllerTest {
    @Autowired
    private PatientController patientController;
    @BeforeEach
    void setUp() {
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void getPatient() {
        Patient patient = patientController.getPatient("1");
        assertAll("patient",
                ()->assertEquals("P1",patient.getName()));

    }

    @Test
    void getAllPatient() {
        List<Patient> patients = patientController.getAllPatient();
        assertEquals(2,patients.size());
    }

    @Test
    void insertPatient() {
        patientController.insertPatient("3","test1","123");
        Patient patient = patientController.getPatient("3");
        assertEquals("3",patient.getId());
    }

    @Test
    void deletePatient() {
        String deleteId = patientController.getAllPatient().get(2).getId();
        patientController.deletePatient(deleteId);
        List<Patient> allPatient = patientController.getAllPatient();
        Patient patient = patientController.getPatient(deleteId);
        assertAll("patient list",
                () -> assertEquals(2, allPatient.size()),
                () -> assertEquals(null, patient)
        );
    }

    @Test
    void updatePatient() {
    }

    @Test
    void login() {
    }
}