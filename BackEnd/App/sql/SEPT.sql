DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS patient;
DROP TABLE IF EXISTS doctor;
DROP TABLE IF EXISTS medicine;
DROP TABLE IF EXISTS admin;
DROP TABLE IF EXISTS prescription;
DROP TABLE IF EXISTS consultation;


CREATE TABLE patient  (
                          id varchar(50),
                          name varchar(50),
                          password varchar(50),
                          status varchar(50),
                          PRIMARY KEY (`id`)
) ;
INSERT INTO patient (id, name, password, status) VALUES
                                                     (1, 'P1', "111", "1"),
                                                     (2, 'P2', "111", "2");



CREATE TABLE doctor  (
                         id varchar(50),
                         name varchar(50),
                         password varchar(50),
                         PRIMARY KEY (`id`)
) ;
INSERT INTO doctor (id, name, password) VALUES
                                            (1, 'D1', "111"),
                                            (2, 'D2', "111");



CREATE TABLE medicine  (
                           id varchar(50),
                           name varchar(100),
                           description varchar(500),
                           stock int(11),
                           PRIMARY KEY (`id`)
) ;
INSERT INTO medicine (id, name, description, stock) VALUES
                                                        (1, 'M1', "description", 100),
                                                        (2, 'M2', "description", 100);



CREATE TABLE admin (
                       id varchar(50),
                       name varchar(50),
                       password varchar(50),
                       PRIMARY KEY (`id`)
);
INSERT INTO admin (id, name, password) VALUES
    (1,'admin',"123");

CREATE TABLE booking (
                         doctor varchar(50),
                         patient varchar(50),
                         time varchar(50),
                         end varchar(50),
                         priority varchar(50)
);
INSERT INTO booking (doctor,patient,time,end,priority)VALUES(1, "", "2000-01-02 00:00:00.000", "2000-01-02 10:00:00.000", "");

CREATE TABLE prescription (
                              medicine varchar(50),
                              patient varchar(50),
                              quantity varchar(50)
);
INSERT INTO prescription (medicine,patient,quantity)VALUES("1", "1", "1");
CREATE TABLE consultation (
                              doctor varchar(50),
                              patient varchar(50),
                              text varchar(50)
);
INSERT INTO consultation (doctor,patient,text)VALUES("1", "1", "1");
