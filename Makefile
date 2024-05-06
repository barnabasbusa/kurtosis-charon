.PHONY: run geth-lighthouse geth-nimbus geth-lodestar geth-prysm geth-teku charon run-charon-lighthouse run-charon-nimbus run-charon-lodestar run-charon-prysm run-charon-teku clean

# Define the composite step
geth-lighthouse-charon-lighthouse: geth-lighthouse charon run-charon-lighthouse
geth-lighthouse-charon-lodestar: geth-lighthouse charon run-charon-lodestar
geth-lighthouse-charon-teku: geth-lighthouse charon run-charon-teku
geth-lighthouse-charon-nimbus: geth-lighthouse charon run-charon-nimbus
geth-lighthouse-charon-prysm: geth-lighthouse charon run-charon-prysm

geth-lodestar-charon-lighthouse: geth-lodestar charon run-charon-lighthouse
geth-lodestar-charon-lodestar: geth-lodestar charon run-charon-lodestar
geth-lodestar-charon-teku: geth-lodestar charon run-charon-teku
geth-lodestar-charon-nimbus: geth-lodestar charon run-charon-nimbus
geth-lodestar-charon-prysm: geth-lodestar charon run-charon-prysm

geth-teku-charon-lighthouse: geth-teku charon run-charon-lighthouse
geth-teku-charon-lodestar: geth-teku charon run-charon-lodestar
geth-teku-charon-teku: geth-teku charon run-charon-teku
geth-teku-charon-nimbus: geth-teku charon run-charon-nimbus
geth-teku-charon-prysm: geth-teku charon run-charon-prysm

geth-nimbus-charon-lighthouse: geth-nimbus charon run-charon-lighthouse
geth-nimbus-charon-lodestar: geth-nimbus charon run-charon-lodestar
geth-nimbus-charon-teku: geth-nimbus charon run-charon-teku
geth-nimbus-charon-nimbus: geth-nimbus charon run-charon-nimbus
geth-nimbus-charon-prysm: geth-nimbus charon run-charon-prysm

geth-prysm-charon-lighthouse: geth-prysm charon run-charon-lighthouse
geth-prysm-charon-lodestar: geth-prysm charon run-charon-lodestar
geth-prysm-charon-teku: geth-prysm charon run-charon-teku
geth-prysm-charon-nimbus: geth-prysm charon run-charon-nimbus
geth-prysm-charon-prysm: geth-prysm charon run-charon-prysm

geth-lighthouse:
	rm -f planprint
	kurtosis run --enclave local-eth-testnet github.com/kurtosis-tech/ethereum-package --args-file ./network_params_geth_lighthouse.yaml > planprint
	@echo "Waiting for 10 seconds..."
	@sleep 10

geth-nimbus:
	rm -f planprint
	kurtosis run --enclave local-eth-testnet github.com/kurtosis-tech/ethereum-package --args-file ./network_params_geth_nimbus.yaml > planprint
	@echo "Waiting for 10 seconds..."
	@sleep 10

geth-lodestar:
	rm -f planprint
	kurtosis run --enclave local-eth-testnet github.com/kurtosis-tech/ethereum-package --args-file ./network_params_geth_lodestar.yaml > planprint
	@echo "Waiting for 10 seconds..."
	@sleep 10

geth-prysm:
	rm -f planprint
	kurtosis run --enclave local-eth-testnet github.com/kurtosis-tech/ethereum-package --args-file ./network_params_geth_prysm.yaml > planprint
	@echo "Waiting for 60 seconds... don't skip the wait"
	@sleep 60

geth-teku:
	rm -f planprint
	kurtosis run --enclave local-eth-testnet github.com/kurtosis-tech/ethereum-package --args-file ./network_params_geth_teku.yaml > planprint
	@echo "Waiting for 60 seconds... don't skip the wait"
	@sleep 60

charon:
	./run_charon.sh
	./promtoken.sh

run-charon-lighthouse:
	docker compose up node0 node1 node2 vc0-lighthouse vc1-lighthouse vc2-lighthouse prometheus -d

run-charon-nimbus:
	docker compose up node0 node1 node2 vc0-nimbus vc1-nimbus vc2-nimbus prometheus -d

run-charon-lodestar:
	docker compose up node0 node1 node2 vc0-lodestar vc1-lodestar vc2-lodestar prometheus -d

run-charon-prysm:
	docker compose up node0 node1 node2 vc0-prysm vc1-prysm vc2-prysm prometheus -d

run-charon-teku:
	docker compose up node0 node1 node2 vc0-teku vc1-teku vc2-teku prometheus -d

clean:
	-docker compose down
	-kurtosis enclave stop local-eth-testnet
	-kurtosis enclave rm local-eth-testnet
	rm -rf node*
	rm -f planprint
	rm -rf keystore
	rm -rf testnet
	rm -rf charon-keystore
	rm -rf charon-keys
	rm -rf .charon
	rm -rf data
