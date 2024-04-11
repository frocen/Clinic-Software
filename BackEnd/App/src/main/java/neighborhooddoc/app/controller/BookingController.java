package neighborhooddoc.app.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import neighborhooddoc.app.model.Booking;
import neighborhooddoc.app.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class BookingController {
    @Autowired
    private BookingService bookingService;
    @GetMapping("/Booking")
    public List<Booking> getAll(){
        System.out.println(bookingService.list(null));
        return bookingService.list(null);
    }

    @GetMapping("/Booking/patient")
    public List<Booking> getAllAvailableBookingForPatient(@RequestParam("docId") String docId){
        QueryWrapper<Booking> wrapper = new QueryWrapper<>();
        wrapper
                .and(i ->i.eq("patient", "").eq("priority" , "").eq("doctor",docId));
        return bookingService.list(wrapper);
    }
    @GetMapping("/Booking/doctor")
    public List<Booking> getAllWaitingBookingForDoctor(@RequestParam("docId") String docId){
        QueryWrapper<Booking> wrapper = new QueryWrapper<>();
        wrapper
                .and(i ->i.ne("patient", "").eq("priority" , "").eq("doctor",docId));
        return bookingService.list(wrapper);
    }
    @GetMapping("/Booking/doctor/done")
    public List<Booking> getAllFinishedBookingForDoctor(@RequestParam("docId") String docId){
        QueryWrapper<Booking> wrapper = new QueryWrapper<>();
        wrapper
                .and(i ->i.ne("patient", "").ne("priority" , "").eq("doctor",docId));
        return bookingService.list(wrapper);
    }
    @GetMapping("/Booking/patient/done")
    public List<Booking> getAllFinishedBookingForPatient(@RequestParam("patientId") String patientId){
        QueryWrapper<Booking> wrapper = new QueryWrapper<>();
        wrapper
                .and(i ->i.ne("patient", "").ne("priority" , "").eq("patient",patientId));
        return bookingService.list(wrapper);
    }
    @GetMapping("/Booking/doctor/orderedBooking")
    public List<Booking> getAllFinishedOrderedBookingForDoctor(@RequestParam("docId") String docId){
        QueryWrapper<Booking> wrapper = new QueryWrapper<>();
        wrapper
                .and(i ->i.ne("patient", "").ne("priority" , "").eq("doctor",docId))
                .orderByAsc("priority");
        return bookingService.list(wrapper);
    }
    @PostMapping("/Booking")
    public void insertBooking(@RequestParam("docId") String docId,
                              @RequestParam("start Time") String startTime,@RequestParam("endTimme") String endTime){
        bookingService.doctorCreateBooking(docId, startTime,endTime);
    }
    @PutMapping("/Booking/updatePatientId")
    public void changePatientId(@RequestParam("docId")String docId ,@RequestParam("patientId")String patientId, @RequestParam("dateTime") String date){
        bookingService.insertPatientId(docId, patientId, date);
    }
    @DeleteMapping("/Booking/deletePatientId")
    public void deletePatientId(@RequestParam("docId")String docId, @RequestParam("start Time") String date){
        Booking booking = new Booking();
        booking.setDoctor(docId);
        booking.setTime(date);
        booking.setPatient("");
        QueryWrapper<Booking> wrapper = new QueryWrapper<>();
        wrapper
                .and(i ->i.eq("doctor", docId).eq("time" , date));
        bookingService.update(booking,wrapper);
    }
    @PutMapping("/Booking/updatePriority")
    public void changePriority(@RequestParam("docId")String docId , @RequestParam("priority")String priority, @RequestParam("patientId")String patientId){
        Booking booking = new Booking();
        booking.setDoctor(docId);
        booking.setPatient(patientId);
        booking.setPriority(priority);
        QueryWrapper<Booking> wrapper = new QueryWrapper<>();
        wrapper
                .and(i ->i.eq("doctor", docId).eq("patient" , patientId));
        bookingService.update(booking,wrapper);
    }
    @PutMapping("/Booking/updatePriorityAuto")
    public void changePriorityAuto(@RequestParam("docId")String docId , @RequestParam("patientId")String patientId){
        Booking booking = new Booking();
        booking.setDoctor(docId);
        booking.setPatient(patientId);
        booking.setPriority("F");
        QueryWrapper<Booking> wrapper = new QueryWrapper<>();
        wrapper
                .and(i ->i.eq("doctor", docId).eq("patient" , patientId));
        bookingService.update(booking,wrapper);
    }

}
