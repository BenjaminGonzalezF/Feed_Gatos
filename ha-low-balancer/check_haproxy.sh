#!/bin/bash
#/etc/keepalived/check_haproxy.sh
#chmod +x /etc/keepalived/check_haproxy.sh

# Direcciones IP e instancias
IP_MASTER="10.128.0.20"
NOMBRE_INSTANCIA_MASTER="master"
IP_WORKER1="10.128.0.21"
NOMBRE_INSTANCIA_WORKER1="worker1"
IP_WORKER2="10.128.0.22"
NOMBRE_INSTANCIA_WORKER2="worker2"

IP_VIP="34.72.250.6"
IP_BACKUP1="34.29.106.249"
IP_BACKUP2="35.226.68.81"

# Zona de las instancias (ajústalo según tus necesidades)
ZONA="us-central1-a"

# Función para realizar la petición y procesar la respuesta
function hacer_ping() {
    local ip=$1
    local nombre_instancia=$2

    echo "Haciendo ping a $nombre_instancia ($ip)"
    if ping -c 1 "$ip" >/dev/null 2>&1; then
        echo "$nombre_instancia respondió correctamente"
        return 0
    else
        echo "$nombre_instancia no respondió"
        return 1
    fi
}

# Verificar cada instancia en orden
if hacer_ping "$IP_MASTER" "$NOMBRE_INSTANCIA_MASTER"; then
    # La instancia master respondió, actualizar las otras instancias
    gcloud compute instances delete-access-config "$NOMBRE_INSTANCIA_WORKER1" --zone "$ZONA" --access-config-name="External NAT"
    gcloud compute instances delete-access-config "$NOMBRE_INSTANCIA_WORKER2" --zone "$ZONA" --access-config-name="External NAT"
    gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_WORKER1" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_WORKER1"
    gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_WORKER2" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_WORKER2"

    gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_MASTER" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_VIP"
    gcloud compute instances delete-access-config "$NOMBRE_INSTANCIA_MASTER" --zone "$ZONA" --access-config-name="External NAT"
    gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_MASTER" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_VIP"


else
    if hacer_ping "$IP_WORKER1" "$NOMBRE_INSTANCIA_WORKER1"; then
        # La instancia worker1 respondió
        gcloud compute instances delete-access-config "$NOMBRE_INSTANCIA_MASTER" --zone "$ZONA" --access-config-name="External NAT"
        gcloud compute instances delete-access-config "$NOMBRE_INSTANCIA_WORKER2" --zone "$ZONA" --access-config-name="External NAT"
        gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_MASTER" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_WORKER1"
        gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_WORKER2" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_WORKER2"


        gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_WORKER1" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_VIP"
        gcloud compute instances delete-access-config "$NOMBRE_INSTANCIA_WORKER1" --zone "$ZONA" --access-config-name="External NAT"
        gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_WORKER1" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_VIP"

    elif hacer_ping "$IP_WORKER2" "$NOMBRE_INSTANCIA_WORKER2"; then
        # La instancia worker2 respondió
        gcloud compute instances delete-access-config "$NOMBRE_INSTANCIA_MASTER" --zone "$ZONA" --access-config-name="External NAT"
        gcloud compute instances delete-access-config "$NOMBRE_INSTANCIA_WORKER1" --zone "$ZONA" --access-config-name="External NAT"
        gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_MASTER" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_WORKER1"
        gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_WORKER1" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_WORKER2"

        gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_WORKER2" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_VIP"
        gcloud compute instances delete-access-config "$NOMBRE_INSTANCIA_WORKER2" --zone "$ZONA" --access-config-name="External NAT"
        gcloud compute instances add-access-config "$NOMBRE_INSTANCIA_WORKER2" --zone "$ZONA" --access-config-name="External NAT" --address="$IP_VIP"


    else
        echo "Ninguna instancia respondió"
    fi
fi
