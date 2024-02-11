.PHONY: clean start stop restart update migrate

clean:  ## Clean project of temporary, ephemeral, or rebuildable content.
	@echo "TBD"

start:  ## Start the Docker Compose cluster.
	@echo "TBD"

stop:  ## Stop the Docker Compose cluster.
	@echo "TBD"

update:  ## Update repository references to upstream Mastodon.
	@echo "TBD"

migrate:  ## Execute any migrations required after updating upstream Mastodon references.
	@echo "TBD"

backup:  ## Perform a PostgreSQL database backup.
	docker exec mastodon-db-1 pg_dumpall -U postgres | gzip > backup/`date +'%Y%m%d'`.sql.gz

restore:  ## Restore the latest PostgreSQL database backup.
	@echo "TBD"

help:  ## Show this help message and exit.
	@echo "Usage: make <command>\n\033[36m\033[0m"
	@awk 'BEGIN {FS = ":.*##"} /^[0-9a-zA-Z_-]+:.*?##/ { printf "\033[36m%-18s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST) | sort

