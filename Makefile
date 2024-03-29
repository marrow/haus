.PHONY: backup clean migrate restart restore start stop update

help:  ## Show this help message and exit.
	@echo "Usage: make <command>\n\033[36m\033[0m"
	@awk 'BEGIN {FS = ":.*##"} /^[0-9a-zA-Z_-]+:.*?##/ { printf "\033[36m%-18s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST) | sort

clean:  ## Clean project of temporary, ephemeral, or rebuildable content.
	@echo "TBD"

build:  ## Prepare the Docker Compose cluster.
	docker-compose build

init: build  ## Perform initial setup of a new Mastodon instance.
	docker-compose run --rm web bundle exec rake mastodon:setup
	docker-compose run --rm web bundle exec rake mastodon:webpush:generate_vapid_key

start:  ## Start the Docker Compose cluster.
	docker-compose up -d

restart:  ## Restart the Docker compose cluster.
	docker-compose restart

stop:  ## Stop the Docker Compose cluster.
	docker-compose down

shell:  ## Execute a BASH shell within the web application container.
	docker-compose run --rm web bundle exec /bin/bash

update:  ## Update repository references to upstream Mastodon.
	$(eval current := $(shell git -C mastodon rev-parse --abbrev-ref HEAD 2> /dev/null))
	@echo "Current version: ${current}"
	
	@git -C mastodon fetch --tags -q
	$(eval latest := $(shell git -C mastodon branch -a | grep stable | tail -n 1 | sed -e 's/^  remotes\/origin\///' 2> /dev/null))
	@echo " Latest version: ${latest}"
	@echo
	
ifeq ($(current), $(latest))
	@echo "\tNothing to update."
else
	@echo "\tUpgrade required.\n\tPlease see: https://docs.joinmastodon.org/admin/upgrading/"
	# Instructions may vary from version to version during upgrade.
	# Ref: https://www.bentasker.co.uk/posts/blog/general/upgrading-a-docker-mastodon-instance-to-gain-security-fixes.html
endif

migrate:  ## Execute any migrations required after updating upstream Mastodon references.
	@echo "TBD"
	# docker-compose run --rm web bundle exec rake chewy:upgrade

backup:  ## Perform a PostgreSQL database backup.
	docker exec mastodon-db-1 pg_dumpall -U postgres | gzip > backup/`date +'%Y%m%d'`.sql.gz

restore:  ## Restore the latest PostgreSQL database backup.
	@echo "Please see: https://ashfurrow.com/blog/restoring-a-postgres-mastodon-database/"
	# See also: https://docs.joinmastodon.org/admin/migrating/
	#docker compose down
	#docker-compose up -d db

