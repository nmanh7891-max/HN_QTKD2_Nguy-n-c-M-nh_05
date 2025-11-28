
  -- PHẦN I – THIẾT KẾ VÀ KHỞI TẠO CSDL


-- CÂU 1 – TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
CREATE DATABASE ClinicDB;
USE ClinicDB;

-- Tạo bảng Patients 
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15)
);

-- Tạo bảng Doctors 
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Tạo bảng Appointments 
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    diagnosis VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);


   -- CÂU 2 - THÊM DỮ LIỆU

-- Patients 
INSERT INTO Patients (patient_name, age, gender, phone) VALUES
('Nguyen Van An', 25, 'Nam', '0901111111'),
('Tran Thi Binh', 30, 'Nu', '0902222222'),
('Le Van Cuong', 45, 'Nam', '0903333333'),
('Pham Thi Dung', 28, 'Nu', '0904444444'),
('Hoang Van Em', 60, 'Nam', '0905555555'),
('Do Thi Hoa', 55, 'Nu', '0906666666'),
('Vu Van Giang', 18, 'Nam', '0907777777'),
('Bui Thi Hang', 22, 'Nu', '0908888888'),
('Ngo Van Hung', 35, 'Nam', '0909999999'),
('Trinh Thi Khoi', 40, 'Nu', '0910000000');

-- Doctors 
INSERT INTO Doctors (doctor_name, specialization, salary) VALUES
('Dr. Le Minh', 'Noi khoa', 20000000),
('Dr. Pham Huong', 'Nhi khoa', 18000000),
('Dr. Tran Duc', 'Ngoai khoa', 25000000),
('Dr. Nguyen Lan', 'Da lieu', 15000000),
('Dr. Hoang Tuan', 'Tim mach', 30000000),
('Dr. Vu Mai', 'Than kinh', 28000000),
('Dr. Do Hung', 'Noi khoa', 19000000),
('Dr. Bui Thao', 'Nhi khoa', 17000000),
('Dr. Ngo Kien', 'Rang Ham Mat', 22000000),
('Dr. Trinh Ly', 'Mat', 16000000);

-- Appointments 
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, diagnosis) VALUES
(1, 1, '2024-01-10 08:30:00', 'Dau da day'),
(2, 2, '2024-01-11 09:00:00', 'Sot virus'),
(3, 3, '2024-01-12 10:15:00', 'Gay xuong tay'),
(4, 4, '2024-01-13 14:00:00', 'Di ung da'),
(5, 5, '2024-01-14 15:30:00', 'Tang huyet ap'),
(6, 6, '2024-01-15 08:00:00', 'Dau dau man tinh'),
(7, 7, '2024-01-16 11:00:00', 'Viem hong'),
(8, 8, '2024-01-17 13:45:00', 'Ho khan'),
(9, 9, '2024-01-18 16:00:00', 'Sau rang'),
(10, 10, '2023-12-20 09:30:00', 'Can thi');




  -- PHẦN 2 – THAO TÁC DỮ LIỆU (DML)


-- CÂU 3 - CẬP NHẬT DỮ LIỆU (10Đ)
-- 1.Cập nhật chuyên khoa (specialization) của bác sĩ có tên "Dr. Le Minh" thành "Noi tiet"
UPDATE Doctors
SET specialization = 'Noi tiet'
WHERE doctor_name = 'Dr. Le Minh';
-- 2.Cập nhật chẩn đoán (diagnosis) trong bảng Appointments của bệnh nhân có patient_id = 1 thành "Viem loet da day".
UPDATE Appointments
SET diagnosis = 'Viem loet da day'
WHERE patient_id = 1;

-- CÂU 4 - CẬP NHẬT DỮ LIỆU (5Đ)
-- 1.Xóa các lịch khám trong bảng Appointments có năm khám (appointment_date) là 2023.
DELETE FROM Appointments
WHERE YEAR(appointment_date) = 2023;
-- 2.Xóa bác sĩ có tên "Dr. Trinh Ly" khỏi bảng Doctors
DELETE FROM Doctors
WHERE doctor_name = 'Dr. Trinh Ly';




  -- PHẦN 3 – TRUY VẤN DỮ LIỆU

-- CÂU 5 - TRUY VẤN DỮ LIỆU CƠ BẢN

-- 1.Lấy ra danh sách các bác sĩ thuộc chuyên khoa (specialization) là "Noi khoa".
SELECT * FROM Doctors
WHERE specialization = 'Noi khoa';

-- 2.Lấy ra danh sách bệnh nhân là "Nam" và có tuổi (age) trên 30.
SELECT * FROM Patients
WHERE gender = 'Nam' AND age > 30;

-- 3.Tìm kiếm các bác sĩ có tên chứa chữ "Hung".
SELECT * FROM Doctors
WHERE doctor_name LIKE '%Hung%';

-- 4.Lấy ra danh sách các bệnh nhân sắp xếp theo tuổi (age) giảm dần.
SELECT * FROM Patients
ORDER BY age DESC;

-- 5.Lấy ra thông tin của 3 lịch khám mới nhất.
SELECT *
FROM Appointments
ORDER BY appointment_date DESC
LIMIT 3;




-- CÂU 6 - TRUY VẤN NHIỀU BẢNG


-- 1.Lấy ra danh sách gồm: Tên bệnh nhân (patient_name), Tên bác sĩ (doctor_name), Ngày khám (appointment_date) và Chẩn đoán (diagnosis).
SELECT p.patient_name, d.doctor_name, a.appointment_date, a.diagnosis
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- 2.Lấy ra tên bệnh nhân và chuyên khoa của bác sĩ mà bệnh nhân đó đã khám.
SELECT p.patient_name, d.specialization
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- 3.Hiển thị tên bác sĩ và chẩn đoán của những lịch khám trong tháng 01/2024.
SELECT d.doctor_name, a.diagnosis
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE MONTH(a.appointment_date) = 1
  AND YEAR(a.appointment_date) = 2024;

-- 4.Hiển thị danh sách các bệnh nhân đã khám tại chuyên khoa "Nhi khoa".
SELECT DISTINCT p.patient_name
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE d.specialization = 'Nhi khoa';



-- CÂU 7 TRUY VẤN GOM NHÓM

-- 1.Thống kê số lượng bác sĩ theo từng chuyên khoa (specialization).
SELECT specialization, COUNT(*) AS so_bac_si
FROM Doctors
GROUP BY specialization;

-- 2.Tính mức lương trung bình (salary) của tất cả các bác sĩ trong phòng khám.
SELECT AVG(salary) AS luong_trung_binh
FROM Doctors;

-- 3.Tìm những chuyên khoa (specialization) có từ 2 bác sĩ trở lên.
SELECT specialization, COUNT(*) AS so_bac_si
FROM Doctors
GROUP BY specialization
HAVING COUNT(*) >= 2;




-- CÂU 8 - TRUY VẤN LỒNG


-- 1.Tìm thông tin bác sĩ (doctor_name, salary) có mức lương cao nhất.
SELECT doctor_name, salary
FROM Doctors
WHERE salary = (SELECT MAX(salary) FROM Doctors);

-- 2.Lấy ra danh sách các bệnh nhân đăng kí nhiều lần nhất.
SELECT p.patient_name, COUNT(*) AS so_lan_kham
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
GROUP BY a.patient_id
ORDER BY so_lan_kham DESC;
