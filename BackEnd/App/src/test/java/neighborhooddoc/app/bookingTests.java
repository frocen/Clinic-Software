package neighborhooddoc.app;

import neighborhooddoc.app.controller.BookingController;
import neighborhooddoc.app.model.Booking;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
@SpringBootTest
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class bookingTests {
    @Autowired
    private BookingController bookingController;
    @BeforeAll
    public static void init(){
        System.out.println("Before doing test, please reset database");
    }
    @Order(1)
    @Test
    public void testGetAllBookings() {
        List<Booking> bookings = bookingController.getAll();
        assertAll("Get all bookings",
                () -> assertEquals("1", bookings.get(0).getDoctor()),
                () -> assertEquals(1, bookings.size())
        );
    }
    @Order(2)
    @Test
    public void testCreateBooking() {
        bookingController.insertBooking("10","2000-01-12 00:00:00.000","2000-01-12 00:10:00.000");
        List<Booking> bookings = bookingController.getAll();
        assertAll("Create booking",
                () -> assertEquals("10", bookings.get(1).getDoctor()),
                () -> assertEquals("2000-01-12 00:00:00.000", bookings.get(1).getTime()),
                () -> assertEquals(2, bookings.size())
        );
    }
    @Order(3)
    @Test
    public void testCreateBookingTwice() {
        bookingController.insertBooking("10","2000-01-12 00:00:00.000","2000-01-12 00:10:00.000");
        bookingController.insertBooking("10","2000-01-12 00:00:00.000","2000-01-12 00:10:00.000");
        List<Booking> bookings = bookingController.getAll();
        assertAll("Create booking",
                () -> assertEquals("10", bookings.get(1).getDoctor()),
                () -> assertEquals("2000-01-12 00:00:00.000", bookings.get(1).getTime()),
                () -> assertEquals(2, bookings.size())
        );
    }
    @Order(4)
    @Test
    public void testGetAllAvailableBookingForPatient() {
        bookingController.insertBooking("10","2000-01-12 00:10:00.000","2000-01-12 00:10:00.000");
        bookingController.insertBooking("10","2000-01-12 00:20:00.000","2000-01-12 00:10:00.000");
        List<Booking> allAvailableBookingForPatient = bookingController.getAllAvailableBookingForPatient("10");
        assertAll("GetAllAvailableBookingForPatient",
                () -> assertEquals(3, allAvailableBookingForPatient.size())
        );
    }
    @Order(5)
    @Test
    public void testChangePatientIdAndGetAllWaitingBookingForDoctor() {
        bookingController.changePatientId("10","1","2000-01-12 00:00:00.000");
        bookingController.changePatientId("10","2","2000-01-12 00:10:00.000");
        List<Booking> allWaitingBookingForDoctor = bookingController.getAllWaitingBookingForDoctor("10");
        assertAll("test change patient Id And get all waiting booking for doctor",
                () -> assertEquals(2, allWaitingBookingForDoctor.size()),
                () -> assertEquals("1", allWaitingBookingForDoctor.get(0).getPatient()),
                () -> assertEquals("2", allWaitingBookingForDoctor.get(1).getPatient())
        );
    }
    @Order(6)
    @Test
    public void testDeletePatientIdAndGetAllWaitingBookingForDoctor() {
        bookingController.deletePatientId("10","2000-01-12 00:10:00.000");
        List<Booking> allWaitingBookingForDoctor = bookingController.getAllWaitingBookingForDoctor("10");
        assertAll("test delete patient Id And get all waiting booking for doctor",
                () -> assertEquals(1, allWaitingBookingForDoctor.size()),
                () -> assertEquals("1", allWaitingBookingForDoctor.get(0).getPatient())
        );
    }
    @Order(7)
    @Test
    public void testChangePriorityAndGetAllFinishedBookingForDoctorAndPatient() {
        bookingController.changePriority("10","A","1");
        List<Booking> allFinishedBookingForDoctor = bookingController.getAllFinishedBookingForDoctor("10");
        List<Booking> allFinishedBookingForPatient = bookingController.getAllFinishedBookingForPatient("1");
        assertAll("test change priority and get all finished booking for doctor and patient",
                () -> assertEquals(1, allFinishedBookingForDoctor.size()),
                () -> assertEquals(1, allFinishedBookingForPatient.size()),
                () -> assertEquals("A", allFinishedBookingForPatient.get(0).getPriority()),
                () -> assertEquals("A", allFinishedBookingForDoctor.get(0).getPriority()),
                () -> assertEquals(allFinishedBookingForDoctor.get(0), allFinishedBookingForPatient.get(0))
        );
    }
    @Order(8)
    @Test
    public void testAutoChangePriority() {
        bookingController.changePatientId("10","2","2000-01-12 00:10:00.000");
        bookingController.changePriorityAuto("10","2");
        List<Booking> allFinishedBookingForPatient = bookingController.getAllFinishedBookingForPatient("2");
        assertAll("when patient id inserted, priority update to F",
                () -> assertEquals(1, allFinishedBookingForPatient.size()),
                () -> assertEquals("F", allFinishedBookingForPatient.get(0).getPriority())
        );
    }
    @Order(9)
    @Test
    public void testGetAllFinishedOrderedBookingForDoctor() {
        //assume we have patient number 3
        bookingController.changePatientId("10","3","2000-01-12 00:20:00.000");
        bookingController.changePriority("10","B","3");
        List<Booking> allFinishedOrderedBookingForDoctor = bookingController.getAllFinishedOrderedBookingForDoctor("10");
        assertAll("get all finished ordered booking for doctor",
                () -> assertEquals(3, allFinishedOrderedBookingForDoctor.size()),
                () -> assertEquals("A", allFinishedOrderedBookingForDoctor.get(0).getPriority()),
                () -> assertEquals("B", allFinishedOrderedBookingForDoctor.get(1).getPriority()),
                () -> assertEquals("F", allFinishedOrderedBookingForDoctor.get(2).getPriority())
        );
    }
}
