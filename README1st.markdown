# blank

This is a blank puppet module.

# Usage

Use this module to start a new blank puppet module with all the required components ready for submitting to Puppet Forge.

## Create a new blank module

1. Clone this repository:
     git clone -o puppet-blank -b master git://github.com/Aethylred/puppet-blank.git /path/to/new/repository

## Windows scripts

Provided are some Powershell scripts that can be used to manage the blank puppet module template.

## Enable execution of unsigned scripts

Powershell will not run unsigned scripts by default, this can be enabled by executing the following command in an Administrator Powershell. This is required before any of the other powershell scripts will run.

1. Click *Start* menu
2. Type "powershell" in the *Search programs and files* box, do not press enter.
3. When *Powershell* shows up in the search results, right click and select *Run as administrator*
4. Windows UAC may ask for permission to run as an administrator, click *Yes*
5. Run the following command in the administrator Powershell:
     set-executionpolicy remotesigned
6. Press *Enter* again to confirm the policy change

## Change author and module

This updates the author and module name using the `.orig` templates. This script can be re-run, creating new templates. This may not be advisable in later stages of module development.

1. Start Powershell in the blank module directory
2. Run the `unblank.ps1` script:
     ./setauthor.ps1 newauthor newmodule

# Frequently Asked Questions

More like questions that should be asked.

## Why not use the puppet module generator?

This module started with the standard module generation using 

     puppet module generate blank

...so why not continue to use it?

This module is intended for:

1. Writing a module where puppet is not or can not be installed

2. Use as a starting point for a collection of modules and prepopulated with things like licensing, boiler plate, pictures of cats, etc. etc.