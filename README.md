# ltv-uzdevums
##### Uzdevuma izpildē tiks izmantos personīgā docker.io piekļuve un publicēts docker image ar "vienādu" nosaukumu, visas instālācijas laikā jeb vienkāršāk skaidrojot:
docker build un kubectl apply -f būs startēts ar vienu un to pašu 'image' nosaukumu, paredzētu vienreizējai instalācijai jeb instalēšanas laikā tiks uzbūvēts image ar jau paredzētu nosaukumu, pēc uzbūvēšanas, kas rada problemātiku startēt instalāciju atkārtoti, pie iespējamām izmaiņām.

### datubāzes
kubectrun -it --rm --image=mysql:8.0 --restart=Never mysql-client -- mysql -h stickersng-mysql -u stickersng -pstickersng
CMD php artisan migrate:refresh && php artisan db:seed
kubectdelete pod mysql-client

