_s3:
	cd s3/ && \
	pwd && \
	yes yes| terraform apply
	
_network:
	cd network/ && \
	yes yes| terraform apply -lock=false

_instance:
	cd instance/ && \
	yes yes| terraform apply -lock=false

_ansible:
	cd ansible/ && \
	./get_ip.sh


