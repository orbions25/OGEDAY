# OGEDAY

Bu repo, `ogedays.com` alani icin ayrilmis bagimsiz yayin hattini ve kurumsal web sitesi iskeletini icerir.

## Mevcut yapi

- Ayrı konteyner uzerinden statik site yayini
- Host seviyesinde nginx reverse proxy ve TLS sonlandirma
- `ogedays.com` ve `www.ogedays.com` icin ayri alan adi yayini
- Orbions ana yayindan bagimsiz deploy hattı

## Repo yapisi

- `.gitlab-ci.yml`
  - GitLab uzerinde statik site ve operasyon politikasi dogrulama hatti
- `.gitlab/`
  - Merge request, task, QA, release, incident ve access request sablonlari
- `CODEOWNERS`
  - Hassas dosyalar icin review sahipligi iskeleti
- `docs/gitlab/`
  - Self-hosted GitLab gecis modeli, pilot plani, rol matrisi, label sistemi, audit register ve runbook
- `scripts/`
  - CI tarafinda calisan dogrulama scriptleri
- `site/index.html`
  - Canli OGEDAY acilis sayfasi
- `site/robots.txt`
  - Arama motorlari icin indeksleme ve sitemap yonlendirmesi
- `site/sitemap.xml`
  - `https://ogedays.com/` icin tek sayfalik sitemap
- `site/nginx.conf`
  - Konteyner ici nginx tanimi
- `docker-compose.yml`
  - Lokal veya alternatif konteyner calistirma omurgasi
- `ops/nginx/`
  - Host nginx icin referans konfigurasyonlar
- `ops/gitlab/`
  - Self-hosted GitLab kurulumu, runner, backup, restore, import ve API bootstrap icin dry-run operasyon yardimcilari

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

Lokal kontrol:

```bash
curl -I http://127.0.0.1:8095
```

## Gelistirme notlari

- Ana gelistirme yuzeyi `site/index.html` dosyasidir.
- Canli site `ogedays.com` uzerinde bu dosyadan servis edilir.
- Iletisim akisi `iletisim@ogedays.com` mailto baglantilari uzerinden calisir.
- SEO icin canonical, Open Graph, Twitter Card, Organization schema, `robots.txt` ve `sitemap.xml` birlikte tutulur.
- Host nginx guvenlik basliklari `ops/nginx/ogedays.com.conf` icinde; konteyner ici basliklar `site/nginx.conf` icindedir.
- GitLab gecisinde her degisiklik task veya access request ile baslamali, MR sablonu eksiksiz doldurulmalidir.
- Production, nginx, TLS, runner, CI secret veya deploy alanlari icin sureli access request akisi kullanilmalidir.
- Canli yayina cikmadan once QA Validation ve Release Checklist issue'lari tamamlanmalidir.
- Incident, emergency access, runner-secret ve backup/restore konulari `docs/gitlab/` altindaki runbooklarla izlenmelidir.
- Self-hosted GitLab kurulumu icin `ops/gitlab/` altindaki scriptler once dry-run olarak incelenmelidir.
- GitLab primary olmadan once cutover checklist tamamlanmali ve GitHub fallback plani korunmalidir.
- Ilk pilot issue'lari, release evidence formati ve automation readiness kurallari GitLab'a gecmeden once hazir tutulmalidir.

## Not

Bu repo bundan sonra OGEDAY ile ilgili tum web ve yayin degisiklikleri icin ana kaynak olarak kullanilacaktir.
