# Duitku

Aplikasi pencatat keuangan untuk mahasiswa, dibuat dengan Flutter.

> Status: **Hari 1** selesai (kerangka proyek, tema, model, repository in-memory,
> layar dasar, dan test). Backend Supabase dihubungkan mulai Hari 2.

## Fitur (target)

- [x] Tambah dan hapus transaksi (pemasukan / pengeluaran)
- [x] Ringkasan saldo bulan berjalan
- [x] Tema terang dan gelap
- [ ] Login dan register (Supabase Auth)
- [ ] CRUD kategori
- [ ] Filter dan pencarian transaksi
- [ ] Budget bulanan per kategori
- [ ] Grafik laporan (pie dan bar)
- [ ] Export CSV
- [ ] Mode offline dan sinkronisasi

## Cara menjalankan

Folder platform (`android/`, `ios/`, dll.) belum disertakan. Buat dulu sekali:

```bash
flutter create . --project-name duitku --org com.namamu
flutter pub get
flutter run
```

Jalankan test:

```bash
flutter test
flutter analyze
```

## Struktur

```
lib/
  core/        tema, warna, util (format rupiah, ikon kategori)
  features/
    categories/   model + data kategori bawaan
    transactions/ model, repository, provider, layar daftar & tambah
    budget/       model + layar (placeholder)
    reports/      ringkasan bulanan + layar laporan
    home/         layar beranda
    settings/     layar profil (placeholder)
  shared/widgets/ widget yang dipakai banyak layar
  shell/          navigasi bawah
test/             unit test model, ringkasan, formatter, repository
supabase/         skema database + Row Level Security
```

Arsitektur singkat: layar -> provider (Riverpod) -> repository (abstrak).
Hari ini repository menyimpan data di memori; nanti cukup mengganti
implementasinya ke Supabase tanpa mengubah layar.

## Rencana

| Hari | Target |
|---|---|
| 1 | Setup proyek, struktur, tema, model, layar dasar |
| 2 | Setup Supabase, tabel, RLS, koneksi dari Flutter |
| 3 | Auth (register, login, logout) + test |
| 4 | CRUD kategori |
| 5 | CRUD transaksi lengkap (edit) + validasi |
| 6 | Filter, pencarian, kelompok per tanggal |
| 7 | Budget bulanan + peringatan |
| 8 | Laporan dengan grafik |
| 9 | Export CSV, error dan loading state |
| 10 | Rapikan UI, tambah test, screenshot |

## Konfigurasi rahasia

Salin `.env.example` jadi `.env` dan isi nilainya. File `.env` sudah ada di
`.gitignore`; jangan pernah di-commit.

## Credits

Isi sumber dan lisensi semua aset di sini.

- Font: Plus Jakarta Sans (SIL Open Font License) lewat paket `google_fonts`
- Ikon: Material Icons bawaan Flutter (Apache 2.0)
- Logo dan ilustrasi: buatan sendiri
