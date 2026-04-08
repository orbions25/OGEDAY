# OGEDAY

Bu repo, `ogedays.com` alani icin ayrilmis bagimsiz yayin hattini ve kurumsal web sitesi iskeletini icerir.

## Mevcut yapi

- Ayrı konteyner uzerinden statik site yayini
- Host seviyesinde nginx reverse proxy ve TLS sonlandirma
- `ogedays.com` ve `www.ogedays.com` icin ayri alan adi yayini
- Orbions ana yayindan bagimsiz deploy hattı

## Repo yapisi

- `site/index.html`
  - Canli OGEDAY acilis sayfasi
- `site/nginx.conf`
  - Konteyner ici nginx tanimi
- `docker-compose.yml`
  - Lokal veya alternatif konteyner calistirma omurgasi
- `ops/nginx/`
  - Host nginx icin referans konfigurasyonlar

## Canli sunucu notlari

- Canli yayin klasoru: `/var/www/ogedays`
- Konteyner publish portu: `127.0.0.1:8095 -> 80`
- TLS dosyalari:
  - `/etc/ssl/ogedays/ogedays.com.key`
  - `/etc/ssl/ogedays/ogedays.com.crt`
  - `/etc/ssl/ogedays/ogedays.com.ca-bundle`
  - `/etc/ssl/ogedays/ogedays.com.fullchain.pem`

## Calistirma

```bash
docker compose up -d
```

## Not

Bu repo bundan sonra OGEDAY ile ilgili tum web ve yayin degisiklikleri icin ana kaynak olarak kullanilacaktir.
