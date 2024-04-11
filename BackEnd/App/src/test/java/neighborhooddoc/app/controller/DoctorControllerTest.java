package neighborhooddoc.app.controller;

import neighborhooddoc.app.model.Doctor;
import neighborhooddoc.app.model.Medicine;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.print.Doc;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class DoctorControllerTest {
    @Autowired
    private DoctorController doctorController;
    @BeforeEach
    void setUp() {

    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void getDoctor() {
        Doctor doctor = doctorController.getDoctor("1");
        assertAll("doctor",
                ()->assertEquals("D1",doctor.getName()));
    }

    @Test
    void getAllDoctor() {
        List<Doctor> doctorList = doctorController.getAllDoctor();
        assertEquals(2,doctorList.size());


    }

    @Test
    void insertDoctor() {
        doctorController.insertDoctor("3","doctor1test");
        Doctor doctor = doctorController.getDoctor("3");
        assertEquals("3",doctor.getId());
    }

    @Test
    void deleteDoctor() {
        String deleteId = doctorController.getAllDoctor().get(1).getId();
        doctorController.deleteDoctor(deleteId);
        List<Doctor> allDoctor = doctorController.getAllDoctor();
        Doctor doctor = doctorController.getDoctor(deleteId);
        assertAll("doctor list",
                () -> assertEquals(2, allDoctor.size()),
                () -> assertEquals(null, doctor)
        );
    }

    @Test
    void updateDoctor() {

    }

    @Test
    void login() {
    }
}