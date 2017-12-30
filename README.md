semi
====
Versatile Docker entrypoint script allowing the creation of configuration files from ERB templates


Configuration File
------------------
Configuration file is expected at /etc/semi.conf or as specified by the
SEMI_CONF environmental variable.

The configuration file is nothing more than a YAML file with four principal
sections: defaults, validate, files and commands. Each of these sections
further explained elsewhere in this README file.

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
      default: bundle exec unicorn -E production -c unicorn.rb


Defaults
--------
The defaults section will supply a value for any variable that has not been
specified in the environment. Currently there is a bug that if a value is
defined but is set to an empty string in the environment, the default value
will not override the environment.

Validators
----------
Validators allow one to insure that the value of a variable is within a
specified range. Each key of the validate section is a name of a variable
that can be used in the ERB templates. The values are one or more
validation expressions to test the values against. The values may be
specified as a comma seperated string or as an array.

* required

    Ensures that a value is defined for the variable. If a value is not
    defined, then the container will exit with a message detailing
    which variable has not been set.

* string

    Validate that the value is generally considered a string.

* integer

    Test the value to see if it is an integer. Floating point numbers
    will require another validator.

* boolean

    This validator attempts to determine if the value is boolean value.

* Regular Expression

    For validations that are not specified, one is able to specify a 
    regular expression to validate a value. The regular expression must
    start and end with a slash (/). 

Future plans are to include more validators for validating values like
hostnames, IPs, host/port combinations, filenames and URLs.

Filenames
---------
The filenames section list all the configuration files that ned to be
processed as ERB templates. The full ERB template syntax is supported.

Commands
--------
Additional commands can be added to the container in the commands section.
This is useful for adding automation and providing simple commands to
activate more complex commands in the container.

There is one special value (default) that will be used when the entrypoint
is not provided any arguements.

Templates
---------
Configuration files are marked up using standard ERB template statements.

All variables used in ERB templates need to be specified as lower case.

Debugging
---------
Simple debugging output can be enabled by defining the environmental
variable $SEMI_DEBUG. As long as the variable is set to any value, debug
statements will be sent to the stdout file handle.

At this time the only real debug output is the command that will be
executed by semi.
