#/etc/keepalived/takeover.sh

# Unassign peer's IP aliases. Try it until it's possible.
until gcloud compute instances network-interfaces update worker1 --zone us-central1-a --aliases "" > /etc/keepalived/takeover.log 2>&1; do
    echo "Instance not accessible during takeover. Retrying in 5 seconds..."
    sleep 5
done
# Assign IP aliases to me because now I am the MASTER!
gcloud compute instances network-interfaces update master --zone us-central1-a --aliases "34.72.250.6/32 >> /etc/keepalived/takeover.log 2>&1
systemctl restart haproxy
echo "I became the MASTER at: $(date)" >> /etc/keepalived/takeover.log