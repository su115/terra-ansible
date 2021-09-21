_ansible:
	cd ansible/ && \
	./get_ip.sh &&\
	ansible -m ping all && \
	ansible-playbook play-books/k8s_all.yaml

destroy: destroy_instance destroy_network destroy_s3
apply: apply_s3 apply_network apply_instance

destroy_s3:
	cd s3/ && \
	yes yes| terraform destroy
	
destroy_network:
	cd network/ && \
	yes yes| terraform destroy -lock=false

destroy_instance:
	cd instance/ && \
	yes yes| terraform destroy -lock=false


apply_s3:
	cd s3/ && \
	yes yes| terraform apply
	
apply_network:
	cd network/ && \
	yes yes| terraform apply -lock=false

apply_instance:
	cd instance/ && \
	yes yes| terraform apply -lock=false


