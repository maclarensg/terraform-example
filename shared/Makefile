TERRAFORM_VERSION :=1.0.5
TERRAFORM				:= "hashicorp/terraform"
TERRAFORM_SHELL := docker run --rm -it -v $(PWD)/../env:/env -v $(HOME)/.aws:/root/.aws -v $(HOME)/.ssh:/root/.ssh -v $(PWD):/tf -w='/tf' --entrypoint /bin/sh $(TERRAFORM):$(TERRAFORM_VERSION)
TERRAFORM_RM    := docker run --rm -it -v $(PWD)/../env:/env -v $(HOME)/.aws:/root/.aws -v $(HOME)/.ssh:/root/.ssh -v $(PWD):/tf -w='/tf' --entrypoint /bin/rm $(TERRAFORM):$(TERRAFORM_VERSION)
TERRAFORM_BIN 	:= docker run --rm -it -v $(PWD)/../env:/env -v $(HOME)/.aws:/root/.aws -v $(HOME)/.ssh:/root/.ssh -v $(PWD):/tf -w='/tf' $(TERRAFORM):$(TERRAFORM_VERSION)

test: 
	@echo $(HOME)
	@echo $(TERRAFORM)
	@echo $(TERRAFORM_VERSION)

clean: 
	@$(TERRAFORM_RM) -rf .terraform terraform.tfstate terraform.tfstate.d .terraform.lock.hcl

init: 
	@echo "=== init ==="
	@[ "$(env)" ] || (echo "env not set"; exit 1) 
	@$(TERRAFORM_BIN) init -upgrade -backend-config=/env/$(env).tfvars

workspace: init 
	@( $(TERRAFORM_BIN) workspace new $(env) ) || ( $(TERRAFORM_BIN) workspace select $(env) )

plan: workspace
	@echo "=== plan ==="
	@$(TERRAFORM_BIN) plan -out terraform.tfplan

refresh: workspace
	@echo "=== refresh ==="
	@$(TERRAFORM_BIN) refresh

shell: workspace
	@echo "=== shell ==="
	@$(TERRAFORM_SHELL)

confirm:
	@printf "Do you want to apply(n/Y)? "; \
    read OPT; \
    if [ "$${OPT}" !=  "Y" ] && [ "$${OPT}" !=  "y" ] ; then\
        echo "Discard plan.";\
				rm terraform.tfplan ;\
		exit 1;\
    fi
		
apply: plan confirm 
	@echo "=== apply ==="
	@$(TERRAFORM_BIN) apply terraform.tfplan


.PHONY: test clean init plan refresh shell

