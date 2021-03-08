# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import alcali with context %}

alcali-service-clean-service-dead:
  service.dead:
    - name: {{ alcali.service.name }}

alcali-file-absent-service-dead:
  file.absent:
    - name: /etc/systemd/system/{{ alcali.service.name }}.service
  module.run:
    - name: service.systemctl_reload
