# ltv-uzdevums
##### Uzdevuma izpildē tiks izmantos personīgā docker.io piekļuve un publicēts docker image ar "vienādu" nosaukumu, visas instālācijas laikā jeb vienkāršāk skaidrojot:
docker build un kubectl apply -f būs startēts ar vienu un to pašu 'image' nosaukumu, paredzētu vienreizējai instalācijai jeb instalēšanas laikā tiks uzbūvēts image ar jau paredzētu nosaukumu, pēc uzbūvēšanas, kas rada problemātiku startēt instalāciju atkārtoti, pie iespējamām izmaiņām.

### datubāzes
## kubectrun -it --rm --image=mysql:8.0 --restart=Never mysql-client -- mysql -h stickersng-mysql -u stickersng -pstickersng
## php artisan migrate:refresh && php artisan db:seed
## kubectl delete pod mysql-client
## kubectl run -it --rm --image=mysql:8.0 --restart=Never mysql-client -- mysql -h stickersng-mysql -u stickersng -pstickersng
## SHOW DATABASES;
## QUIT;
## kubectl exec --stdin --tty stickersng-api-849b774587-m8qpc -- /bin/sh
## php artisan migrate:refresh && php artisan db:seed
## Beigās var apmeklēt adresi: curl http://laravel.ltv.lv
## [https://webhook.site/#!/view/e7aa41df-d4ef-4d54-ae30-d6d74eca380f/a130bafd-3540-4fe2-a973-b1d106efae33/1](https://webhook.site/#!/view/e7aa41df-d4ef-4d54-ae30-d6d74eca380f/a130bafd-3540-4fe2-a973-b1d106efae33/1)
## curl -sS -X POST 'https://webhook.site/e7aa41df-d4ef-4d54-ae30-d6d74eca380f' -H 'content-type: application/json' -d $(uname) -o /dev/null
## Noderīgi:
## - Pārbaudīt mysql datubāzes pieejamību, katru komandrindu startējot atsevišķi (nospiest ENTER pēc pieprasījuma). Ir jāgaida lai servisi startējas...\n
## kubectl run -it --rm --image=mysql:latest mysql-test -- mysql -h stickersng-mysql -u stickersng -pstickersng \n
## SHOW DATABASES; \n
## QUIT; \n
## Datubāzes sīdošana ar dump-seed saturu tiek veikta pieslēdzoties podam ar sh(piemērs):
## kubectl exec --stdin --tty stickersng-api-849b774587-m8qpc -- /bin/sh
##php artisan migrate:refresh && php artisan db:seed
## Beigās var apmeklēt adresi: curl http://laravel.ltv.lv
## Webhook saite, kura jāatver bash skripta darbības laikā:
https://webhook.site/#!/view/e7aa41df-d4ef-4d54-ae30-d6d74eca380f/5cd180a3-7394-4c43-9705-1e6c5bd1f91f/1

