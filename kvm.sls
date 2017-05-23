processor_has_hardware_virtualization_extensions:
  cmd.run:
    - name: grep -qE '^flags.*\b(vmx|svm)\b' /proc/cpuinfo

virt-manager:
  pkg.installed:
    - require:
      - cmd: processor_has_hardware_virtualization_extensions
