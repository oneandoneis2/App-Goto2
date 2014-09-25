requires 'perl', '5.008005';

requires 'MooseX::App::Simple';
requires 'Net::Amazon::EC2';

on test => sub {
    requires 'Test::More', '0.88';
};
