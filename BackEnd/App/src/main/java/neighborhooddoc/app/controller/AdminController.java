package neighborhooddoc.app.controller;

import neighborhooddoc.app.dao.AdminMapper;
import neighborhooddoc.app.model.Admin;
import neighborhooddoc.app.model.Doctor;
import neighborhooddoc.app.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AdminController {

    @Autowired
    private AdminService adminService;
    @PostMapping("/admin/login")
    public Admin login(@RequestParam("id") String id, @RequestParam("password") String password){
        return adminService.login(id, password);
    }
}
