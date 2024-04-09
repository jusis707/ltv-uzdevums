#/bin/bash
read -p "
===========================================================================================
                                       UZMANĪBU
                          Uzstādīšana notiks interaktīvi...
                       Lūgums sekot norādījumiem uz ekrāna
 Iespējamie izvēles varianti ir apstiprinoši (tikai), jo zūd jēga, ar cita veida darbībām
===========================================================================================
                                  y lai turpinātu
                                CTRL + C lai izietu
===========================================================================================
(y)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
mkdir ~/ltv
cd ~/ltv
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl mc rsync software-properties-common -y
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install kubectl -y
sudo apt-get install bash-completion -y
source /usr/share/bash-completion/bash_completion
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose docker-compose-plugin composer php-curl php-xml php8.2-mbstring php-mbstring -y
echo 'aG9yaXpvbnRzCg==' | base64 --decode > ~/ltv/p.txt
cat ~/ltv/p.txt | docker login --username jusis707 --password-stdin docker.io
clear
minikube config set cpus 4
minikube config set memory 4096
minikube start --insecure-registry "10.0.0.0/24" --driver=docker
echo ""
clear
minikube addons enable metrics-server
echo ""
clear
echo "uzgaidīt..."
minikube addons enable ingress
echo ""
clear
echo "uzgaidīt..."
minikube addons enable registry
echo ""
clear
echo "uzgaidīt..."
minikube ssh 'sudo apt-get install wget -y;wget https://github.com/jusis707/ltv/raw/main/mini.sh -v -O install.sh; chmod +x ./install.sh; bash ./install.sh'
clear
echo "====================================================="
echo  "UZMANĪBU"  # (optional) move to a new line
echo "Docker versija minikube vidē:"
minikube ssh 'docker --version'
echo "====================================================="
echo "...uzgaidīt"
sleep 2
clear
cd ~/ltv
composer create-project laravel/laravel example-app
cd ~/ltv/example-app
rm -rf ~/ltv/example-app/Dockerfile
rm -rf cd ~/ltv/example-app/.env
rm -rf  ~/ltv/example-app/resources/views/welcome.blade.php
wget https://github.com/jusis707/ltv-uzdevums/raw/main/.env -O ~/ltv/example-app/.env -q
wget https://github.com/jusis707/ltv-uzdevums/raw/main/welcome.blade.php -O ~/ltv/example-app/resources/views/welcome.blade.php-q
composer update
wget https://github.com/jusis707/ltv-uzdevums/raw/main/Dockerfile -O ~/ltv/example-app/Dockerfile -q
eval $(minikube -p minikube docker-env)
docker build -t jusis707/lav:12 .
docker push jusis707/lav:12
mkdir ~/ltv/example-app/deployments
cd ~/ltv/example-app/deployments
echo "startējam servisu un aplikāciju manifestus..."
echo "----------------------------------------"
echo ""
sleep 2
wget https://github.com/jusis707/ltv-uzdevums/raw/main/api-deployment.yaml -O ~/ltv/example-app/deployments/api-deployment.yaml -q
wget https://github.com/jusis707/ltv-uzdevums/raw/main/envs.yaml -O ~/ltv/example-app/deployments/envs.yaml -q
wget https://github.com/jusis707/ltv-uzdevums/raw/main/kustomization.yaml -O ~/ltv/example-app/deployments/kustomization.yaml -q
kubectl apply -k ~/ltv/example-app/deployments/
kubectl wait pod --all --for=condition=Ready --timeout=10m 2>/dev/null &
pid=$!  # Capture the process ID of the previous command
spin=( "-" "\\" "|" "/" )  # Create an array for spinner characters
echo -n "[... gaidīt] ${spin[0]}"  # Print the initial spinner character
while kill -0 $pid 2>/dev/null; do  # Check if the process is running
    for i in "${spin[@]}"; do  # Iterate through spinner characters
        echo -ne "\b$i"  # Overwrite previous character with a new one
        sleep 0.2        # Delay for animation effect
    done
