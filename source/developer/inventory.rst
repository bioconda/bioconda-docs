Inventory
=========

autobump bot
------------

Checks upstream repository for version updates, if so, creates a new
bioconda-recipes recipe with the updated version and an updated hash, and opens
a new pull request with various templated info and with the "autobump" label
applied.

documentation
-------------

Build sphinx documentation (including updated READMEs for every recipe) and
pushes the changes to
[bioconda.github.io](https://github.com/bioconda/bioconda.github.io).

bioconda-utils tests
--------------------

Unit tests and functional tests for bioconda-utils

test building bioconda-utils docker image
-----------------------------------------

Ensures that bioconda-utils can run inside a newly-built container.


ensure Biocontainers are public
-------------------------------

Checks quay.io to see if any containers are mistakenly private; if so makes them public

conventional PRs
----------------

Enforces "conventional commit" tags in the title of PRs, like "docs:", "fix:", "ci:", and so on.

release-please
--------------

Collects PRs that have been merged to master since the last release into
a separate, special PR. Merging that special PR triggers a new release.

master branch tests
-------------------

Runs the same tests, but on the master branch. Note that when the bot merges,
it uses [ci skip] in the commit comment and works with the already-built
artifacts, so this doesn't typically run.


nightly maintenance
-------------------
Various maintenance tasks:

- build and upload the bioconda-repodata-patches package
- try to build and upload any remaining packages (runs bioconda-utils build on *all* recipes)

automerge
---------

This is intended to automatically merge PRs when all checks pass (including the
review step). It will only be triggered if the AutoMergeTrigger workflow runs
successfully.

automerge trigger
-----------------

If a PR's review is submitted or dismissed, or a PR is labeled with
"automerge", then this workflow fires, and needs to complete before the
AutoMerge workflow will run.

bulk
----
If pushing to the special ``bulk`` branch, this workflow will run. It uses
special bioconda-utils functionality to split the full DAG into sub-DAGs and
submits them to independent parallel jobs. When recipes sucessfully build, they
are *immediately* uploaded. Use with caution. Typically used when migrating
(e.g., bioconductor updates, pinning updates)

comment responder
-----------------

Runs the bioconda-bot container (quay.io/bioconda/bot) with different image tags (merge, comment, update, repost) in response to comments.

| Functionality                             | Provider        | Repo             | Schedule                 | Code links                                                                                                                                                                                   | OS         |
+===========================================+=================+==================+==========================+==============================================================================================================================================================================================+============+
| autobump bot                              | CircleCI        | bioconda-utils   | hourly                   | [config.yml](https://github.com/bioconda/bioconda-utils/blob/master/.circleci/config.yml#L65)                                                                                                | linux      |
| documentation                             | GitHub Actions  | bioconda-docs    | daily, or on push        | [docs.yml](https://github.com/bioconda/bioconda-docs/blob/main/.github/workflows/docs.yml)                                                                                                   | linux      |
| bioconda-utils tests                      | GitHub Actions  | bioconda-utils   | on push                  | [GithubActionTests.yml](https://github.com/bioconda/bioconda-utils/blob/master/.github/workflows/GithubActionTests.yml)                                                                      | linux, osx |
| test building bioconda-utils docker image | GitHub Actions  | bioconda-utils   | on push                  | [build-image.yml](https://github.com/bioconda/bioconda-utils/blob/master/.github/workflows/build-image.yml), [Dockerfile](https://github.com/bioconda/bioconda-utils/blob/master/Dockerfile) | linux      |
| ensure Biocontainers are public           | GitHub Actions  | bioconda-utils   | manually                 | [changevisibility.yml](https://github.com/bioconda/bioconda-utils/blob/master/.github/workflows/changevisibility.yml)                                                                        | linux      |
| conventional PRs                          | GitHub Actions  | bioconda-utils   | PR open/reopen/edit/sync | [conventional-prs.yml](https://github.com/bioconda/bioconda-utils/blob/master/.github/workflows/conventional-prs.yml)                                                                        | linux      |
| release-please                            | GitHub Actions  | bioconda-utils   | push to master           | [release-please.yml](https://github.com/bioconda/bioconda-utils/blob/master/.github/workflows/release-please.yml)                                                                            | linux      |
| issue responder                           | GitHub Actions  | bioconda-utils   | respond to @bioconda-bot |                                                                                                                                                                                              | linux      |
| PR linting and tests                      | Azure Pipelines | bioconda-recipes | on push                  | [azure-pipeline.yml](https://github.com/bioconda/bioconda-recipes/blob/master/azure-pipeline.yml)                                                                                            | linux, osx |
| master branch tests                       | Azure Pipelines | bioconda-recipes | push to master           | [azure-pipeline-master.yml](https://github.com/bioconda/bioconda-recipes/blob/master/azure-pipeline-master.yml)                                                                              | linux, osx |
| nightly maintenance                       | Azure Pipelines | bioconda-recipes | daily                    | [azure-pipeline-nightly.yml](https://github.com/bioconda/bioconda-recipes/blob/master/azure-pipeline-nightly.yml)                                                                            | linux, osx |
| automerge (not currently working)         | GitHub Actions  | bioconda-recipes | completed check suite    | [AutoMerge.yml](https://github.com/bioconda/bioconda-recipes/blob/master/.github/workflows/AutoMerge.yml)                                                                                    | linux      |
| automerge trigger                         | GitHub Actions  | bioconda-recipes | "automerge" label added  | [AutoMergeTrigger.yml](https://github.com/bioconda/bioconda-recipes/blob/master/.github/workflows/AutoMergeTrigger.yml)                                                                      | linux      |
| bulk                                      | GitHub Actions  | bioconda-recipes | push to bulk             | [Bulk.yml](https://github.com/bioconda/bioconda-recipes/blob/master/.github/workflows/Bulk.yml)                                                                                              | linux,osx  |
| comment responder                         | GitHub Actions  | bioconda-recipes | @bioconda-bot mentions   | [CommentResponder.yml](https://github.com/bioconda/bioconda-recipes/blob/master/.github/workflows/CommentResponder.yml)                                                                      | linux      |

