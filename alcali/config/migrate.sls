# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import alcali with context %}

include:
  - {{ tplroot }}.package.install
  - .file

alcali-config-migrate-db-provision-cmd-run:
  cmd.run:
    - name: ./manage.py migrate
    - cwd: {{ alcali.deploy.directory }}/code/
    - prepend_path: {{ alcali.deploy.directory }}/.venv/bin/
    - runas: {{ alcali.deploy.user }}
    - env:
        ENV_PATH: {{ alcali.deploy.directory }}
    - require:
      - virtualenv: alcali-package-install-virtualenv-managed
      - file: alcali-config-file-file-managed
    - onchanges:
      - git: alcali-package-install-git-latest
      - file: alcali-config-file-file-managed
