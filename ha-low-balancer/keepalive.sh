reasignar_ip_y_ping() {
    # Desasignar la IP actual y asignar una nueva
    gcloud compute instances delete-access-config $NOMBRE_INSTANCIA --zone $ZONA --access-config-name="External NAT"
    gcloud compute instances add-access-config $NOMBRE_INSTANCIA --zone $ZONA --access-config-name="External NAT" --address=$NUEVA_IP

    # Hacer ping a la dirección proporcionada
    ping_destino=$1
    while true; do
        if ping -c 1 -W 1 $ping_destino >/dev/null 2>&1; then
            echo "Ping exitoso a $ping_destino"
        else
            echo "No hay conexión a $ping_destino. Reasignando IP..."
            break
        fi
        sleep 3
    done
}

# Direcciones IP y nombres de instancias
IP_MASTER="10.128.0.20"
IP_WORKER="10.128.0.21"
NUEVA_IP="34.72.250.6"
NOMBRE_INSTANCIA_MASTER="master"
NOMBRE_INSTANCIA_WORKER="worker1"
ZONA="us-central1-a"

# Bucle principal
while true; do
    reasignar_ip_y_ping $IP_MASTER

    # En caso de no haber conexión a 10.128.0.20
    reasignar_ip_y_ping $IP_WORKER

    # En caso de no haber conexión a 10.128.0.21
done