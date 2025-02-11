-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Feb 2025 pada 01.52
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpus`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteBuku` (IN `b_id_buku` INT)   BEGIN 
DELETE FROM buku WHERE id_buku = b_id_buku; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePeminjaman` (IN `p_id_peminjaman` INT)   BEGIN
    DELETE FROM peminjaman WHERE id_peminjaman = p_id_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteSiswa` (IN `s_id_siswa` INT)   BEGIN
    DELETE FROM siswa WHERE id_siswa = s_id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDataBuku` (IN `judul_buku` VARCHAR(255), IN `penulis` VARCHAR(255), IN `kategori` VARCHAR(100), IN `stok` INT)   BEGIN
    INSERT INTO buku (judul_buku, penulis, kategori, stok) VALUES (judul_buku, penulis, kategori, stok);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDataPeminjaman` (IN `id_siswa` INT, IN `id_buku` INT, IN `tanggal_pinjam` DATE, IN `tanggal_kembali` DATE, IN `status` ENUM('Dipinjam','Dikembalikan'))   BEGIN
    INSERT INTO peminjaman (id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status) 
    VALUES (id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDataSiswa` (IN `nama` VARCHAR(255), IN `kelas` VARCHAR(50))   BEGIN
    INSERT INTO siswa (nama, kelas) VALUES (nama,kelas);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `KembalikanBuku` (IN `id_peminjaman` INT)   BEGIN
    UPDATE peminjaman 
    SET status = 'Dikembalikan', tanggal_kembali = CURRENT_DATE 
    WHERE id_peminjaman = id_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectBuku` ()   BEGIN
    SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectPeminjaman` ()   BEGIN
    SELECT * FROM peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectSiswa` ()   BEGIN
    SELECT * FROM siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SemuaBuku` ()   BEGIN
    SELECT buku.id_buku, buku.judul_buku, buku.penulis, buku.kategori, buku.stok, IFNULL(peminjaman.id_peminjaman, 'Belum Dipinjam') AS Status_Peminjaman
    FROM buku
    LEFT JOIN peminjaman ON buku.id_buku = peminjaman.id_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SemuaSiswa` ()   BEGIN
    SELECT siswa.id_siswa, siswa.nama, siswa.kelas, IFNULL(peminjaman.id_peminjaman, 'Belum Meminjam') AS Status_Peminjaman
    FROM siswa
    LEFT JOIN peminjaman ON siswa.id_siswa = peminjaman.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SiswaPernahPinjam` ()   BEGIN
    SELECT DISTINCT siswa.id_siswa, siswa.nama, siswa.kelas 
    FROM siswa
    JOIN peminjaman ON siswa.id_siswa = peminjaman.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDataBuku` (IN `id_buku` INT, IN `judul_buku` VARCHAR(255), IN `penulis` VARCHAR(255), IN `kategori` VARCHAR(100), IN `stok` INT)   BEGIN
    UPDATE buku SET judul_buku = judul_buku, penulis = penulis, kategori = kategori, stok = stok WHERE id_buku = id_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDataSiswa` (IN `id_siswa` INT, IN `nama` VARCHAR(255), IN `kelas` VARCHAR(50))   BEGIN
    UPDATE siswa SET nama = nama, kelas = kelas WHERE id_siswa = id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePeminjaman` (IN `p_id_peminjaman` INT, IN `p_id_siswa` INT, IN `p_id_buku` INT, IN `p_tanggal_pinjam` DATE, IN `p_tanggal_kembali` DATE, IN `p_status` ENUM('Dipinjam','Dikembalikan'))   BEGIN
    UPDATE peminjaman 
    SET 
        id_siswa = p_id_siswa,
        id_buku = p_id_buku,
        tanggal_pinjam = p_tanggal_pinjam,
        tanggal_kembali = p_tanggal_kembali,
        status = p_status
    WHERE id_peminjaman = p_id_peminjaman;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `judul_buku` varchar(255) DEFAULT NULL,
  `penulis` varchar(255) DEFAULT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id_buku`, `judul_buku`, `penulis`, `kategori`, `stok`) VALUES
(1, 'Algoritma dan Pemrograman', 'Andi Wijaya', 'Teknologi', 4),
(2, 'Dasar-dasar Database', 'Budi Santoso', 'Teknologi', 6),
(3, 'Matematika Diskrit', 'Rina Sari', 'Matematika', 3),
(4, 'Sejarah Dunia', 'John Smith', 'Sejarah', 2),
(5, 'Pemrograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 7),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 4),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 8),
(9, 'Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 9),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 6),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 4),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 4),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan', 8),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_siswa` int(11) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `tanggal_pinjam` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` enum('Dipinjam','Dikembalikan') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_siswa`, `id_buku`, `tanggal_pinjam`, `tanggal_kembali`, `status`) VALUES
(1, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(2, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(3, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
(4, 4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
(5, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
(6, 15, 7, '2025-02-01', '2025-02-08', 'Dipinjam'),
(7, 7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan'),
(8, 8, 9, '2025-02-03', '2025-02-10', 'Dipinjam'),
(9, 13, 4, '2025-01-27', '2025-02-03', 'Dikembalikan'),
(10, 10, 11, '2025-02-01', '2025-02-08', 'Dipinjam');

--
-- Trigger `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `KurangiStok` BEFORE INSERT ON `peminjaman` FOR EACH ROW BEGIN
    UPDATE buku SET stok = stok - 1 WHERE id_buku = NEW.id_buku;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TambahStok` AFTER UPDATE ON `peminjaman` FOR EACH ROW BEGIN
    IF NEW.status = 'Dikembalikan' THEN
        UPDATE buku SET stok = stok + 1 WHERE id_buku = NEW.id_buku;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int(11) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `kelas` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nama`, `kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL'),
(6, 'Farhan Maulana', 'XII-TKJ'),
(7, 'Gita Permata', 'X-RPL'),
(8, 'Hadi Sucipto', 'X-TKJ'),
(9, 'Intan Permadi', 'XI-RPL'),
(10, 'Joko Santoso', 'XI-TKJ'),
(11, 'Kartika Sari', 'XII-RPL'),
(12, 'Lintang Putri', 'XII-TKJ'),
(13, 'Muhammad Rizky', 'X-RPL'),
(14, 'Novi Andriana', 'X-TKJ'),
(15, 'Olivia Hernanda', 'XI-RPL');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`),
  ADD KEY `id_siswa` (`id_siswa`),
  ADD KEY `id_buku` (`id_buku`);

--
-- Indeks untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id_siswa`),
  ADD CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
