package neighborhooddoc.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import neighborhooddoc.app.dao.BookingMapper;
import neighborhooddoc.app.dao.PatientMapper;
import neighborhooddoc.app.model.Booking;
import neighborhooddoc.app.model.Patient;
import neighborhooddoc.app.service.BookingService;
import neighborhooddoc.app.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class BookingServiceImpl extends ServiceImpl<BookingMapper, Booking> implements BookingService {
    @Autowired
    private BookingMapper bookingMapper;
    @Override
    public boolean doctorCreateBooking(String docId, String startTime,String endTime) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("doctor",docId);
        map.put("time",startTime);
        List<Booking> bookings = bookingMapper.selectByMap(map);
        if (bookings.isEmpty()){
            Booking booking = new Booking();
            booking.setDoctor(docId);
            booking.setPatient("");
            booking.setTime(startTime);
            booking.setEnd(endTime);
            booking.setPriority("");
            bookingMapper.insert(booking);
            return true;
        }
        else {
            return false;
        }
    }
    @Override
    public void insertPatientId(String docId, String patientId,String date) {
        QueryWrapper<Booking> wrapper = new QueryWrapper<>();
        wrapper
                .and(i ->i.eq("doctor", docId).eq("time" , date));
        Booking booking = new Booking();
        booking.setDoctor(docId);
        booking.setPatient(patientId);
        bookingMapper.update(booking,wrapper);
    }

}
