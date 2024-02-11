# Marrow Haus

A Mastodon instance for open source developers assoicated with the Marrow Open Source Collective.


## Utilization

Makefile-based automation is provided for the most common tasks:

* `backup` — Perform a PostgreSQL database archive.
* `clean` — Clean project of temporary, ephemeral, or rebuildable content.
* `help` — Show this help message and exit.
* `migrate` — Execute any migrations required after updating upstream Mastodon references.
* `restore` — Restore the latest PostgreSQL database archive.
* `start` — Start the Docker Compose cluster.
* `stop` — Stop the Docker Compose cluster.
* `update` — Update repository references to upstream Mastodon.

