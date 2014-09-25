package App::Goto2;

use strict;
use warnings;
use 5.10.0;
our $VERSION = '0.01';
use Data::Dumper;

use MooseX::App::Simple qw(Color ConfigHome);

option 'iterate' => (
    is => 'ro',
    isa => 'Bool',
    documentation => q/Connect to all matching hosts one after the other/,
);

sub run {
    my ($self) = @_;

    my $hostre = join '.*', @{ $self->extra_argv };

    error("Must supply string to match host(s)") unless $hostre;

    my $hosts = $self->_config_data->{hosts};

    my @matching_hosts = grep { m/$hostre/ } sort keys %$hosts;

    error("No matching hosts found") unless @matching_hosts;

    # Either iterate over all matching hosts, or just use the first
    for my $host ( @matching_hosts ) {
        my $cmd = $self->generate_ssh_cmd($hosts->{$host});
        say "Executing command: $cmd";
        system( $cmd );
        exit unless $self->iterate;
    }
}

sub generate_ssh_cmd {
    my ($self, $host) = @_;

    my $cmd = 'ssh';

    $cmd .= ' -p ' . $host->{port} . ' ' if $host->{port};
    $cmd .= ' -i ~/.ssh/' . $host->{ssh_key} . ' ' if $host->{ssh_key};

    $cmd .= ' ' . $host->{user} . '@' if $host->{user};
    $cmd .= $host->{hostname};

    return $cmd;
}

sub error {
    my ($msg) = @_;
    say $msg;
    exit 1;
}

1;
__END__

=encoding utf-8

=head1 NAME

App::Goto2 - Easily SSH to many servers

=head1 SYNOPSIS

  use App::Goto2;

=head1 DESCRIPTION

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

=head1 AUTHOR

Dominic Humphries E<lt>dominic@oneandoneis2.comE<gt>

=head1 COPYRIGHT

Copyright 2014- Dominic Humphries

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

App::Goto, App::Goto::Amazon

=cut
