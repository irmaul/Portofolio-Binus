-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2023 at 11:21 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel_grand_mercure`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Daftar_Pimpinan_Hotel` ()   BEGIN
	SELECT karyawan.ID_Karyawan, leaders.NamaLengkap, leaders.Alamat, leaders.Jabatan
    FROM leaders
    INNER JOIN karyawan ON leaders.ID_Leaders=karyawan.ID_Leaders;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Daftar_Reservasi_BulanMaret` ()   BEGIN
    SELECT pelanggan.NamaLengkap,pesananpelanggan.ID_Customer,pesananpelanggan.JumlahPelanggan, resepsionis.TanggalTransaksi
    FROM pesananpelanggan
INNER JOIN pelanggan ON pesananpelanggan.ID_Customer=pelanggan.ID_Customer
INNER JOIN resepsionis ON pesananpelanggan.ID_Customer=resepsionis.ID_Customer
    WHERE TanggalMasuk BETWEEN '2023-03-01' AND '2023-03-31';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TopSpendingCustomer_In_March` ()   BEGIN
SELECT
	pesananpelanggan.ID_Reservasi,
	pelanggan.ID_Customer,
    pelanggan.NamaLengkap,
    pesananpelanggan.TanggalMasuk AS TanggalTransaksi,
    SUM(pesananpelanggan.TotalPembayaran)AS TotalPengeluaran
FROM 
	pelanggan
JOIN
	pesananpelanggan ON pelanggan.ID_Customer=pesananpelanggan.ID_Customer
WHERE
	pesananpelanggan.TanggalMasuk BETWEEN '2023-03-01'AND'2023-03-31'
GROUP BY
	pelanggan.ID_Customer, pelanggan.NamaLengkap
ORDER BY
	TotalPengeluaran DESC
    LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Total_Penjualan_Pendapatan` ()   BEGIN
    -- Total Pemesanan Restoran
    SELECT
        COUNT(ID_PemesananResto) AS TotalPesananResto
    FROM
        pesananpelanggan
    WHERE
        ID_PemesananResto IS NOT NULL;

    -- Total Pemesanan Hotel
    SELECT
        COUNT(ID_PemesananHotel) AS TotalPesananHotel
    FROM
        pesananpelanggan
    WHERE
        ID_PemesananHotel IS NOT NULL;

    -- Total Pendapatan
    SELECT
        SUM(TotalPembayaran) AS TotalPendapatan
    FROM
        pesananpelanggan;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `countStaff` () RETURNS INT(11)  BEGIN
    DECLARE staffCount INT;
    SELECT COUNT(DISTINCT ID_staff) INTO staffCount FROM karyawan;
    RETURN staffCount;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `countStaffkitchen` () RETURNS INT(11)  BEGIN
    DECLARE staffCountkitchen INT;
    SELECT COUNT(DISTINCT ID_staffKC) INTO staffCountkitchen FROM karyawan;
    RETURN staffCountkitchen;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `Total_Pemasukan_Hotel` () RETURNS INT(11)  BEGIN
    DECLARE totalSum INT;
    SELECT SUM(TotalPembayaran) INTO totalSum FROM pembayaran;
    RETURN totalSum;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cash`
--

