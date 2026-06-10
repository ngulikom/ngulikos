# NgulikOS Tuner

Halo sobat digital!! 😭🔥

NgulikOS Tuner adalah kumpulan tweak Windows yang dibuat khusus untuk **Windows 10 IoT Enterprise LTSC 2021**.

Project ini lahir setelah mamang terlalu sering ketemu laptop kentang yang:

* RAM udah ditambah
* Windows udah LTSC
* HDD masih sehat

tapi tetap bikin emosi pas dipakai.

Jadi tujuan project ini simpel:

**bikin Windows lebih anteng.**

Bukan lebih sakti.

---

# ⚠️ DISCLAIMER

Project ini bersifat eksperimental.

Script ini akan mengubah:

* Registry
* Services
* Scheduled Tasks
* Windows Policies
* Windows Update Components

Gunakan dengan risiko sendiri.

Kalau Windows tiba-tiba ngamuk, error, drama, atau bikin masalah...

ya itu risiko dunia per-ngulik-an 😭

Selalu backup data penting sebelum menjalankan script.

---

# 🎯 TUJUAN PROJECT

NgulikOS dibuat untuk:

* mengurangi aktivitas HDD
* mengurangi background process
* mengurangi telemetry
* mengurangi task yang suka jalan sendiri
* mengurangi aktivitas Windows Update
* membuat Windows terasa lebih responsif

Target utama project ini:

* Intel Atom Series
* Intel Celeron Series
* AMD E-Series
* HDD 5400 RPM
* Laptop kentang lainnya

---

# ⚠️ IMPORTANT

NgulikOS dikembangkan dan diuji khusus pada:

* Windows 10 IoT Enterprise LTSC 2021
* Intel Celeron N2840
* HDD 500GB 5400RPM
* RAM 8GB

Versi Windows lain mungkin bisa berjalan.

Tapi bukan target utama project ini.

---

# 🚀 MODE

## SAFE

Mode paling aman.

Perubahan:

* Telemetry reduction
* Xbox Services OFF
* OneDrive reduction
* Consumer Features OFF
* Delivery Optimization reduction
* Visual optimization

Windows Defender tetap aktif.

Windows Update tetap tersedia.

---

## HDD MODE

SAFE +

Fokus mengurangi aktivitas HDD.

Tambahan:

* SysMain OFF
* Windows Search OFF
* Defender Scheduled Scan OFF
* Edge Updater OFF
* Storage Sense OFF
* Automatic Maintenance OFF
* Hibernate OFF
* High Performance Power Plan

Ini adalah mode yang paling direkomendasikan oleh mamang.

---

## POTATO

HDD MODE +

Lebih agresif.

Tambahan:

* CompatTelRunner OFF
* Telemetry Task OFF
* Background Apps OFF
* Consumer Experience OFF
* Print Spooler OFF
* Fax OFF
* Additional Scheduled Tasks OFF

---

## POTATO+

POTATO +

Tambahan:

* WaaSMedic OFF
* UsoSvc OFF
* UpdateOrchestrator OFF
* Windows Update Host Blocking

Windows Defender tetap aktif.

Windows Update dibuat jauh lebih anteng.

---

## NUCLEAR

⚠️ MODE GILA

Tambahan:

* Windows Defender OFF
* Security Center OFF
* BITS OFF
* Error Reporting OFF
* Windows Update OFF
* Telemetry OFF
* Background Service seminimal mungkin

Kalau sobat digital memilih mode ini...

berarti sobat digital sudah tahu risikonya 😭🔥

---

## CLEAN

Membersihkan:

* Temp Files
* Update Cache
* Browser Cache
* Event Logs
* Recycle Bin
* Prefetch

---

## BENCHMARK

Menampilkan:

* CPU Usage
* RAM Usage
* Disk Information
* Status Service Penting
* WinSAT Benchmark

---

## ROLLBACK

Mencoba mengembalikan sebagian besar tweak ke kondisi default Windows.

Tidak menjamin 100% kembali seperti fresh install.

---

# 🧠 HIERARKI MODE

```text
SAFE
 └── HDD MODE
      └── POTATO
           └── POTATO+
                └── NUCLEAR
```

Semua mode bersifat bertingkat.

Contoh:

Jika memilih POTATO+ maka SAFE, HDD MODE, dan POTATO juga ikut diterapkan.

---

# 🔥 YANG TIDAK BISA DIPERBAIKI SCRIPT INI

❌ Mengubah N2840 menjadi Core i5

❌ Menambah FPS secara ajaib

❌ Menyembuhkan HDD yang sudah rusak

❌ Menggantikan SSD

❌ Memperbaiki driver yang bermasalah

❌ Membuat laptop 10 tahun terasa seperti laptop baru

Kalau bottleneck utama memang CPU atau HDD yang sudah sekarat...

ya tetap aja CPU dan HDD itu yang bakal jadi bottleneck 😭

NgulikOS hanya mengurangi beban Windows.

NgulikOS tidak bisa menciptakan performa dari hardware yang memang tidak ada.

---

# 🚀 CARA PAKAI

1. Download script
2. Klik kanan
3. Run as Administrator
4. Pilih mode yang diinginkan
5. Restart Windows

Selesai.

---

# 💡 FILOSOFI NGULIKOS

Kalau laptopnya belum bisa kenceng...

minimal jangan bikin emosi.

— Ngulikom 😭🔥
