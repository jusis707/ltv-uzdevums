#/bin/bash
read -p "
===========================================================================================
                                        UZMANĪBU
                                      bija jāveic:
                                 sudo groupadd docker
                      sudo usermod -aG docker $USER && newgrp docker
===========================================================================================
                                   y lai turpinātu
                                 CTRL + C lai izietu
                                   risinājums Nr.2
                                  
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
echo "---------------------------------------------------------"
echo "uzgaidīt (nav ātri)..."
echo ""
minikube addons enable metrics-server
echo ""
clear
echo "---------------------------------------------------------"
echo "uzgaidīt (nav ātri)..."
echo ""
minikube addons enable ingress
echo ""
clear
echo "---------------------------------------------------------"
echo "uzgaidīt (nav ātri)..."
minikube addons enable registry
echo ""
clear
echo "---------------------------------------------------------"
echo "tiks veikta minikube vides atjaunināšana..."
echo ""
minikube ssh 'curl -sSLv https://raw.githubusercontent.com/jusis707/ltv-uzdevums/main/mini.sh -o install.sh; chmod +x ./install.sh; bash ./install.sh'
echo ""
minikube stop
sleep 2
echo ""
minikube start --insecure-registry "10.0.0.0/24" --driver=docker
echo ""
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
wget https://github.com/jusis707/ltv-uzdevums/raw/main/Dockerfile -O ~/ltv/example-app/Dockerfile -q
wget https://github.com/jusis707/ltv-uzdevums/raw/main/.env -O ~/ltv/example-app/.env -q
mkdir ~/ltv/example-app/deployments
wget https://github.com/jusis707/ltv-uzdevums/raw/main/envs.yaml -O ~/ltv/example-app/deployments/envs.yaml -q
wget https://github.com/jusis707/ltv-uzdevums/raw/main/mysql-deployment.yaml -O ~/ltv/example-app/deployments/mysql-deployment.yaml -q
wget https://github.com/jusis707/ltv-uzdevums/raw/main/api-deployment.yaml -O ~/ltv/example-app/deployments/api-deployment.yaml -q
wget https://github.com/jusis707/ltv-uzdevums/raw/main/kustomization.yaml -O ~/ltv/example-app/deployments/kustomization.yaml -q
composer update
eval $(minikube -p minikube docker-env)
docker build -t jusis707/lav:28 .
docker push jusis707/lav:28
mkdir ~/ltv/example-app/deployments
cd ~/ltv/example-app/deployments
clear
echo ""
echo "startējam servisu un aplikāciju manifestus..."
echo "----------------------------------------"
echo ""
sleep 2
kubectl apply -k ~/ltv/example-app/deployments/
sleep 2
kubectl wait pod --all --for=condition=Ready --timeout=10m 2>/dev/null &
pid=$!
spin=( "-" "\\" "|" "/" )
echo -n "[... gaidīt] ${spin[0]}"
while kill -0 $pid 2>/dev/null; do
    for i in "${spin[@]}"; do
        echo -ne "\b$i"
        sleep 0.2
    done
done
echo
echo -e "\n"
echo ""
sleep 1
clear
echo "----------------------------------------------------------------------"
echo  "Gaidam uz konteineru gatavību
uzstādīts timeout = līdz 10 minūtēm"
echo ""
sleep 2
echo ""
clear
minikube ip > ~/ltv/ip-kube &
echo "----------------------------------------------------------------------"
echo "pievienojam minikube ip adresi laravel.ltv.lv
echo ""
pēc pieprasījuma, būs jāievada parole (sudo, ar noilgumu):"
echo ""
sudo -- sh -c "echo $(minikube ip) laravel.ltv.lv >> /etc/hosts"
sleep 2
clear
echo ""
clear
echo ""
cd ~/ltv/example-app/deployments
clear
echo "----------------------------------------------------------------------"
echo "startējam ingress manifestu..."
echo ""
wget https://github.com/jusis707/ltv-uzdevums/raw/main/in.yaml -O ~/ltv/example-app/deployments/in.yaml -q
kubectl apply -f ~/ltv/example-app/deployments/in.yaml
sleep 2
clear
echo "----------------------------------------------------------------------"
echo ""
echo ""
read -p "
----------------------------------------------------------------------
                  lai turpinātu, nospiest y
               tiks sagatavots webhook query
docker versija uz host servera un minikube vidē ir = un atjaunināta
webhook saite:
https://webhook.site/#!/view/e7aa41df-d4ef-4d54-ae30-d6d74eca380f/a130bafd-3540-4fe2-a973-b1d106efae33/1
----------------------------------------------------------------------
(y)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
os_name="Ubuntu"
os_version=$(cat /etc/lsb-release | sed -n 4p | awk '{print $2}')
docker_version=$(minikube ssh docker version | awk '{print $1, $2, $3}' | tr ',' ' ')
# Combine information into a single file (o1)
printf "%s\n%s\n%s" "$os_name" "$os_version" "$docker_version" >o1
# Format and clean output (o2, o3)
tr '/' '_' < o1 > o2
sed -i 's/ /_/g' o2 
echo "System Information:"
cat o2 | xargs -I {} echo "{}"
echo
#open "https://webhook.site/#!/view/e7aa41df-d4ef-4d54-ae30-d6d74eca380f/a130bafd-3540-4fe2-a973-b1d106efae33/1"
curl -s -X POST -H 'Content-Type: application/json' -d @o2 'https://webhook.site/e7aa41df-d4ef-4d54-ae30-d6d74eca380f'
echo ""
echo "augstāk redzamo piefiksēt, un pārliecināties par query datu pareizību atverot saiti"
echo ""
echo ""
read -p "lai turpinātu un pārietu uz MYSQL pārbaudi nospiest y
--------------------------------------------------------------------------------
piefiksēt norādīto zemāk, veicot manuāli:
nospiest y un ENTER
(datnes veidā "inst2.txt")
--------------------------------------------------------------------------------
(y)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
wget https://github.com/jusis707/ltv-uzdevums/raw/main/inst2.txt -O ~/ltv/inst2.txt -q
clear
echo -e $(cat ~/ltv/inst2.txt)
echo "dzēšam
kubectl delete pod mysql-client
"
fi
fi
fi