CREATE TABLE `cash` (
  `ID_Cash` char(5) NOT NULL,
  `NamaPemesan` varchar(50) NOT NULL,
  `TotalPembayaran` int(11) NOT NULL CHECK (`ID_Cash` regexp '^CA[0-9][0-9][0-9]$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cash`
--

INSERT INTO `cash` (`ID_Cash`, `NamaPemesan`, `TotalPembayaran`) VALUES
('CA001', 'Daniel Hendra', 400000),
('CA002', 'Kusnadi', 5000000),
('CA003', 'Sekar Mahalini', 6000000),
('CA004', 'Putri Febriyani', 550000),
('CA005', 'Reyna', 12000000),
('CA006', 'Siti Aisyah', 650000),
('CA007', 'Rizky Pratama', 4000000),
('CA008', 'Dian Purnama', 300000),
('CA009', 'Rina Indah', 1000000),
('CA010', 'Yoga Prakasa', 4000000),
('CA011', 'John Doe', 2000000),
('CA012', 'Michael Johnson', 5000000);

-- --------------------------------------------------------

--
-- Table structure for table `creditcard`
--

CREATE TABLE `creditcard` (
  `ID_CC` char(5) NOT NULL,
  `NomorCC` int(11) NOT NULL,
  `NamaOwnerCC` varchar(50) NOT NULL,
  `TotalPembayaran` int(11) NOT NULL CHECK (`ID_CC` regexp '^CC[0-9][0-9][0-9]$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `creditcard`
--

INSERT INTO `creditcard` (`ID_CC`, `NomorCC`, `NamaOwnerCC`, `TotalPembayaran`) VALUES
('CC001', 96511, 'Jamaludin', 10000000),
('CC002', 17632, 'Lavender Adelya', 400000),
('CC003', 67541, 'Monica Thilda', 4000000),
('CC004', 64312, 'Ni Ketut Gusti', 770000),
('CC005', 88754, 'I Made Andika', 2000000),
('CC006', 23987, 'Anisa Fitriani', 640000),
('CC007', 12301, 'Eko Wahyudi', 1000000),
('CC008', 14578, 'Rizal Malik', 6000000),
('CC009', 44881, 'Siska Putri', 400000),
('CC010', 87312, 'Siti Hidayah', 7800000),
('CC011', 78652, 'Emily Davis', 800000),
('CC012', 19653, 'Amanda Chen', 6000000);

-- --------------------------------------------------------

--
-- Table structure for table `departemendapur`
--

CREATE TABLE `departemendapur` (
  `ID_StaffKC` char(5) NOT NULL,
  `NamaLengkap` varchar(50) NOT NULL,
  `Alamat` varchar(100) NOT NULL,
  `JenisKelamin` varchar(10) NOT NULL,
  `JabatanStaff` varchar(50) NOT NULL,
  `Gaji` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departemendapur`
--

INSERT INTO `departemendapur` (`ID_StaffKC`, `NamaLengkap`, `Alamat`, `JenisKelamin`, `JabatanStaff`, `Gaji`) VALUES
('DD001', 'I Nyoman Sudana', 'Jalan Legian No. 123', 'Male', 'Chef', 12000000),
('DD002', 'Ayu Kusuma', 'Jalan Monkey Forest No. 456', 'Female', 'Sous Chef', 10000000),
('DD003', 'Agus Setiawan', 'Jalan Seminyak No. 789', 'Male', 'Line Cook', 8000000),
('DD004', 'Dewi Mustika', 'Jalan Uluwatu No. 101', 'Female', 'Pastry Chef', 9500000),
('DD005', 'Adi Nugroho', 'Jalan Petitenget No. 222', 'Male', 'Dishwasher', 7000000),
('DD006', 'Ni Ketut Sari', 'Jalan Ubud No. 333', 'Female', 'Waiter', 8500000),
('DD007', 'Wayan Gede', 'Jalan Jimbaran No. 444', 'Male', 'Bartender', 9000000),
('DD008', 'Ni Komang Ayu', 'Jalan Sanur No. 555', 'Female', 'Host/Hostess', 8000000),
('DD009', 'Bambang Gunarto', 'Jalan Kuta No. 666', 'Male', 'Sous Chef', 7500000),
('DD010', 'Ni Wayan Ari', 'Jalan Nusa Dua No. 777', 'Female', 'Sous Chef', 8500000),
('DD011', 'I Made Wijaya', 'Jalan Canggu No. 888', 'Male', 'Kitchen Manager', 11000000),
('DD012', 'Putri Rasyid', 'Jalan Renon No. 999', 'Female', 'Food Expeditor', 9000000),
('DD013', 'Muhammad Arjuna', 'Jalan Kerobokan No. 111', 'Male', 'Chef', 12000000),
('DD014', 'Reyna Ayu', 'Jalan Tanah Lot No. 222', 'Female', 'Chef', 12000000),
('DD015', 'Fadjar Prasetyo', 'Jalan Umalas No. 333', 'Male', 'Chef', 12000000),
('DD016', 'Maman Blinding', 'Jalan Maninjau No. 234', 'Female', 'Chef', 12000000),
('DD017', 'Inong Rami', 'Jalan Amed No. 555', 'Male', 'Barista', 8000000),
('DD018', 'Andik Yanto', 'Jalan Lovina No. 666', 'Female', 'Chef', 12000000),
('DD019', 'Bryan Kaka', 'Jalan Candidasa No. 777', 'Male', 'Line Cook', 8000000),
('DD020', 'Gustavo', 'Jalan Tulamben No. 888', 'Female', 'Chef', 12000000);

-- --------------------------------------------------------

--
-- Table structure for table `hotelmanagement`
--

CREATE TABLE `hotelmanagement` (
  `ID_Receipt` char(5) DEFAULT NULL,
  `ID_Karyawan` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotelmanagement`
--

INSERT INTO `hotelmanagement` (`ID_Receipt`, `ID_Karyawan`) VALUES
('RC001', NULL),
('RC002', NULL),
('RC003', NULL),
('RC004', NULL),
('RC005', NULL),
('RC006', NULL),
('RC007', NULL),
('RC008', NULL),
('RC009', NULL),
('RC010', NULL),
('RC011', NULL),
('RC012', NULL),
('RC013', NULL),
('RC014', NULL),
('RC015', NULL),
('RC016', NULL),
('RC017', NULL),
('RC018', NULL),
('RC019', NULL),
('RC020', NULL),
('RC021', NULL),
('RC022', NULL),
('RC023', NULL),
('RC024', NULL),
('RC025', NULL),
('RC026', NULL),
('RC027', NULL),
('RC028', NULL),
('RC029', NULL),
('RC030', NULL),
('RC031', NULL),
('RC032', NULL),
('RC033', NULL),
('RC034', NULL),
('RC035', NULL),
('RC036', NULL),
(NULL, 'KR001'),
(NULL, 'KR002'),
(NULL, 'KR003'),
(NULL, 'KR004'),
(NULL, 'KR005'),
(NULL, 'KR006'),
(NULL, 'KR007'),
(NULL, 'KR008'),
(NULL, 'KR009'),
(NULL, 'KR010'),
(NULL, 'KR011'),
(NULL, 'KR012'),
(NULL, 'KR013'),
(NULL, 'KR014'),
(NULL, 'KR015'),
(NULL, 'KR016'),
(NULL, 'KR017'),
(NULL, 'KR018'),
(NULL, 'KR019'),
(NULL, 'KR020'),
(NULL, 'KR021'),
(NULL, 'KR022'),
(NULL, 'KR023'),
(NULL, 'KR024'),
(NULL, 'KR025'),
(NULL, 'KR026'),
(NULL, 'KR027'),
(NULL, 'KR028'),
(NULL, 'KR029'),
(NULL, 'KR030'),
(NULL, 'KR031'),
(NULL, 'KR032'),
(NULL, 'KR033'),
(NULL, 'KR034'),
(NULL, 'KR035'),
(NULL, 'KR036'),
(NULL, 'KR037'),
(NULL, 'KR038'),
(NULL, 'KR039'),
(NULL, 'KR040'),
(NULL, 'KR041'),
(NULL, 'KR042'),
(NULL, 'KR043'),
(NULL, 'KR044'),
(NULL, 'KR045'),
(NULL, 'KR046'),
(NULL, 'KR047'),
(NULL, 'KR049'),
(NULL, 'KR050'),
(NULL, 'KR051'),
(NULL, 'KR052'),
('RC001', NULL),
('RC002', NULL),
('RC003', NULL),
('RC004', NULL),
('RC005', NULL),
('RC006', NULL),
('RC007', NULL),
('RC008', NULL),
('RC009', NULL),
('RC010', NULL),
('RC011', NULL),
('RC012', NULL),
('RC013', NULL),
('RC014', NULL),
('RC015', NULL),
('RC016', NULL),
('RC017', NULL),
('RC018', NULL),
('RC019', NULL),
('RC020', NULL),
('RC021', NULL),
('RC022', NULL),
('RC023', NULL),
('RC024', NULL),
('RC025', NULL),
('RC026', NULL),
('RC027', NULL),
('RC028', NULL),
('RC029', NULL),
('RC030', NULL),
('RC031', NULL),
('RC032', NULL),
('RC033', NULL),
('RC034', NULL),
('RC035', NULL),
('RC036', NULL),
(NULL, 'KR001'),
(NULL, 'KR002'),
(NULL, 'KR003'),
(NULL, 'KR004'),
(NULL, 'KR005'),
(NULL, 'KR006'),
(NULL, 'KR007'),
(NULL, 'KR008'),
(NULL, 'KR009'),
(NULL, 'KR010'),
(NULL, 'KR011'),
(NULL, 'KR012'),
(NULL, 'KR013'),
(NULL, 'KR014'),
(NULL, 'KR015'),
(NULL, 'KR016'),
(NULL, 'KR017'),
(NULL, 'KR018'),
(NULL, 'KR019'),
(NULL, 'KR020'),
(NULL, 'KR021'),
(NULL, 'KR022'),
(NULL, 'KR023'),
(NULL, 'KR024'),
(NULL, 'KR025'),
(NULL, 'KR026'),
(NULL, 'KR027'),
(NULL, 'KR028'),
(NULL, 'KR029'),
(NULL, 'KR030'),
(NULL, 'KR031'),
(NULL, 'KR032'),
(NULL, 'KR033'),
(NULL, 'KR034'),
(NULL, 'KR035'),
(NULL, 'KR036'),
(NULL, 'KR037'),
(NULL, 'KR038'),
(NULL, 'KR039'),
(NULL, 'KR040'),
(NULL, 'KR041'),
(NULL, 'KR042'),
(NULL, 'KR043'),
(NULL, 'KR044'),
(NULL, 'KR045'),
(NULL, 'KR046'),
(NULL, 'KR047'),
(NULL, 'KR049'),
(NULL, 'KR050'),
(NULL, 'KR051'),
(NULL, 'KR052'),
('RC001', NULL),
('RC002', NULL),
('RC003', NULL),
('RC004', NULL),
('RC005', NULL),
('RC006', NULL),
('RC007', NULL),
('RC008', NULL),
('RC009', NULL),
('RC010', NULL),
('RC011', NULL),
('RC012', NULL),
('RC013', NULL),
('RC014', NULL),
('RC015', NULL),
('RC016', NULL),
('RC017', NULL),
('RC018', NULL),
('RC019', NULL),
('RC020', NULL),
('RC021', NULL),
('RC022', NULL),
('RC023', NULL),
('RC024', NULL),
('RC025', NULL),
('RC026', NULL),
('RC027', NULL),
('RC028', NULL),
('RC029', NULL),
('RC030', NULL),
('RC031', NULL),
('RC032', NULL),
('RC033', NULL),
('RC034', NULL),
('RC035', NULL),
('RC036', NULL),
(NULL, 'KR001'),
(NULL, 'KR002'),
(NULL, 'KR003'),
(NULL, 'KR004'),
(NULL, 'KR005'),
(NULL, 'KR006'),
(NULL, 'KR007'),
(NULL, 'KR008'),
(NULL, 'KR009'),
(NULL, 'KR010'),
(NULL, 'KR011'),
(NULL, 'KR012'),
(NULL, 'KR013'),
(NULL, 'KR014'),
(NULL, 'KR015'),
(NULL, 'KR016'),
(NULL, 'KR017'),
(NULL, 'KR018'),
(NULL, 'KR019'),
(NULL, 'KR020'),
(NULL, 'KR021'),
(NULL, 'KR022'),
(NULL, 'KR023'),
(NULL, 'KR024'),
(NULL, 'KR025'),
(NULL, 'KR026'),
(NULL, 'KR027'),
(NULL, 'KR028'),
(NULL, 'KR029'),
(NULL, 'KR030'),
(NULL, 'KR031'),
(NULL, 'KR032'),
(NULL, 'KR033'),
(NULL, 'KR034'),
(NULL, 'KR035'),
(NULL, 'KR036'),
(NULL, 'KR037'),
(NULL, 'KR038'),
(NULL, 'KR039'),
(NULL, 'KR040'),
(NULL, 'KR041'),
(NULL, 'KR042'),
(NULL, 'KR043'),
(NULL, 'KR044'),
(NULL, 'KR045'),
(NULL, 'KR046'),
(NULL, 'KR047'),
(NULL, 'KR049'),
(NULL, 'KR050'),
(NULL, 'KR051'),
(NULL, 'KR052');

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `ID_Karyawan` char(5) NOT NULL,
  `NamaPanggilan` varchar(50) NOT NULL,
  `ID_Leaders` char(5) DEFAULT NULL,
  `ID_Staff` char(5) DEFAULT NULL,
  `ID_StaffKC` char(5) DEFAULT NULL,
  `TanggalMasuk` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`ID_Karyawan`, `NamaPanggilan`, `ID_Leaders`, `ID_Staff`, `ID_StaffKC`, `TanggalMasuk`) VALUES
('KR001', 'Mr. Wildan', 'LD001', NULL, NULL, '2023-01-10'),
('KR002', 'Mr. Iqbal', 'LD002', NULL, NULL, '2023-01-12'),
('KR003', 'Mr. Hafiz', 'LD003', NULL, NULL, '2023-01-13'),
('KR004', 'Mr. John', 'LD004', NULL, NULL, '2023-01-14'),
('KR005', 'Mrs. Emily', 'LD005', NULL, NULL, '2023-01-16'),
('KR006', 'Mr. Smith', 'LD006', NULL, NULL, '2023-01-17'),
('KR007', 'Mrs. Sophia', 'LD007', NULL, NULL, '2023-01-20'),
('KR008', 'Mr. Daniel', 'LD008', NULL, NULL, '2023-01-20'),
('KR009', 'Mrs. Roberta', 'LD009', NULL, NULL, '2023-01-20'),
('KR010', 'Mr. Alex', 'LD010', NULL, NULL, '2023-01-20'),
('KR011', 'Mrs. Olivia', 'LD011', NULL, NULL, '2023-01-20'),
('KR012', 'Mr. Victor', 'LD012', NULL, NULL, '2023-01-20'),
('KR013', 'Mr. Jason', NULL, 'ST001', NULL, '2023-01-25'),
('KR014', 'Mrs. Emma', NULL, 'ST002', NULL, '2023-01-25'),
('KR015', 'Mr. Christopher', NULL, 'ST003', NULL, '2023-01-25'),
('KR016', 'Mrs. Sophia', NULL, 'ST004', NULL, '2023-01-25'),
('KR017', 'Mr. Matthew', NULL, 'ST005', NULL, '2023-01-25'),
('KR018', 'Mrs. Olivia', NULL, 'ST006', NULL, '2023-01-25'),
('KR019', 'Mr. Ethan', NULL, 'ST007', NULL, '2023-01-25'),
('KR020', 'Mrs. Isabella', NULL, 'ST008', NULL, '2023-01-25'),
('KR021', 'Mr. Ryan', NULL, 'ST009', NULL, '2023-01-25'),
('KR022', 'Mrs. Aria', NULL, 'ST010', NULL, '2023-01-25'),
('KR023', 'Mr. Liam', NULL, 'ST011', NULL, '2023-01-25'),
('KR024', 'Mrs. Ava', NULL, 'ST012', NULL, '2023-01-25'),
('KR025', 'Mr. Logan', NULL, 'ST013', NULL, '2023-01-25'),
('KR026', 'Mrs. Ella', NULL, 'ST014', NULL, '2023-01-25'),
('KR027', 'Mr. Jackson', NULL, 'ST015', NULL, '2023-01-25'),
('KR028', 'Mrs. Sophie', NULL, 'ST016', NULL, '2023-01-25'),
('KR029', 'Mr. Lucas', NULL, 'ST017', NULL, '2023-01-25'),
('KR030', 'Mrs. Lily', NULL, 'ST018', NULL, '2023-01-25'),
('KR031', 'Mr. Mason', NULL, 'ST019', NULL, '2023-01-25'),
('KR032', 'Mrs. Grace', NULL, 'ST020', NULL, '2023-01-25'),
('KR033', 'Mr. Sudana', NULL, NULL, 'DD001', '2023-01-28'),
('KR034', 'Mrs. Ayu', NULL, NULL, 'DD002', '2023-01-28'),
('KR035', 'Mr. Setiawan', NULL, NULL, 'DD003', '2023-01-28'),
('KR036', 'Mrs. Mustika', NULL, NULL, 'DD004', '2023-01-28'),
('KR037', 'Mr. Nugroho', NULL, NULL, 'DD005', '2023-01-28'),
('KR038', 'Mrs. Sari', NULL, NULL, 'DD006', '2023-01-28'),
('KR039', 'Mr. Gede', NULL, NULL, 'DD007', '2023-01-28'),
('KR040', 'Mrs. Ayu', NULL, NULL, 'DD008', '2023-01-28'),
('KR041', 'Mr. Gunarto', NULL, NULL, 'DD009', '2023-01-28'),
('KR042', 'Mrs. Ari', NULL, NULL, 'DD010', '2023-01-28'),
('KR043', 'Mr. Wijaya', NULL, NULL, 'DD011', '2023-01-28'),
('KR044', 'Mrs. Rasyid', NULL, NULL, 'DD012', '2023-01-28'),
('KR045', 'Mr. Arjuna', NULL, NULL, 'DD013', '2023-01-28'),
('KR046', 'Mrs. Ayu', NULL, NULL, 'DD014', '2023-01-28'),
('KR047', 'Mr. Prasetyo', NULL, NULL, 'DD015', '2023-01-28'),
('KR048', 'Mr. Maman', NULL, NULL, 'DD016', '2023-01-28'),
('KR049', 'Mr. Rami', NULL, NULL, 'DD017', '2023-01-28'),
('KR050', 'Mrs. Yanto', NULL, NULL, 'DD018', '2023-01-28'),
('KR051', 'Mr. Kaka', NULL, NULL, 'DD019', '2023-01-28'),
('KR052', 'Mr. Gustavo', NULL, NULL, 'DD020', '2023-01-28');

-- --------------------------------------------------------

--
-- Table structure for table `leaders`
--

CREATE TABLE `leaders` (
  `ID_Leaders` char(5) NOT NULL,
  `NamaLengkap` varchar(50) NOT NULL,
  `Alamat` varchar(100) NOT NULL,
  `JenisKelamin` varchar(10) NOT NULL,
  `Jabatan` varchar(50) NOT NULL,
  `Gaji` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leaders`
--

INSERT INTO `leaders` (`ID_Leaders`, `NamaLengkap`, `Alamat`, `JenisKelamin`, `Jabatan`, `Gaji`) VALUES
('LD001', 'Wildan Rizkia', 'Jalan Merdeka Utara No. 1', 'Male', 'Direktur Utama', 100000000),
('LD002', 'Iqbal Rafi', 'Jalan Sukun No. 15', 'Male', 'Direktur Keuangan', 85000000),
('LD003', 'Much Hafizh', 'Jalan Gadang No. 20', 'Male', 'Direktur Operasional', 85000000),
('LD004', 'John Anderson', 'Jalan Harmoni No. 123', 'Male', 'Komisaris ', 60000000),
('LD005', 'Emily Williams', 'Jalan Serenity No. 456', 'Female', 'Komisaris Independen', 62000000),
('LD006', 'Michael Smith', 'Jalan Tranquility No. 789', 'Male', 'General Manager', 50000000),
('LD007', 'Sophia Taylor', 'Jalan Bliss No. 101', 'Female', 'Front Office Manager', 35000000),
('LD008', 'Daniel Lee', 'Jalan Elegance No. 222', 'Male', 'Food and Beverage Manager', 35000000),
('LD009', 'Roberta Davis', 'Jalan Vista No. 555', 'Female', 'Marketing Manager', 35000000),
('LD010', 'Alexander Rodriguez', 'Jalan Elite No. 333', 'Male', 'Finance Manager', 35000000),
('LD011', 'Olivia Carter', 'Jalan Oasis No. 777', 'Female', 'Human Resources Manager', 35000000),
('LD012', 'Victor Hernandez', 'Jalan Prestige No. 999', 'Male', 'IT Manager', 35000000);

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `ID_Customer` char(5) NOT NULL,
  `NamaLengkap` varchar(50) NOT NULL,
  `JenisKelamin` varchar(10) NOT NULL,
  `NIK` int(11) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `NomorTelepon` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`ID_Customer`, `NamaLengkap`, `JenisKelamin`, `NIK`, `Email`, `NomorTelepon`) VALUES
('CT001', 'Arnold Poernomo', 'Male', 89543, 'arnold@gmail.com', '0812377893'),
('CT002', 'Daniel Hendra', 'Male', 26021, 'danielhendra@gmail.com', '0813894034'),
('CT003', 'Kusnadi', 'Male', 34594, 'kusnadi@gmail.com', '0821456543'),
('CT004', 'Dewi Pangestu', 'Female', 97124, 'dewi@gmail.com', '0812347654'),
('CT005', 'Jamaludin', 'Male', 85429, 'jamaludin@gmail.com', '0812387542'),
('CT006', 'Lavender Adelya', 'Female', 12369, 'lavenderadelya@gmail.com', '08124594321'),
('CT007', 'Sekar Mahalini', 'Female', 76543, 'mahalini@gmail.com', '08134542983'),
('CT008', 'Najwa Annisa', 'Female', 34555, 'najwaannisa@gmail.com', '08216923408'),
('CT009', 'Monica Thilda', 'Female', 34786, 'thilda@gmail.com', '08134982340'),
('CT010', 'Ni Ketut Gusti', 'Male', 11111, 'ketutgusti@gmail.com', '0821500000'),
('CT011', 'I Made Andika', 'Male', 23498, 'madeandika@gmail.com', '0811786543'),
('CT012', 'Putri Febriyani', 'Female', 25489, 'febriyani@gmail.com', '082131093346'),
('CT013', 'Muhammad Semeru', 'Male', 18756, 'muhammadsemeru@gmail.com', '0812627892'),
('CT014', 'Reyna ', 'Female', 87642, 'reyna@gmail.com', '0812345674'),
('CT015', 'Maaruf Omen', 'Male', 76831, 'maarufomen@gmail.com', '082131093367'),
('CT016', 'Siti Aisyah', 'Female', 56789, 'siti@gmail.com', '0812987654'),
('CT017', 'Rizky Pratama', 'Male', 43210, 'rizky@gmail.com', '0821876543'),
('CT018', 'Anisa Fitriani', 'Female', 65432, 'anisa@gmail.com', '0813765432'),
('CT019', 'Eko Wahyudi', 'Male', 78901, 'eko@gmail.com', '0821654321'),
('CT020', 'Dian Purnama', 'Female', 23456, 'dian@gmail.com', '0812543210'),
('CT021', 'Rudi Hermawan', 'Male', 87654, 'rudi@gmail.com', '0821432109'),
('CT022', 'Linda Dewi', 'Female', 34567, 'linda@gmail.com', '0813321098'),
('CT023', 'Rizal Malik', 'Male', 98765, 'rizal@gmail.com', '0822210987'),
('CT024', 'Siska Putri', 'Female', 45678, 'siska@gmail.com', '0813109876'),
('CT025', 'Firman Utomo', 'Male', 54321, 'firman@gmail.com', '0822998765'),
('CT026', 'Nina Rosita', 'Female', 67890, 'nina@gmail.com', '0812887654'),
('CT027', 'Aldi Firmansyah', 'Male', 12345, 'aldi@gmail.com', '0821776543'),
('CT028', 'Rina Indah', 'Female', 89012, 'rina@gmail.com', '0813665432'),
('CT029', 'Yoga Prakasa', 'Male', 54321, 'yoga@gmail.com', '0822554321'),
('CT030', 'Siti Hidayah', 'Female', 21098, 'hidayah@gmail.com', '0813443210'),
('CT031', 'John Doe', 'Male', 20130, 'john.doe@gmail.com', '0812345678'),
('CT032', 'Jane Smith', 'Female', 54322, 'jane.smith@gmail.com', '0823456789'),
('CT033', 'Michael Johnson', 'Male', 98766, 'michael.johnson@gmail.com', '0834567890'),
('CT034', 'Emily Davis', 'Female', 34569, 'emily.davis@gmail.com', '0845678901'),
('CT035', 'Robert Lee', 'Male', 87651, 'robert.lee@gmail.com', '0856789012'),
('CT036', 'Amanda Chen', 'Female', 65437, 'amanda.chen@gmail.com', '0867890123');

-- --------------------------------------------------------

--
-- Stand-in structure for view `pelanggan_memesanhotel`
-- (See below for the actual view)
--
CREATE TABLE `pelanggan_memesanhotel` (
`NamaLengkap` varchar(50)
,`ID_Customer` char(5)
,`TipeKamar` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pelanggan_memesanresto`
-- (See below for the actual view)
--
CREATE TABLE `pelanggan_memesanresto` (
`ID_Customer` char(5)
,`NamaLengkap` varchar(50)
,`PaketMakan_PerPax` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pelanggan_pria`
-- (See below for the actual view)
--
CREATE TABLE `pelanggan_pria` (
`ID_Customer` char(5)
,`NamaLengkap` varchar(50)
,`NomorTelepon` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pelanggan_wanita`
-- (See below for the actual view)
--
CREATE TABLE `pelanggan_wanita` (
`ID_Customer` char(5)
,`NamaLengkap` varchar(50)
,`NomorTelepon` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `ID_Pembayaran` char(5) NOT NULL,
  `ID_Reservasi` char(5) NOT NULL,
  `ID_Transfer` char(5) DEFAULT NULL,
  `ID_CC` char(5) DEFAULT NULL,
  `ID_Cash` char(5) DEFAULT NULL,
  `TotalPembayaran` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`ID_Pembayaran`, `ID_Reservasi`, `ID_Transfer`, `ID_CC`, `ID_Cash`, `TotalPembayaran`) VALUES
('PB001', 'RV001', NULL, NULL, 'CA001', 400000),
('PB002', 'RV003', 'TF002', NULL, NULL, 800000),
('PB003', 'RV004', NULL, NULL, 'CA002', 5000000),
('PB004', 'RV009', NULL, 'CC004', NULL, 770000),
('PB005', 'RV007', 'TF003', NULL, NULL, 260000),
('PB006', 'RV005', NULL, 'CC002', NULL, 400000),
('PB007', 'RV002', 'TF001', NULL, NULL, 9000000),
('PB008', 'RV011', NULL, NULL, 'CA004', 550000),
('PB009', 'RV015', NULL, NULL, 'CA006', 650000),
('PB010', 'RV013', NULL, NULL, 'CA005', 12000000),
('PB011', 'RV021', 'TF007', NULL, NULL, 660000),
('PB012', 'RV019', NULL, NULL, 'CA008', 300000),
('PB013', 'RV017', NULL, 'CC006', NULL, 640000),
('PB014', 'RV025', 'TF009', NULL, NULL, 330000),
('PB015', 'RV023', NULL, 'CC009', NULL, 400000),
('PB016', 'RV029', NULL, 'CC010', NULL, 7800000),
('PB017', 'RV027', NULL, NULL, 'CA009', 1000000),
('PB018', 'RV033', NULL, 'CC011', NULL, 800000),
('PB019', 'RV031', NULL, NULL, 'CA011', 2000000),
('PB020', 'RV035', 'TF012', NULL, NULL, 400000),
('PB021', 'RV006', NULL, 'CC001', NULL, 10000000),
('PB022', 'RV008', NULL, NULL, 'CA003', 6000000),
('PB023', 'RV010', NULL, 'CC003', NULL, 4000000),
('PB024', 'RV012', NULL, 'CC005', NULL, 2000000),
('PB025', 'RV014', 'TF004', NULL, NULL, 3000000),
('PB026', 'RV016', 'TF005', NULL, NULL, 10000000),
('PB027', 'RV018', NULL, NULL, 'CA007', 4000000),
('PB028', 'RV020', NULL, 'CC007', NULL, 1000000),
('PB029', 'RV022', 'TF006', NULL, NULL, 2000000),
('PB030', 'RV024', NULL, 'CC008', NULL, 6000000),
('PB031', 'RV026', 'TF008', NULL, NULL, 3000000),
('PB032', 'RV028', 'TF010', NULL, NULL, 6000000),
('PB033', 'RV030', NULL, NULL, 'CA010', 4000000),
('PB034', 'RV032', NULL, NULL, 'CA012', 9000000),
('PB035', 'RV034', 'TF011', NULL, NULL, 5000000),
('PB036', 'RV036', NULL, 'CC012', NULL, 6000000);

-- --------------------------------------------------------

--
-- Table structure for table `pesananpelanggan`
--

CREATE TABLE `pesananpelanggan` (
  `ID_Reservasi` char(5) NOT NULL,
  `ID_Customer` char(5) NOT NULL,
  `ID_PemesananHotel` char(5) DEFAULT NULL,
  `ID_PemesananResto` char(5) DEFAULT NULL,
  `JumlahPelanggan` int(11) NOT NULL,
  `TanggalMasuk` date NOT NULL,
  `TanggalKeluar` date NOT NULL,
  `TotalPembayaran` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesananpelanggan`
--

INSERT INTO `pesananpelanggan` (`ID_Reservasi`, `ID_Customer`, `ID_PemesananHotel`, `ID_PemesananResto`, `JumlahPelanggan`, `TanggalMasuk`, `TanggalKeluar`, `TotalPembayaran`) VALUES
('RV001', 'CT002', NULL, 'PR002', 4, '2023-03-01', '2023-03-01', 400000),
('RV002', 'CT001', 'PH002', NULL, 2, '2023-03-02', '2023-03-05', 9000000),
('RV003', 'CT004', NULL, 'PR001', 10, '2023-03-01', '2023-03-01', 800000),
('RV004', 'CT003', 'PH001', NULL, 1, '2023-03-01', '2023-03-02', 5000000),
('RV005', 'CT006', NULL, 'PR001', 5, '2023-03-02', '2023-03-02', 400000),
('RV006', 'CT005', 'PH001', NULL, 3, '2023-04-04', '2023-04-06', 10000000),
('RV007', 'CT008', NULL, 'PR004', 2, '2023-03-02', '2023-03-02', 260000),
('RV008', 'CT007', 'PH004', NULL, 1, '2023-04-04', '2023-06-10', 6000000),
('RV009', 'CT010', NULL, 'PR003', 7, '2023-03-02', '2023-03-02', 770000),
('RV010', 'CT009', 'PH003', NULL, 2, '2023-06-08', '2023-06-10', 4000000),
('RV011', 'CT012', NULL, 'PR003', 5, '2023-03-03', '2023-03-03', 550000),
('RV012', 'CT011', 'PH003', NULL, 2, '2023-06-08', '2023-06-09', 2000000),
('RV013', 'CT014', NULL, 'PR002', 12, '2023-03-03', '2023-03-03', 12000000),
('RV014', 'CT013', 'PH002', NULL, 2, '2023-06-10', '2023-06-11', 3000000),
('RV015', 'CT016', NULL, 'PR004', 5, '2023-03-03', '2023-03-03', 650000),
('RV016', 'CT015', 'PH001', NULL, 1, '2023-06-12', '2023-06-14', 10000000),
('RV017', 'CT018', NULL, 'PR001', 8, '2023-03-04', '2023-03-04', 640000),
('RV018', 'CT017', 'PH003', NULL, 2, '2023-06-13', '2023-06-15', 4000000),
('RV019', 'CT020', NULL, 'PR002', 3, '2023-03-04', '2023-03-04', 300000),
('RV020', 'CT019', 'PH004', NULL, 1, '2023-06-14', '2023-06-15', 1000000),
('RV021', 'CT022', NULL, 'PR003', 6, '2023-03-04', '2023-03-04', 660000),
('RV022', 'CT021', 'PH004', NULL, 1, '2023-06-14', '2023-06-16', 2000000),
('RV023', 'CT024', NULL, 'PR002', 4, '2023-03-05', '2023-03-05', 400000),
('RV024', 'CT023', 'PH003', NULL, 3, '2023-06-16', '2023-06-19', 6000000),
('RV025', 'CT026', NULL, 'PR003', 3, '2023-03-05', '2023-03-05', 330000),
('RV026', 'CT025', 'PH002', NULL, 3, '2023-06-18', '2023-06-19', 3000000),
('RV027', 'CT028', NULL, 'PR002', 10, '2023-03-06', '2023-03-06', 1000000),
('RV028', 'CT027', 'PH003', NULL, 2, '2023-06-19', '2023-06-21', 6000000),
('RV029', 'CT030', NULL, 'PR004', 6, '2023-03-06', '2023-03-06', 7800000),
('RV030', 'CT029', 'PH004', NULL, 1, '2023-06-20', '2023-06-24', 4000000),
('RV031', 'CT031', NULL, 'PR002', 20, '2023-03-07', '2023-03-07', 2000000),
('RV032', 'CT033', 'PH002', NULL, 2, '2023-06-22', '2023-06-25', 9000000),
('RV033', 'CT034', NULL, 'PR001', 10, '2023-03-07', '2023-03-07', 800000),
('RV034', 'CT032', 'PH001', NULL, 1, '2023-06-23', '2023-06-24', 5000000),
('RV035', 'CT035', NULL, 'PR001', 5, '2023-03-07', '2023-03-07', 400000),
('RV036', 'CT036', 'PH003', NULL, 3, '2023-06-23', '2023-06-26', 6000000);

-- --------------------------------------------------------

--
-- Table structure for table `resepsionis`
--

CREATE TABLE `resepsionis` (
  `ID_Receipt` char(5) NOT NULL,
  `ID_Customer` char(5) NOT NULL,
  `ID_Reservasi` char(5) NOT NULL,
  `ID_Pembayaran` char(5) NOT NULL,
  `ID_Karyawan` char(5) NOT NULL,
  `TanggalTransaksi` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `resepsionis`
--

INSERT INTO `resepsionis` (`ID_Receipt`, `ID_Customer`, `ID_Reservasi`, `ID_Pembayaran`, `ID_Karyawan`, `TanggalTransaksi`) VALUES
('RC001', 'CT002', 'RV001', 'PB001', 'KR016', '2023-03-01'),
('RC002', 'CT004', 'RV003', 'PB002', 'KR016', '2023-03-01'),
('RC003', 'CT003', 'RV004', 'PB003', 'KR016', '2023-03-01'),
('RC004', 'CT010', 'RV009', 'PB004', 'KR016', '2023-03-02'),
('RC005', 'CT008', 'RV007', 'PB005', 'KR018', '2023-03-02'),
('RC006', 'CT006', 'RV005', 'PB006', 'KR018', '2023-03-02'),
('RC007', 'CT001', 'RV002', 'PB007', 'KR018', '2023-03-02'),
('RC008', 'CT012', 'RV011', 'PB008', 'KR018', '2023-03-03'),
('RC009', 'CT016', 'RV015', 'PB009', 'KR020', '2023-03-03'),
('RC010', 'CT014', 'RV013', 'PB010', 'KR020', '2023-03-03'),
('RC011', 'CT022', 'RV021', 'PB011', 'KR020', '2023-03-04'),
('RC012', 'CT020', 'RV019', 'PB012', 'KR020', '2023-03-04'),
('RC013', 'CT018', 'RV017', 'PB013', 'KR016', '2023-03-04'),
('RC014', 'CT026', 'RV025', 'PB014', 'KR016', '2023-03-05'),
('RC015', 'CT024', 'RV023', 'PB015', 'KR016', '2023-03-05'),
('RC016', 'CT030', 'RV029', 'PB016', 'KR016', '2023-03-06'),
('RC017', 'CT028', 'RV027', 'PB017', 'KR018', '2023-03-06'),
('RC018', 'CT034', 'RV033', 'PB018', 'KR018', '2023-03-07'),
('RC019', 'CT031', 'RV031', 'PB019', 'KR018', '2023-03-07'),
('RC020', 'CT035', 'RV035', 'PB020', 'KR018', '2023-03-07'),
('RC021', 'CT005', 'RV006', 'PB021', 'KR020', '2023-04-04'),
('RC022', 'CT007', 'RV008', 'PB022', 'KR020', '2023-04-04'),
('RC023', 'CT009', 'RV010', 'PB023', 'KR020', '2023-06-08'),
('RC024', 'CT011', 'RV012', 'PB024', 'KR020', '2023-06-08'),
('RC025', 'CT013', 'RV014', 'PB025', 'KR016', '2023-06-10'),
('RC026', 'CT015', 'RV016', 'PB026', 'KR016', '2023-06-12'),
('RC027', 'CT017', 'RV018', 'PB027', 'KR016', '2023-06-13'),
('RC028', 'CT019', 'RV020', 'PB028', 'KR016', '2023-06-14'),
('RC029', 'CT021', 'RV022', 'PB029', 'KR018', '2023-06-14'),
('RC030', 'CT023', 'RV024', 'PB030', 'KR018', '2023-06-19'),
('RC031', 'CT025', 'RV026', 'PB031', 'KR018', '2023-06-19'),
('RC032', 'CT027', 'RV028', 'PB032', 'KR018', '2023-06-19'),
('RC033', 'CT029', 'RV030', 'PB033', 'KR020', '2023-06-20'),
('RC034', 'CT033', 'RV032', 'PB034', 'KR020', '2023-06-22'),
('RC035', 'CT032', 'RV034', 'PB035', 'KR020', '2023-06-23'),
('RC036', 'CT036', 'RV036', 'PB036', 'KR020', '2023-06-23');

-- --------------------------------------------------------

--
-- Table structure for table `reservasihotel`
--

CREATE TABLE `reservasihotel` (
  `ID_PemesananHotel` char(5) NOT NULL,
  `TipeKamar` varchar(50) NOT NULL,
  `Harga` int(11) NOT NULL CHECK (`ID_PemesananHotel` regexp '^PH[0-9][0-9][0-9]$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservasihotel`
--

INSERT INTO `reservasihotel` (`ID_PemesananHotel`, `TipeKamar`, `Harga`) VALUES
('PH001', 'Presidential Suite', 5000000),
('PH002', 'Superior Room', 3000000),
('PH003', 'Deluxe Room', 2000000),
('PH004', 'Junior Suite Room', 1000000);

-- --------------------------------------------------------

--
-- Table structure for table `reservasirestaurant`
--

CREATE TABLE `reservasirestaurant` (
  `ID_PemesananResto` char(5) NOT NULL,
  `PaketMakan_PerPax` varchar(50) NOT NULL,
  `Harga` int(11) NOT NULL CHECK (`ID_PemesananResto` regexp '^PR[0-9][0-9][0-9]$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservasirestaurant`
--

INSERT INTO `reservasirestaurant` (`ID_PemesananResto`, `PaketMakan_PerPax`, `Harga`) VALUES
('PR001', 'Paket Breakfast', 80000),
('PR002', 'Paket Brunch', 100000),
('PR003', 'Paket Lunch', 110000),
('PR004', 'Paket Dinner', 130000);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `ID_Staff` char(5) NOT NULL,
  `NamaLengkap` varchar(50) NOT NULL,
  `Alamat` varchar(100) NOT NULL,
  `JenisKelamin` varchar(10) NOT NULL,
  `JabatanStaff` varchar(50) NOT NULL,
  `Gaji` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`ID_Staff`, `NamaLengkap`, `Alamat`, `JenisKelamin`, `JabatanStaff`, `Gaji`) VALUES
('ST001', 'Jason Hernandez', 'Jalan Harmony No. 567', 'Male', 'Cleaning Service', 9500000),
('ST002', 'Emma Parker', 'Jalan Tranquil No. 876', 'Female', 'Front Desk Officer', 9000000),
('ST003', 'Christopher Davis', 'Jalan Bliss No. 321', 'Male', 'Front Desk Officer', 9000000),
('ST004', 'Sophia Turner', 'Jalan Elegance No. 654', 'Female', 'Receptionist', 9200000),
('ST005', 'Matthew White', 'Jalan Vista No. 111', 'Male', 'Security Guard', 8600000),
('ST006', 'Olivia Carter', 'Jalan Elite No. 222', 'Female', 'Receptionist', 9200000),
('ST007', 'Ethan Anderson', 'Jalan Oasis No. 333', 'Male', 'Housekeeper', 8900000),
('ST008', 'Isabella Turner', 'Jalan Prestige No. 444', 'Female', 'Receptionist', 9200000),
('ST009', 'Ryan Wilson', 'Jalan Serendipity No. 555', 'Male', 'Room Attendant', 8700000),
('ST010', 'Aria Smith', 'Jalan Harmony No. 666', 'Female', 'Sales Executive', 9400000),
('ST011', 'Liam Harris', 'Jalan Serenity No. 789', 'Male', 'Bellboy', 8000000),
('ST012', 'Ava Martinez', 'Jalan Harmony No. 234', 'Female', 'Concierge', 8500000),
('ST013', 'Logan Davis', 'Jalan Tranquil No. 432', 'Male', 'Front Desk Officer', 9000000),
('ST014', 'Ella Thompson', 'Jalan Bliss No. 567', 'Female', 'Housekeeper', 8900000),
('ST015', 'Jackson Miller', 'Jalan Elegance No. 876', 'Male', 'IT Support', 9400000),
('ST016', 'Sophie Turner', 'Jalan Vista No. 987', 'Female', 'Event Coordinator', 9200000),
('ST017', 'Lucas Wilson', 'Jalan Elite No. 654', 'Male', 'Security Guard', 8600000),
('ST018', 'Lily Parker', 'Jalan Oasis No. 321', 'Female', 'Event Coordinator', 9200000),
('ST019', 'Mason Taylor', 'Jalan Prestige No. 876', 'Male', 'IT Support', 9400000),
('ST020', 'Grace Davis', 'Jalan Serendipity No. 123', 'Female', 'Marketing Assistant', 9100000);

-- --------------------------------------------------------

--
-- Table structure for table `strukpembayaran`
--

CREATE TABLE `strukpembayaran` (
  `ID_Receipt` char(5) NOT NULL,
  `ID_Customer` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `strukpembayaran`
--

INSERT INTO `strukpembayaran` (`ID_Receipt`, `ID_Customer`) VALUES
('RC001', 'CT002'),
('RC002', 'CT004'),
('RC003', 'CT003'),
('RC004', 'CT010'),
('RC005', 'CT008'),
('RC006', 'CT006'),
('RC008', 'CT012'),
('RC009', 'CT016'),
('RC010', 'CT014'),
('RC011', 'CT022'),
('RC012', 'CT020'),
('RC013', 'CT018'),
('RC014', 'CT026'),
('RC015', 'CT024'),
('RC016', 'CT030'),
('RC017', 'CT028'),
('RC018', 'CT034'),
('RC019', 'CT031'),
('RC020', 'CT035'),
('RC021', 'CT005'),
('RC022', 'CT007'),
('RC023', 'CT009'),
('RC024', 'CT011'),
('RC025', 'CT013'),
('RC026', 'CT015'),
('RC027', 'CT017'),
('RC028', 'CT019'),
('RC029', 'CT021'),
('RC030', 'CT023'),
('RC031', 'CT025'),
('RC032', 'CT027'),
('RC033', 'CT029'),
('RC034', 'CT033'),
('RC035', 'CT032'),
('RC036', 'CT036'),
('RC001', 'CT002'),
('RC002', 'CT004'),
('RC003', 'CT003'),
('RC004', 'CT010'),
('RC005', 'CT008'),
('RC006', 'CT006'),
('RC008', 'CT012'),
('RC009', 'CT016'),
('RC010', 'CT014'),
('RC011', 'CT022'),
('RC012', 'CT020'),
('RC013', 'CT018'),
('RC014', 'CT026'),
('RC015', 'CT024'),
('RC016', 'CT030'),
('RC017', 'CT028'),
('RC018', 'CT034'),
('RC019', 'CT031'),
('RC020', 'CT035'),
('RC021', 'CT005'),
('RC022', 'CT007'),
('RC023', 'CT009'),
('RC024', 'CT011'),
('RC025', 'CT013'),
('RC026', 'CT015'),
('RC027', 'CT017'),
('RC028', 'CT019'),
('RC029', 'CT021'),
('RC030', 'CT023'),
('RC031', 'CT025'),
('RC032', 'CT027'),
('RC033', 'CT029'),
('RC034', 'CT033'),
('RC035', 'CT032'),
('RC036', 'CT036'),
('RC001', 'CT002'),
('RC002', 'CT004'),
('RC003', 'CT003'),
('RC004', 'CT010'),
('RC005', 'CT008'),
('RC006', 'CT006'),
('RC008', 'CT012'),
('RC009', 'CT016'),
('RC010', 'CT014'),
('RC011', 'CT022'),
('RC012', 'CT020'),
('RC013', 'CT018'),
('RC014', 'CT026'),
('RC015', 'CT024'),
('RC016', 'CT030'),
('RC017', 'CT028'),
('RC018', 'CT034'),
('RC019', 'CT031'),
('RC020', 'CT035'),
('RC021', 'CT005'),
('RC022', 'CT007'),
('RC023', 'CT009'),
('RC024', 'CT011'),
('RC025', 'CT013'),
('RC026', 'CT015'),
('RC027', 'CT017'),
('RC028', 'CT019'),
('RC029', 'CT021'),
('RC030', 'CT023'),
('RC031', 'CT025'),
('RC032', 'CT027'),
('RC033', 'CT029'),
('RC034', 'CT033'),
('RC035', 'CT032'),
('RC036', 'CT036');

-- --------------------------------------------------------

--
-- Stand-in structure for view `totalpenjualan_hotel`
-- (See below for the actual view)
--
CREATE TABLE `totalpenjualan_hotel` (
`TotalPesananHotel` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `totalpenjualan_resto`
-- (See below for the actual view)
--
CREATE TABLE `totalpenjualan_resto` (
`TotalPesananResto` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `transferbank`
--

CREATE TABLE `transferbank` (
  `ID_Transfer` char(5) NOT NULL,
  `NomorRekening` int(11) NOT NULL,
  `NamaRekening` varchar(50) NOT NULL,
  `TotalPembayaran` int(11) NOT NULL CHECK (`ID_Transfer` regexp '^TF[0-9][0-9][0-9]$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transferbank`
--

INSERT INTO `transferbank` (`ID_Transfer`, `NomorRekening`, `NamaRekening`, `TotalPembayaran`) VALUES
('TF001', 87642, 'Arnold Poernomo', 9000000),
('TF002', 66574, 'Dewi Pangestu', 800000),
('TF003', 11234, 'Najwa Annisa', 260000),
('TF004', 19875, 'Muhammad Semeru', 3000000),
('TF005', 19234, 'Maaruf Omen', 10000000),
('TF006', 88872, 'Rudi Hermawan', 2000000),
('TF007', 10211, 'Linda Dewi', 660000),
('TF008', 22352, 'Firman Utomo', 3000000),
('TF009', 11819, 'Nina Rosita', 330000),
('TF010', 24041, 'Aldi Firmansyah', 6000000),
('TF011', 99999, 'Jane Smith', 9000000),
('TF012', 49852, 'Robert Lee', 400000);

-- --------------------------------------------------------

--
-- Structure for view `pelanggan_memesanhotel`
--
DROP TABLE IF EXISTS `pelanggan_memesanhotel`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pelanggan_memesanhotel`  AS SELECT `pelanggan`.`NamaLengkap` AS `NamaLengkap`, `pesananpelanggan`.`ID_Customer` AS `ID_Customer`, `reservasihotel`.`TipeKamar` AS `TipeKamar` FROM ((`pesananpelanggan` join `reservasihotel`) join `pelanggan`) WHERE `pesananpelanggan`.`ID_PemesananHotel` = `reservasihotel`.`ID_PemesananHotel` AND `pesananpelanggan`.`ID_Customer` = `pelanggan`.`ID_Customer` ;

-- --------------------------------------------------------

--
-- Structure for view `pelanggan_memesanresto`
--
DROP TABLE IF EXISTS `pelanggan_memesanresto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pelanggan_memesanresto`  AS SELECT `pesananpelanggan`.`ID_Customer` AS `ID_Customer`, `pelanggan`.`NamaLengkap` AS `NamaLengkap`, `reservasirestaurant`.`PaketMakan_PerPax` AS `PaketMakan_PerPax` FROM ((`pesananpelanggan` join `reservasirestaurant`) join `pelanggan`) WHERE `pesananpelanggan`.`ID_PemesananResto` = `reservasirestaurant`.`ID_PemesananResto` AND `pesananpelanggan`.`ID_Customer` = `pelanggan`.`ID_Customer` ;

-- --------------------------------------------------------

--
-- Structure for view `pelanggan_pria`
--
DROP TABLE IF EXISTS `pelanggan_pria`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pelanggan_pria`  AS SELECT `pelanggan`.`ID_Customer` AS `ID_Customer`, `pelanggan`.`NamaLengkap` AS `NamaLengkap`, `pelanggan`.`NomorTelepon` AS `NomorTelepon` FROM `pelanggan` WHERE `pelanggan`.`JenisKelamin` = 'Male' ;

-- --------------------------------------------------------

--
-- Structure for view `pelanggan_wanita`
--
DROP TABLE IF EXISTS `pelanggan_wanita`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pelanggan_wanita`  AS SELECT `pelanggan`.`ID_Customer` AS `ID_Customer`, `pelanggan`.`NamaLengkap` AS `NamaLengkap`, `pelanggan`.`NomorTelepon` AS `NomorTelepon` FROM `pelanggan` WHERE `pelanggan`.`JenisKelamin` = 'Female' ;

-- --------------------------------------------------------

--
-- Structure for view `totalpenjualan_hotel`
--
DROP TABLE IF EXISTS `totalpenjualan_hotel`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `totalpenjualan_hotel`  AS SELECT count(`pesananpelanggan`.`ID_PemesananHotel`) AS `TotalPesananHotel` FROM `pesananpelanggan` WHERE `pesananpelanggan`.`ID_PemesananHotel` is not null ;

-- --------------------------------------------------------

--
-- Structure for view `totalpenjualan_resto`
--
DROP TABLE IF EXISTS `totalpenjualan_resto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `totalpenjualan_resto`  AS SELECT count(`pp`.`ID_PemesananResto`) AS `TotalPesananResto` FROM `pesananpelanggan` AS `pp` WHERE `pp`.`ID_PemesananResto` is not null ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cash`
--
ALTER TABLE `cash`
  ADD PRIMARY KEY (`ID_Cash`);

--
-- Indexes for table `creditcard`
--
ALTER TABLE `creditcard`
  ADD PRIMARY KEY (`ID_CC`);

--
-- Indexes for table `departemendapur`
--
ALTER TABLE `departemendapur`
  ADD PRIMARY KEY (`ID_StaffKC`);

--
-- Indexes for table `hotelmanagement`
--
ALTER TABLE `hotelmanagement`
  ADD KEY `ID_Receipt` (`ID_Receipt`),
  ADD KEY `ID_Karyawan` (`ID_Karyawan`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`ID_Karyawan`),
  ADD KEY `ID_Leaders` (`ID_Leaders`),
  ADD KEY `ID_Staff` (`ID_Staff`),
  ADD KEY `ID_StaffKC` (`ID_StaffKC`);

--
-- Indexes for table `leaders`
--
ALTER TABLE `leaders`
  ADD PRIMARY KEY (`ID_Leaders`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`ID_Customer`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`ID_Pembayaran`),
  ADD KEY `ID_Reservasi` (`ID_Reservasi`),
  ADD KEY `ID_Transfer` (`ID_Transfer`),
  ADD KEY `ID_CC` (`ID_CC`),
  ADD KEY `ID_Cash` (`ID_Cash`);

--
-- Indexes for table `pesananpelanggan`
--
ALTER TABLE `pesananpelanggan`
  ADD PRIMARY KEY (`ID_Reservasi`),
  ADD KEY `ID_Customer` (`ID_Customer`),
  ADD KEY `ID_PemesananHotel` (`ID_PemesananHotel`),
  ADD KEY `ID_PemesananResto` (`ID_PemesananResto`);

--
-- Indexes for table `resepsionis`
--
ALTER TABLE `resepsionis`
  ADD PRIMARY KEY (`ID_Receipt`),
  ADD KEY `ID_Customer` (`ID_Customer`),
  ADD KEY `ID_Reservasi` (`ID_Reservasi`),
  ADD KEY `ID_Pembayaran` (`ID_Pembayaran`),
  ADD KEY `ID_Karyawan` (`ID_Karyawan`);

--
-- Indexes for table `reservasihotel`
--
ALTER TABLE `reservasihotel`
  ADD PRIMARY KEY (`ID_PemesananHotel`);

--
-- Indexes for table `reservasirestaurant`
--
ALTER TABLE `reservasirestaurant`
  ADD PRIMARY KEY (`ID_PemesananResto`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`ID_Staff`);

--
-- Indexes for table `strukpembayaran`
--
ALTER TABLE `strukpembayaran`
  ADD KEY `ID_Receipt` (`ID_Receipt`),
  ADD KEY `ID_Customer` (`ID_Customer`);

--
-- Indexes for table `transferbank`
--
ALTER TABLE `transferbank`
  ADD PRIMARY KEY (`ID_Transfer`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hotelmanagement`
--
ALTER TABLE `hotelmanagement`
  ADD CONSTRAINT `hotelmanagement_ibfk_1` FOREIGN KEY (`ID_Receipt`) REFERENCES `resepsionis` (`ID_Receipt`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `hotelmanagement_ibfk_2` FOREIGN KEY (`ID_Karyawan`) REFERENCES `karyawan` (`ID_Karyawan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD CONSTRAINT `karyawan_ibfk_1` FOREIGN KEY (`ID_Leaders`) REFERENCES `leaders` (`ID_Leaders`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `karyawan_ibfk_2` FOREIGN KEY (`ID_Staff`) REFERENCES `staff` (`ID_Staff`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `karyawan_ibfk_3` FOREIGN KEY (`ID_StaffKC`) REFERENCES `departemendapur` (`ID_StaffKC`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`ID_Reservasi`) REFERENCES `pesananpelanggan` (`ID_Reservasi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pembayaran_ibfk_2` FOREIGN KEY (`ID_Transfer`) REFERENCES `transferbank` (`ID_Transfer`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pembayaran_ibfk_3` FOREIGN KEY (`ID_CC`) REFERENCES `creditcard` (`ID_CC`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pembayaran_ibfk_4` FOREIGN KEY (`ID_Cash`) REFERENCES `cash` (`ID_Cash`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pesananpelanggan`
--
ALTER TABLE `pesananpelanggan`
  ADD CONSTRAINT `pesananpelanggan_ibfk_1` FOREIGN KEY (`ID_Customer`) REFERENCES `pelanggan` (`ID_Customer`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pesananpelanggan_ibfk_2` FOREIGN KEY (`ID_PemesananHotel`) REFERENCES `reservasihotel` (`ID_PemesananHotel`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pesananpelanggan_ibfk_3` FOREIGN KEY (`ID_PemesananResto`) REFERENCES `reservasirestaurant` (`ID_PemesananResto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `resepsionis`
--
ALTER TABLE `resepsionis`
  ADD CONSTRAINT `resepsionis_ibfk_1` FOREIGN KEY (`ID_Customer`) REFERENCES `pelanggan` (`ID_Customer`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `resepsionis_ibfk_2` FOREIGN KEY (`ID_Reservasi`) REFERENCES `pesananpelanggan` (`ID_Reservasi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `resepsionis_ibfk_3` FOREIGN KEY (`ID_Pembayaran`) REFERENCES `pembayaran` (`ID_Pembayaran`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `resepsionis_ibfk_4` FOREIGN KEY (`ID_Karyawan`) REFERENCES `karyawan` (`ID_Karyawan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `strukpembayaran`
--
ALTER TABLE `strukpembayaran`
  ADD CONSTRAINT `strukpembayaran_ibfk_1` FOREIGN KEY (`ID_Receipt`) REFERENCES `resepsionis` (`ID_Receipt`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `strukpembayaran_ibfk_2` FOREIGN KEY (`ID_Customer`) REFERENCES `pelanggan` (`ID_Customer`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