done
echo
echo "startējam db manifestus..."
echo "----------------------------------------"
echo ""
sleep 2
wget https://github.com/jusis707/ltv-uzdevums/raw/main/mysql-deployment.yaml -O ~/ltv/example-app/deployments/mysql-deployment.yaml -q
kubectl apply -f ~/ltv/example-app/deployments/mysql-deployment.yaml
echo ""
echo "---------------------------------------"
cd ~/ltv/
clear
minikube ip > ~/ltv/ip-kube &
echo "----------------------------------------"
echo "pievienojam minikube ip adresi laravel.ltv.lv
echo "----------------------------------------"
pēc pieprasījuma, būs jāievada parole (sudo, ar noilgumu):"
echo "----------------------------------------"
sudo -- sh -c "echo $(minikube ip) laravel.ltv.lv >> /etc/hosts"
sleep 2
echo "----------------------------------------"
echo  "Gaidam uz konteineru gatavību
uzstādīts timeout = līdz 10 minūtēm"  # (optional) move to a new line
echo "----------------------------------------"
echo ""
kubectl wait pod --all --for=condition=Ready --timeout=10m 2>/dev/null &
pid=$!  # Capture the process ID of the previous command
spin=( "-" "\\" "|" "/" )  # Create an array for spinner characters
echo -n "[... gaidīt] ${spin[0]}"  # Print the initial spinner character
while kill -0 $pid 2>/dev/null; do  # Check if the process is running
    for i in "${spin[@]}"; do  # Iterate through spinner characters
        echo -ne "\b$i"  # Overwrite previous character with a new one
        sleep 0.2        # Delay for animation effect
    done
done
echo
echo -e "\n"
sleep 2
clear
minikube service stickersng-api --url
cd ~/ltv/example-app/deployments
echo "startējam hps un ingress manifestus..."
echo "----------------------------------------"
kubectl apply -f in.yaml
kubectl apply -f hpa.yaml
clear
##kubectl wait pod --all --for=condition=Ready --timeout=15m
##sleep 1
echo "----------------------------------------"
echo  "Uzskatāmībai, ekrāns būs notīrīts"  # (optional) move to a new line
echo "----------------------------------------"
echo ""
sleep 2
clear
echo "augstāk redzamo piefiksēt"
sleep 3
echo ""
read -p "
----------------------------------------
      lai turpinātu, nospiest y
    tiks sagatavots webhook query
docker versija uz host servera un minikube vidē ir = un atjaunināta
----------------------------------------
(y)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
echo "Ubuntu" >o1
cat /etc/lsb-release | sed -n 4p | awk '{print $2}' >>o1
minikube ssh 'docker --version' | awk '{print $1, $2, $3}' | sed 's/,//' >>o1
cat o1 | awk '{print}' ORS='/' >o2
cat o2 | sed 's/ /_/g'>o3
echo "Pārlūkprogramā atvērt:
https://webhook.site/#!/view/e7aa41df-d4ef-4d54-ae30-d6d74eca380f/a130bafd-3540-4fe2-a973-b1d106efae33/1
"
curl -sS -X POST 'https://webhook.site/e7aa41df-d4ef-4d54-ae30-d6d74eca380f' -H 'content-type: application/json' -d $(cat o3) -o /dev/null
echo ""
echo "augstāk redzamo piefiksēt, un pārliecināties par query datu pareizību atverot saiti"
echo ""
#kubectl get pods -o name --no-headers=true | sed 's/pod\///g'> ./run.pod
#kubectl cp welcome.blade.php `cat run.pod`:/var/www/html/vdc/resources/views/welcome.blade.php
echo ""
read -p "lai turpinātu un pārietu uz MYSQL pārbaudi nospiest y
----------------------------------------
piefiksēt norādīto zemāk, veicot manuāli:
nospiest y un ENTER
----------------------------------------
(y)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
wget https://github.com/jusis707/ltv/raw/main/inst.txt -q
clear
echo -e $(cat ~/ltv/inst.txt)
echo "dzēšam
kubectl delete pod mysql-client"
fi
fi
fi
