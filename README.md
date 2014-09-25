# NAME

App::Goto2 - Easily SSH to many servers

# SYNOPSIS

    use App::Goto2;

# DESCRIPTION

App::Goto2 is intended to take the strain out of having a large number of servers you
frequently have to access via SSH. It allows you to set up nicknames, use partial hostnames,
and auto-detect available AWS EC2 instances and work out which one(s) you actually want. It
also allows for iterating over a number of machines one after the other, and the specification
of an optional command to be run on the remote machine(s).

Written by somebody who frequently had to SSH to a vast number of machines in multiple
domains, with SSH running on numerous ports, with a variety of usernames, using a variety of
SSH keys; and got sick of trying to remember all the details when writing for loops to
remotely execute commands on them all.

You can get a lot of the same functionality (port/user/aliases/etc) just by updating your
ssh config file, but (a) it's harder to share a config file, (b) it wouldn't have the EC2
integration and (c) it doesn't lend itself to wildcards so well.

# AUTHOR

Dominic Humphries <dominic@oneandoneis2.com>

# COPYRIGHT

Copyright 2014- Dominic Humphries

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

App::Goto, App::Goto::Amazon
