package neighborhooddoc.app.service;

import com.baomidou.mybatisplus.extension.service.IService;
import neighborhooddoc.app.model.Booking;

import java.awt.print.Book;
import java.util.Date;

public interface BookingService extends IService<Booking> {
    boolean doctorCreateBooking(String docId, String startTime,String endTime);
    void insertPatientId(String docId, String patientId, String date);
}
