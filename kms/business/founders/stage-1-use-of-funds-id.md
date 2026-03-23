# Halava Penggunaan Dana Stage 1 (JPY 3M)

> Last updated: March 10, 2026
> Status: Draft anggaran kerja
>
> Related documents:
> - [[founder-structure]]
> - [[milestone-earn-in-schedule]]
> - [[founder-agreement-consolidated-id]]

---

## 1. Tujuan Anggaran

Pendanaan `Stage 1` (`JPY 3,000,000`) ditujukan untuk eksekusi build-to-launch dari **March 2026 sampai August 2026**.

Penggunaan utama:

- salary part-time Founder
- cloud dan operating services untuk pengembangan MVP dan kesiapan launch
- additional part-time contributor ketika kapasitas Founder sudah tidak lagi cukup untuk milestone yang disepakati

Jika ada bagian dari `JPY 3,000,000` yang tidak terpakai saat launch, sisa dana tersebut tetap berada di Halava sebagai company reserve untuk operasi pasca-launch.

---

## 2. Asumsi Rate Tenaga Kerja

- rate part-time Founder: `JPY 1,500/jam`
- rate additional part-time: `JPY 1,200/jam`
- batas mingguan per orang: `28 jam/minggu`
- konversi bulan yang dipakai untuk estimasi: rata-rata tahunan presisi `52/12 = 4.333333... minggu/bulan`

Estimasi biaya tenaga kerja bulanan pada batas maksimum:

- Founder (`28j/minggu`): `JPY 182,000/bulan`
- Additional part-time (`28j/minggu`): `JPY 145,600/bulan`

---

## 3. Estimasi Biaya Cloud dan Service (MVP yang Realistis)

Estimasi ini disesuaikan dengan asumsi arsitektur saat ini, termasuk frontend hosting, API hosting, managed Postgres, cache, object storage, email, maps, dan monitoring.

| Item Biaya                  | Baseline Bulanan      | Kisaran Umum                  |
| --------------------------- | --------------------- | ----------------------------- |
| Frontend hosting dan CDN    | `JPY 3,000`           | `JPY 2,000-6,000`             |
| API compute dan runtime     | `JPY 8,000`           | `JPY 5,000-15,000`            |
| Managed Postgres dan backup | `JPY 7,000`           | `JPY 5,000-12,000`            |
| Redis/cache                 | `JPY 2,000`           | `JPY 1,000-4,000`             |
| Object storage dan egress   | `JPY 2,000`           | `JPY 1,000-5,000`             |
| Email service               | `JPY 2,000`           | `JPY 1,000-5,000`             |
| Maps/geocoding              | `JPY 3,000`           | `JPY 0-8,000`                 |
| Monitoring/logging          | `JPY 4,000`           | `JPY 2,000-8,000`             |
| Domain/DNS/misc tooling     | `JPY 2,000`           | `JPY 1,000-4,000`             |
| **Total**                   | **`JPY 33,000/bulan`** | **`JPY 20,000-67,000/bulan`** |

Baseline perencanaan kerja untuk `Stage 1`: `JPY 33,000/bulan`.

---

## 4. Skenario Pengeluaran Stage 1 March-August (6 Bulan)

| Skenario | Burn Rate Bulanan | Total Pengeluaran (Mar-Aug) | Sisa dari `JPY 3M` saat Launch |
|---------|-------------------|-----------------------------|--------------------------------|
| Founder saja (`28j/minggu`) + cloud baseline | `JPY 215,000` | `JPY 1,290,000` | `JPY 1,710,000` |
| Founder (`28j/minggu`) + additional part-time (`14j/minggu`) + cloud baseline | `JPY 287,800` | `JPY 1,726,800` | `JPY 1,273,200` |
| Founder (`28j/minggu`) + additional part-time (`20j/minggu`) + cloud baseline | `JPY 319,000` | `JPY 1,914,000` | `JPY 1,086,000` |
| Founder (`28j/minggu`) + additional part-time (`28j/minggu`) + cloud baseline | `JPY 360,600` | `JPY 2,163,600` | `JPY 836,400` |

---

## 5. Prioritas Pendanaan dan Aturan Kontrol

Urutan prioritas pengeluaran untuk `Stage 1`:

1. salary part-time Founder dalam batas jam yang disetujui
2. cloud dan operating services yang dibutuhkan untuk MVP delivery dan launch
3. additional part-time contributor, hanya jika runway yang diproyeksikan masih cukup untuk launch plan

Aturan kontrol:

- model staffing default pada `Stage 1` adalah founder-only dari March sampai August
- additional part-time support ditambahkan ketika Founder tidak lagi dapat mempertahankan delivery terhadap milestone yang disepakati
- setiap keputusan untuk menambah part-time contributor sebaiknya dibuat setelah diskusi antara Founder dan Co-founder, lalu dicatat secara tertulis melalui message atau meeting note
- additional part-time hours hanya boleh ditingkatkan jika proyeksi budget yang tersisa masih selaras dengan timeline launch dan milestone yang disepakati
- rate part-time Founder untuk `Stage 1` ditetapkan di `JPY 1,500/jam` untuk March-August 2026
- perubahan rate salary Founder ditinjau pada `Stage 2` dan memerlukan persetujuan tertulis dari Founder dan Co-founder
- Co-founder tidak menerima salary `Stage 1` secara default; return ekonomi Co-founder pada `Stage 1` datang melalui equity earn-in berdasarkan [[milestone-earn-in-schedule]]

Aturan reserve:

- sisa saldo `Stage 1` pada saat launch tetap ditahan oleh Halava sebagai operating reserve dan tidak didistribusikan sebagai founder payout

---

## 6. Tracking Anggaran Bulanan

Review bulanan sebaiknya mencakup:

- actual founder hours dan payout
- actual additional part-time hours dan payout
- actual cloud/services spend dibanding baseline
- proyeksi runway yang diperbarui berdasarkan sisa saldo `Stage 1`
- ETA launch dibanding runway

---

#halava #business #founders #budget #use-of-funds
