ORG ?=

images: build-pulp-core \
        build-pulp-api \
        build-pulp-content \
        build-pulp-resource-manager \
        build-pulp-worker

release: release-pulp-core \
         release-pulp-api \
         release-pulp-content \
         release-pulp-resource-manager \
         release-pulp-worker

build-%:
	$(eval IMAGE := $(patsubst build-%,%,$@))
	sed -i "s,FROM kong/pulp-core,FROM $(ORG)pulp-core,g" $(IMAGE)/Dockerfile
	cd $(IMAGE) && docker build -t $(ORG)$(IMAGE) .

release-%:
	$(eval IMAGE := $(patsubst release-%,%,$@))
	cd $(IMAGE) && docker push $(ORG)$(IMAGE)
