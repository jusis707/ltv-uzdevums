# ltv
# Sistēmu Administrators
### Risinājums 'numur divi'.
### Detalizētāks skaidrojums .pdf dokumentā, nosūtīts uz e-pastu.
##### Uzdevuma izpildē tiks izmantos personīgā docker.io piekļuve un publicēts docker image, kas savukārt tiks uzstādīts jau ar pull (atkārtoti 'vilkts' uz likālo reģistru - uzskatāmībai).
Šajā risinājumā, tiks nodrošināts 'seed' ar saturu uz datubāzi.Darbība veicama, pieslēdzoties podam ar sh. Pod tikai ar laravel aplikāciju (nevis mysql), zem nosaukuma stickerng-api-xxxxxx-xxxxx (piemērs): 

kubectl exec --stdin --tty stickersng-api-849b774587-m8qpc -- /bin/sh
php artisan migrate:refresh && php artisan db:seed
## Noderīgas komandas:
## kubectrun -it --rm --image=mysql:8.0 --restart=Never mysql-client -- mysql -h stickersng-mysql -u stickersng -pstickersng
## php artisan migrate:refresh && php artisan db:seed
## kubectl delete pod mysql-client
## Beigās var apmeklēt adresi: curl http://laravel.ltv.lv
## Webhook saite:
 https://webhook.site/#!/view/e7aa41df-d4ef-4d54-ae30-d6d74eca380f/a130bafd-3540-4fe2-a973-b1d106efae33/1
## curl -sS -X POST 'https://webhook.site/e7aa41df-d4ef-4d54-ae30-d6d74eca380f' -H 'content-type: application/json' -d $(uname) -o /dev/null


