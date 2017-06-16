semi
====
Versatile Docker entrypoint script allowing the creation of configuration files from ERB templates


Configuration File
------------------
Configuration file is expected at /etc/semi.conf or as specified by the
SEMI_CONF environmental variable.

    ---
    defaults:
      PATH: /usr/bin:/bin
      server: foomatic.test.com
    validate:
      server:
        - required
        - string
      PATH: required, string
    files:
      - /etc/some.conf
      - /etc/another.conf
    commands:
      README: cat /README.md
      readme: cat /README.md
      